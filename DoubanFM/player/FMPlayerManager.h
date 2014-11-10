//
//  FMPlayerManager.h
//  DoubanFM
//
//  Created by nirvawolf on 30/8/14.
//  Copyright (c) 2014 nirvawolf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMPlayer.h"

extern NSString *const FMPlayerManagerChannelChanged;

extern NSString *const FMPlayerManagerChannelChangedKeyChannel;

@class FMChannel;

@interface FMPlayerManager : NSObject<FMPlayerDelegate>

@property (nonatomic,readonly) FMPlayer *activePlayer;
@property (nonatomic,retain) FMChannel *currentChannel;

+ (instancetype)sharedInstance;

+ (FMChannel *)defaultChannel;
@end
