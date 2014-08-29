//
//  FMTack.m
//  DoubanFM
//
//  Created by exitingchen on 14-8-29.
//  Copyright (c) 2014年 nirvawolf. All rights reserved.
//

#import "FMTack.h"
#import "FMSong.h"

@interface FMTack ()

@property (nonatomic,retain) FMSong* song;

@end

@implementation FMTack

- (id)init
{
    if (self = [super init]) {
        _song = nil;
    }
    
    return self;
}

- (id)initWithSong:(FMSong *)song
{
    if (self = [self init]) {
        _song = [song retain];
    }
    
    return self;
}

+ (id)trackWithSong:(FMSong *)song
{
    return [[[FMTack alloc] initWithSong:song] autorelease];
}


- (NSURL *)audioFileURL
{
    return [NSURL URLWithString:_song.songUrl];
}
@end
