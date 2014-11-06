//
//  FMUIPlayer.h
//  DoubanFM
//
//  Created by nirvawolf on 15/6/14.
//  Copyright (c) 2014 nirvawolf. All rights reserved.
//

#import "FMAVPlayerAdapter.h"
#import "FMPlayer.h"

extern const NSString *FMUIPLayerNeedsNewSongsNotification;

@class FMSong;
@protocol FMAVPlayerAdapterDelegate;


@interface FMAVPlayerAdapter : FMPlayer
@property (nonatomic,assign) id<FMAVPlayerAdapterDelegate> delegate;
@end


@protocol FMAVPlayerAdapterDelegate <NSObject>
@required
- (void)player:(FMAVPlayerAdapter *)player currentTime:(double)time totalTime:(double)duration;
- (void)playerNeedsMoreSongs:(FMAVPlayerAdapter *)player;
- (void)playerIsLoadingSong:(FMAVPlayerAdapter *)player;
@end



