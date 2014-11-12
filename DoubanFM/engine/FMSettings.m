//
//  FMSettings.m
//  DoubanFM
//
//  Created by exitingchen on 14/11/12.
//  Copyright (c) 2014年 nirvawolf. All rights reserved.
//

#import "FMSettings.h"
#import "FMChannel.h"

static NSString *const kFMSettingsCurrentChannel = @"kFMSettingsCurrentChannel";
static NSString *const kFMSettings = @"kFMSettings";

@implementation FMSettings

- (id)init
{
    if (self = [super init]) {
        FMChannel *channel = [[[FMChannel alloc] init] autorelease];
        channel.channelId = 0;
        channel.nameCN = @"华语";
        
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:channel];
        NSDictionary *dic = @{kFMSettingsCurrentChannel:data};
        [[NSUserDefaults standardUserDefaults] registerDefaults:@{kFMSettings:dic}];
        
    }
    
    return self;
}

+ (instancetype)settings
{
    return [[[[self class] alloc] init] autorelease];
}

- (void)setCurrentChannel:(FMChannel *)currentChannel
{
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:currentChannel];
    [self p_setValue:data forKey:kFMSettingsCurrentChannel];
}

- (FMChannel *)currentChannel
{
     return [NSKeyedUnarchiver unarchiveObjectWithData:[self p_objectForKey:kFMSettingsCurrentChannel]];
}

- (void)p_setValue:(id)value forKey:(NSString *)key
{
    NSMutableDictionary *dic = [[[NSUserDefaults standardUserDefaults] objectForKey:kFMSettings] mutableCopy];
    [dic autorelease];
    dic[key] = value;
    [[NSUserDefaults standardUserDefaults] setObject:dic forKey:kFMSettings];
}

- (id)p_objectForKey:(NSString *)key
{
    NSDictionary *dic = [[NSUserDefaults standardUserDefaults] objectForKey:kFMSettings];
    return dic[key];
}

@end
