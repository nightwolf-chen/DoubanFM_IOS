//
//  FMApiResponseShow.m
//  DoubanFM
//
//  Created by exitingchen on 14/11/7.
//  Copyright (c) 2014年 nirvawolf. All rights reserved.
//

#import "FMApiResponseShow.h"
#import "FMChannel.h"

@implementation FMApiResponseShow

- (id)initWithData:(NSData *)data
{
    self = [super init];
    
    if (self) {
        
        if (data) {
            _channels = [self paserJsonDataForChannels:data];
        }
    }
    
    return self;
}

- (NSArray *)paserJsonDataForChannels:(NSData *)data
{
    NSError *error;
    NSDictionary *obj = [NSJSONSerialization JSONObjectWithData:data
                                                        options:NSJSONReadingMutableLeaves
                                                          error:&error];
    
    NSDictionary *dataObj = [obj objectForKey:@"data"];
    NSArray *channelObjects = [dataObj objectForKey:@"channels"];
    NSMutableArray *channels = [NSMutableArray arrayWithCapacity:channelObjects.count];
    
    for (NSDictionary *channelData in channelObjects) {
        
        FMChannel *channel = [[FMChannel alloc] init];
        channel.nameCN = [channelData objectForKey:@"name"];
        channel.nameEn = [channelData objectForKey:@"name_en"];
        channel.channelId = [[channelData objectForKey:@"channel_id"] intValue];
        channel.addr_en = [channelData objectForKey:@"abbr_en"];
        
        [channels addObject:channel];
        
        [channel release];
    }
    
    return channels;
}

@end
