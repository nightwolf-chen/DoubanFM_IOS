//
//  FMUIPlayer.h
//  DoubanFM
//
//  Created by nirvawolf on 15/6/14.
//  Copyright (c) 2014 nirvawolf. All rights reserved.
//

#import "FMPlayer.h"
#import "FMUIPlayerDelegate.h"

extern const NSString *FMUIPLayerNeedsNewSongsNotification;

@class FMSong;

@interface FMUIPlayer : FMPlayer

@property (nonatomic,retain) NSMutableArray *songQueue;
@property (nonatomic,retain) id<FMUIPlayerDelegate> delegate;

- (id)initWithSongs:(NSArray *)songs delegate:(id)delegate;

- (void)start;
- (void)next;

- (FMSong *)getPlayingSong;

@end
