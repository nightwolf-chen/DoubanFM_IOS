//
//  FMPlayItem.m
//  DoubanFM
//
//  Created by nirvawolf on 30/8/14.
//  Copyright (c) 2014 nirvawolf. All rights reserved.
//

#import "FMPlayItem.h"
#import "FMSong.h"

@implementation FMPlayItem

- (id)init
{
    NSAssert(NO, @"Must use initWithSong: or itemWithSong:!");
    return nil;
}

- (id)initWithSong:(FMSong *)song
{
    if (self = [super initWithURL:[NSURL URLWithString:song.songTitle]]) {
        _song = [song retain];
    }
    return self;
}

- (id)itemWithSong:(FMSong *)song
{
    return [[self initWithSong:song] autorelease];
}

@end
