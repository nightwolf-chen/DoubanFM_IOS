//
//  FMApiRequestUser.h
//  DoubanFM
//
//  Created by nirvawolf on 26/5/14.
//  Copyright (c) 2014 nirvawolf. All rights reserved.
//

#import "FMApiRequest.h"

@class FMUser;

@interface FMApiRequestUser : FMApiRequest

@property (nonatomic,retain,readonly) FMUser *user;
@property (nonatomic,assign,readonly) BOOL isLogin;

- (id)init:(FMUser *)user
completion:(void (^)(FMApiResponse *)) completeBlock
  errBlock:(void (^)(NSError *)) errBlock;

@end
