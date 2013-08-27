//
//  MLVAFParseAPIClient.m
//  GolfCalculator
//
//  Created by Lance Velasco on 8/27/13.
//  Copyright (c) 2013 MLV Group. All rights reserved.
//

#import "MLVAFParseAPIClient.h"
#import "AFJSONRequestOperation.h"


static NSString * const kMLVFParseAPIBaseURLString = @"https://api.parse.com/1/";

static NSString * const kMLVFParseAPIApplicationId = @"m0b38I9m6RcHUJDziPBrROZ7N2By8dXT3xiybzy7";
static NSString * const kMLVFParseAPIKey = @"MrGwniUkOjrFi00Jshy4Md2sRXuWxpq1q75mm4rZ";

@implementation MLVAFParseAPIClient

+ (MLVAFParseAPIClient *)sharedClient {
    static MLVAFParseAPIClient *sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedClient = [[MLVAFParseAPIClient alloc] initWithBaseURL:[NSURL URLWithString:kMLVFParseAPIBaseURLString]];
    });
    
    return sharedClient;
}

- (id)initWithBaseURL:(NSURL *)url {
    self = [super initWithBaseURL:url];
    if (self) {
        [self registerHTTPOperationClass:[AFJSONRequestOperation class]];
        [self setParameterEncoding:AFJSONParameterEncoding];
        [self setDefaultHeader:@"X-Parse-Application-Id" value:kMLVFParseAPIApplicationId];
        [self setDefaultHeader:@"X-Parse-REST-API-Key" value:kMLVFParseAPIKey];
    }
    
    return self;
    
}

- (NSMutableURLRequest *)GETRequestForClass:(NSString *)className parameters:(NSDictionary *)parameters {
    NSMutableURLRequest *request = nil;
    request = [self requestWithMethod:@"GET" path:[NSString stringWithFormat:@"classes/%@", className] parameters:parameters];
    return request;
}

- (NSMutableURLRequest *)GETRequestForAllRecordsOfClass:(NSString *)className updatedAfterDate:(NSDate *)updatedDate {
    NSMutableURLRequest *request = nil;
    NSDictionary *parameters = nil;
    if (updatedDate) {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.'999Z'"];
        [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
        
        NSString *jsonString = [NSString
                                stringWithFormat:@"{\"updatedAt\":{\"$gte\":{\"__type\":\"Date\",\"iso\":\"%@\"}}}",
                                [dateFormatter stringFromDate:updatedDate]];
        
        parameters = [NSDictionary dictionaryWithObject:jsonString forKey:@"where"];
    }
    
    request = [self GETRequestForClass:className parameters:parameters];
    return request;
}

@end
