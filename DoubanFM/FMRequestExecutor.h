//
//  FMRequestExecutor.h
//  DoubanFM
//
//  Created by exitingchen on 14-7-21.
//  Copyright (c) 2014年 nirvawolf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMApiRequestDelegate.h"

@class FMApiRequest;
@class FMApiResponse;

@interface FMRequestExecutor : NSObject<FMApiRequestDelegate>

@property (nonatomic,retain,readonly) FMApiRequest *request;
@property (nonatomic,copy) void (^completeBlock)(FMApiResponse *response);

- (id)initWithRequest:(FMApiRequest *)request complete:(void (^)(FMApiResponse *response)) completeBlock;
- (void)execute;

@end
