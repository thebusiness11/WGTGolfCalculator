//
//  MLVSyncEngine.h
//  GolfCalculator
//
//  Created by Lance Velasco on 8/27/13.
//  Copyright (c) 2013 MLV Group. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MLVSyncEngine : NSObject

@property (atomic, readonly) BOOL syncInProgress;

+ (MLVSyncEngine *)sharedEngine;

- (void)registerNSManagedObjectClassToSync:(Class)aClass;
- (void)startSync;


@end
