//
//  FMApiResponseChannel.m
//  DoubanFM
//
//  Created by nirvawolf on 26/5/14.
//  Copyright (c) 2014 nirvawolf. All rights reserved.
//

#import "FMApiResponseChannel.h"
#import "FMChannel.h"

@implementation FMApiResponseChannel

- (id)initWithData:(NSData *)data
{
    self = [super init];
    
    if (self) {
        _channels = [self paserJsonDataForChannels:data];
        _categories = [[NSDictionary alloc] init];
    }
    
    return self;
}

- (NSArray *)paserJsonDataForChannels:(NSData *)data
{
    NSError *error;
    NSDictionary *obj = [NSJSONSerialization JSONObjectWithData:data
                                                        options:NSJSONReadingMutableLeaves
                                                          error:&error];
    
    NSArray *channelObjects = [obj objectForKey:@"channels"];
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
