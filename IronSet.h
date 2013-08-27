//
//  IronSet.h
//  GolfCalculator
//
//  Created by Lance Velasco on 8/27/13.
//  Copyright (c) 2013 MLV Group. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface IronSet : NSManagedObject

@property (nonatomic, retain) NSString * clubDistanceRange;
@property (nonatomic, retain) NSString * updatedAt;
@property (nonatomic, retain) NSNumber * syncStatus;
@property (nonatomic, retain) NSDecimalNumber * spin;
@property (nonatomic, retain) NSDecimalNumber * shotShaping;
@property (nonatomic, retain) NSDecimalNumber * precision;
@property (nonatomic, retain) NSString * objectId;
@property (nonatomic, retain) NSString * make;
@property (nonatomic, retain) NSString * model;
@property (nonatomic, retain) NSNumber * level;
@property (nonatomic, retain) NSData * image;
@property (nonatomic, retain) NSNumber * ironSetId;
@property (nonatomic, retain) NSString * fullTitle;
@property (nonatomic, retain) NSDecimalNumber * forgiveness;
@property (nonatomic, retain) NSString * desc;
@property (nonatomic, retain) NSDate * createdAt;
@property (nonatomic, retain) NSNumber * clubKey;

@end
