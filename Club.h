//
//  Club.h
//  GolfCalculator
//
//  Created by Lance Velasco on 8/27/13.
//  Copyright (c) 2013 MLV Group. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Club : NSManagedObject

@property (nonatomic, retain) NSDecimalNumber * balance;
@property (nonatomic, retain) NSNumber * putterThreeDistance;
@property (nonatomic, retain) NSNumber * putterFourDistance;
@property (nonatomic, retain) NSDate * updatedAt;
@property (nonatomic, retain) NSNumber * syncStatus;
@property (nonatomic, retain) NSNumber * putterFiveDistance;
@property (nonatomic, retain) NSNumber * putterTwoDistance;
@property (nonatomic, retain) NSNumber * putterSixDistance;
@property (nonatomic, retain) NSDecimalNumber * shotShaping;
@property (nonatomic, retain) NSDecimalNumber * spin;
@property (nonatomic, retain) NSString * type;
@property (nonatomic, retain) NSString * putterSixLabel;
@property (nonatomic, retain) NSString * putterFiveLabel;
@property (nonatomic, retain) NSString * putterThreeLabel;
@property (nonatomic, retain) NSString * putterFourLabel;
@property (nonatomic, retain) NSString * putterOneLabel;
@property (nonatomic, retain) NSString * putterTwoLabel;
@property (nonatomic, retain) NSDecimalNumber * precision;
@property (nonatomic, retain) NSString * pitchDistance;
@property (nonatomic, retain) NSString * model;
@property (nonatomic, retain) NSString * make;
@property (nonatomic, retain) NSNumber * level;
@property (nonatomic, retain) NSNumber * ironSetId;
@property (nonatomic, retain) NSString * fullTitle;
@property (nonatomic, retain) NSData * image;
@property (nonatomic, retain) NSDecimalNumber * forgiveness;
@property (nonatomic, retain) NSNumber * fullDistance;
@property (nonatomic, retain) NSNumber * flopDistance;
@property (nonatomic, retain) NSString * desc;
@property (nonatomic, retain) NSDate * createdAt;
@property (nonatomic, retain) NSNumber * clubKey;
@property (nonatomic, retain) NSNumber * chipDistance;
@property (nonatomic, retain) NSNumber * putterOneDistance;
@property (nonatomic, retain) NSNumber * punchDistance;

@end
