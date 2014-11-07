//
//  FMChannelUpdator.h
//  DoubanFM
//
//  Created by exitingchen on 14/11/7.
//  Copyright (c) 2014年 nirvawolf. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString *const kFMChannelUpdatorDidUpdateChannels;
extern NSString *const kFMChannelUpdatorDidUpdateShows;
extern NSString *const kFMChannelUpdatorFailed;

@interface FMChannelUpdator : NSObject

+ (instancetype)sharedUpdator;

- (void)update;
- (void)updateShows;
- (void)updateClassicalChannels;

@end
