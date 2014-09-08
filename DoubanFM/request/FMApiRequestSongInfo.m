//
//  FMApiRequestSongInfo.m
//  DoubanFM
//
//  Created by nirvawolf on 29/5/14.
//  Copyright (c) 2014 nirvawolf. All rights reserved.
//

#import "FMApiRequestSongInfo.h"
#import "FMSong.h"
#import "FMChannel.h"
char typeString[SongRequestTypeCount] = "bersunp";

@implementation FMApiRequestSongInfo

- (id)initWith:(SongRequestType)type song:(FMSong *)song channel:(FMChannel *)channel
{
    self = [super init];
    
    if (self) {
        _type = type;
        _songId = [song.sid copy];
        _channelId = [[NSString stringWithFormat:@"%d",channel.channelId] copy];
    }
    
    return self;
}

+ (NSString *)typeString:(SongRequestType)type
{
    NSArray *typeStrings = @[
                             @"b",
                             @"e",
                             @"r",
                             @"s",
                             @"u",
                             @"n",
                             @"p"
                             ];
    return [typeStrings objectAtIndex:(int)type];
}
@end
