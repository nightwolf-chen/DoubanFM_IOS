//
//  FMUIPlayerDelegate.h
//  DoubanFM
//
//  Created by nirvawolf on 17/6/14.
//  Copyright (c) 2014 nirvawolf. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FMUIPlayer;

@protocol FMUIPlayerDelegate <NSObject>

@required
- (void)player:(FMUIPlayer *)player currentTime:(double)time totalTime:(double)duration;
- (void)playerNeedsMoreSongs:(FMUIPlayer *)player;
- (void)playerIsLoadingSong:(FMUIPlayer *)player;
@end
