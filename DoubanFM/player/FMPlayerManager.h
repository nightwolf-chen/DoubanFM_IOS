//
//  FMPlayerManager.h
//  DoubanFM
//
//  Created by nirvawolf on 30/8/14.
//  Copyright (c) 2014 nirvawolf. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FMPlayer;
@class FMChannel;

@interface FMPlayerManager : NSObject

@property (nonatomic,readonly) FMPlayer *activePlayer;
@property (nonatomic,readonly) FMChannel *currentChannel;

+ (instancetype)sharedInstance;

+ (FMChannel *)defaultChannel;
@end
