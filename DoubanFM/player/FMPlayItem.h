//
//  FMPlayItem.h
//  DoubanFM
//
//  Created by nirvawolf on 30/8/14.
//  Copyright (c) 2014 nirvawolf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@class FMSong;

@interface FMPlayItem : AVPlayerItem

@property (nonatomic,readonly) FMSong *song;

- (id)initWithSong:(FMSong *)song;
- (id)itemWithSong:(FMSong *)song;

@end
