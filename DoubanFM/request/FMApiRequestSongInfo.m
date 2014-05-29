//
//  FMApiRequestSongInfo.m
//  DoubanFM
//
//  Created by nirvawolf on 29/5/14.
//  Copyright (c) 2014 nirvawolf. All rights reserved.
//

#import "FMApiRequestSongInfo.h"

char typeString[SongRequestTypeCount] = "bersunp";

@implementation FMApiRequestSongInfo

- (id)initWith:(SongRequestType)type song:(NSString *)songId channel:(NSString *)channelId
{
    self = [super init];
    
    if (self) {
        _type = type;
        _songId = [songId copy];
        _channelId = [channelId copy];
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
