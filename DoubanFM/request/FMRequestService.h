//
//  FMRequestService.h
//  DoubanFM
//
//  Created by exitingchen on 14/11/6.
//  Copyright (c) 2014年 nirvawolf. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FMApiRequest;
@class FMApiResponse;
@class FMUser;
@class FMApiRequestSongInfo;

@interface FMRequestService : NSObject

+ (instancetype)sharedService;

- (void)sendUserAuthRequest:(FMUser *)user
                    success:(void (^)(FMApiResponse *))successBlock
                      error:(void (^)(NSError *))errorBlock;

- (void)sendFectchChannelRequestWithSuccess:(void (^)(FMApiResponse *))successBlock
                                      error:(void (^)(NSError *))errorBlock;

- (void)sendSongOperation:(FMApiRequestSongInfo *)info
                  success:(void (^)(FMApiResponse *))successBlock
                    error:(void (^)(NSError *))errorBlock;
@end
