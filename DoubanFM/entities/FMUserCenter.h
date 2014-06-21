//
//  FMUserCenter.h
//  DoubanFM
//
//  Created by nirvawolf on 21/6/14.
//  Copyright (c) 2014 nirvawolf. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FMUser;

@interface FMUserCenter : NSObject

@property (retain ,nonatomic) FMUser *user;
@property (assign ,nonatomic) BOOL isLogin;

+ (FMUserCenter *)sharedCenter;

@end
