//
//  FMApiResponseUser.h
//  DoubanFM
//
//  Created by nirvawolf on 26/5/14.
//  Copyright (c) 2014 nirvawolf. All rights reserved.
//

#import "FMApiResponse.h"

@class FMUser;

@interface FMApiResponseUser : FMApiResponse

@property (nonatomic,retain) FMUser *user;
@property (nonatomic,assign) BOOL isSuccess;

@end
