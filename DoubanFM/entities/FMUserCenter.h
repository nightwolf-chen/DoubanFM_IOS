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

@property (readonly ,nonatomic) FMUser *user;
@property (readonly ,nonatomic) BOOL isLogin;

+ (FMUserCenter *)sharedCenter;

- (void)login:(FMUser *)user;
- (void)logout;

@end
