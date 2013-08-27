//
//  MLVCoreDataController.h
//  GolfCalculator
//
//  Created by Lance Velasco on 8/27/13.
//  Copyright (c) 2013 MLV Group. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MLVCoreDataController : NSObject

+ (id)sharedInstance;

- (NSURL *)applicationDocumentsDirectory;

- (NSManagedObjectContext *)masterManagedObjectContext;
- (NSManagedObjectContext *)backgroundManagedObjectContext;
- (NSManagedObjectContext *)newManagedObjectContext;
- (void)saveMasterContext;
- (void)saveBackgroundContext;
- (NSManagedObjectModel *)managedObjectModel;
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator;

@end
