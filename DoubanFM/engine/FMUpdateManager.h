//
//  FMUpdateManager.h
//  DoubanFM
//
//  Created by exitingchen on 14/11/7.
//  Copyright (c) 2014年 nirvawolf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FMUpdateManager : NSObject

+ (instancetype)sharedManager;

- (void)startUpdating;

@end
