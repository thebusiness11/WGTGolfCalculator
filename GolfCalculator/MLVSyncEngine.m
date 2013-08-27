//
//  MLVSyncEngine.m
//  GolfCalculator
//
//  Created by Lance Velasco on 8/27/13.
//  Copyright (c) 2013 MLV Group. All rights reserved.
//

#import "MLVSyncEngine.h"
#import "MLVCoreDataController.h"
#import "AFHTTPRequestOperation.h"
#import "MLVAFParseAPIClient.h"
#import "AFJSONRequestOperation.h"

@interface MLVSyncEngine ()

@property (nonatomic, strong) NSMutableArray *registeredClassesToSync;

@end

@implementation MLVSyncEngine

@synthesize registeredClassesToSync = _registeredClassesToSync;
@synthesize syncInProgress = _syncInProgress;



+ (MLVSyncEngine *)sharedEngine {
    static MLVSyncEngine *sharedEngine = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedEngine = [[MLVSyncEngine alloc] init];
    });
    
    return sharedEngine;
}

- (void)registerNSManagedObjectClassToSync:(Class)aClass {
    if (!self.registeredClassesToSync) {
        self.registeredClassesToSync = [NSMutableArray array];
    }
    
    if ([aClass isSubclassOfClass:[NSManagedObject class]]) {
        if (![self.registeredClassesToSync containsObject:NSStringFromClass(aClass)]) {
            [self.registeredClassesToSync addObject:NSStringFromClass(aClass)];
        } else {
            NSLog(@"Unable to register %@ as it is already registered", NSStringFromClass(aClass));
        }
    } else {
        NSLog(@"Unable to register %@ as it is not a subclass of NSManagedObject", NSStringFromClass(aClass));
    }
    
}

- (void)startSync {
    if (!self.syncInProgress) {
        [self willChangeValueForKey:@"syncInProgress"];
        _syncInProgress = YES;
        [self didChangeValueForKey:@"syncInProgress"];
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
            [self downloadDataForRegisteredObjects:YES];
        });
    }
}

- (NSDate *)mostRecentUpdatedAtDateForEntityWithName:(NSString *)entityName {
    __block NSDate *date = nil;
    //
    // Create a new fetch request for the specified entity
    //
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:entityName];
    //
    // Set the sort descriptors on the request to sort by updatedAt in descending order
    //
    [request setSortDescriptors:[NSArray arrayWithObject:
                                 [NSSortDescriptor sortDescriptorWithKey:@"updatedAt" ascending:NO]]];
    //
    // You are only interested in 1 result so limit the request to 1
    //
    [request setFetchLimit:1];
    [[[MLVCoreDataController sharedInstance] backgroundManagedObjectContext] performBlockAndWait:^{
        NSError *error = nil;
        NSArray *results = [[[MLVCoreDataController sharedInstance] backgroundManagedObjectContext] executeFetchRequest:request error:&error];
        if ([results lastObject])   {
            //
            // Set date to the fetched result
            //
            date = [[results lastObject] valueForKey:@"updatedAt"];
        }
    }];
    
    return date;
}

- (void)downloadDataForRegisteredObjects:(BOOL)useUpdatedAtDate {
    NSMutableArray *operations = [NSMutableArray array];
    
    for (NSString *className in self.registeredClassesToSync) {
        NSDate *mostRecentUpdatedDate = nil;
        if (useUpdatedAtDate) {
            mostRecentUpdatedDate = [self mostRecentUpdatedAtDateForEntityWithName:className];
        }
        NSMutableURLRequest *request = [[MLVAFParseAPIClient sharedClient]
                                        GETRequestForAllRecordsOfClass:className
                                        updatedAfterDate:mostRecentUpdatedDate];
        AFJSONRequestOperation *operation =
        [AFJSONRequestOperation JSONRequestOperationWithRequest: request
                                                        success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON)
         {
             NSDictionary * responseObject = (NSDictionary * )JSON;
             if ([responseObject isKindOfClass:[NSDictionary class]]) {
                 NSLog(@"Response for %@: %@", className, responseObject);
//                 [self writeJSONResponse:responseObject toDiskForClassWithName:className];
             } else {
                 NSLog(@"response not Json");
             }
         }
                                                        failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
                                                            
                                                            NSLog(@"Request for class %@ failed with error: %@", className, error);
                                                        }];
        
        [operations addObject:operation];
    }
    
    [[MLVAFParseAPIClient sharedClient] enqueueBatchOfHTTPRequestOperations:operations progressBlock:^(NSUInteger numberOfCompletedOperations, NSUInteger totalNumberOfOperations) {
        
    } completionBlock:^(NSArray *operations) {
        NSLog(@"All operations completed");
        // 2
        // Need to process JSON records into Core Data
    }];
}



@end
