//
//  FMRequestService.h
//  DoubanFM
//
//  Created by exitingchen on 14/11/6.
//  Copyright (c) 2014年 nirvawolf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMUser.h"
#import "FMChannel.h"
#import "FMSong.h"

#import "FMApiRequest.h"
#import "FMApiRequestSong.h"
#import "FMApiRequestSongInfo.h"
#import "FMApiRequestChannel.h"
#import "FMApiRequestUser.h"
#import "FMApiRequestShowList.h"
#import "FMApiRequestShow.h"

#import "FMApiResponse.h"
#import "FMApiResponseChannel.h"
#import "FMApiResponseUser.h"
#import "FMApiResponseSong.h"
#import "FMApiResponseShowList.h"
#import "FMApiResponseShow.h"
#import "FMShow.h"

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

- (void)sendShowListRequestWithSuccess:(void (^)(FMApiResponse *))successBlock
                                 error:(void (^)(NSError *))errorBlock;

- (void)sendShowRequestWithSuccess:(void (^)(FMApiResponse *))successBlock
                             error:(void (^)(NSError *))errorBlock
                              show:(FMShow *)show;
@end
