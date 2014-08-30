//
//  FMPlayerManager.h
//  DoubanFM
//
//  Created by nirvawolf on 30/8/14.
//  Copyright (c) 2014 nirvawolf. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FMPlayer;

@interface FMPlayerManager : NSObject

@property (nonatomic,readonly) FMPlayer *activePlayer;

+ (instancetype)sharedInstance;

@end
