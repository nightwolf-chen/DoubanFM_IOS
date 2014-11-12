//
//  FMSettings.h
//  DoubanFM
//
//  Created by exitingchen on 14/11/12.
//  Copyright (c) 2014年 nirvawolf. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FMChannel;

@interface FMSettings : NSObject

@property (nonatomic,retain) FMChannel *currentChannel;

+ (instancetype)settings;

@end
