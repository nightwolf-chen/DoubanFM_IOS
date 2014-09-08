//
//  FMApiRequest.h
//  DoubanFM
//
//  Created by nirvawolf on 26/5/14.
//  Copyright (c) 2014 nirvawolf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMHttpClientDelegate.h"
#import "../FMRequestType.h"

@class FMHttpClient;
@class FMApiResponse;

@interface FMApiRequest : NSObject<FMHttpClientDelegate>

@property (nonatomic,copy) NSString *requestURL;
@property (nonatomic,copy,readonly) NSString *domaimName;
@property (nonatomic,copy,readonly) NSString *protocool;
@property (nonatomic,retain,readonly) FMHttpClient *httpClient;
@property (nonatomic,assign) FMRequestType requestType;
@property (nonatomic,copy) void (^completeBlock)(FMApiResponse *response);
@property (nonatomic,copy) void (^errBlock)(NSError *error);

@property (nonatomic,assign) BOOL isFinished;

- (id)initWithComplete:(void (^)(FMApiResponse *)) completeBlock
              errBlock:(void (^)(NSError *)) errBlock;

- (FMApiResponse *)parseData:(NSData *)data;

- (NSString *)getRequestURL;

- (FMRequestType)getRequestType;

- (void)sendRequest;

@end
