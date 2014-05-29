//
//  FMApiRequestSong.m
//  DoubanFM
//
//  Created by nirvawolf on 26/5/14.
//  Copyright (c) 2014 nirvawolf. All rights reserved.
//

#import "FMApiRequestSong.h"
#import "FMApiRequestSongInfo.h"
#import "FMUser.h"
#import "FMHttpClient.h"
#import "FMApiResponseSong.h"


@implementation FMApiRequestSong

- (id)initWithDelegate:(id)delegate info:(FMApiRequestSongInfo *)info
{
    self = [super initWithDelegate:delegate];
    
    if (self) {
        self.requestURL = [NSString stringWithFormat:@"%@:%@/j/app/radio/people?app_name=radio_desktop_win&version=100",self.protocool,self.domaimName];
        [self addInfo:info];
    }
    
    return self;
}

#pragma mark - helpers

- (void)addInfo:(FMApiRequestSongInfo *)info
{
    NSMutableDictionary *values = [NSMutableDictionary dictionary];
    
    if (info.songId) {
        [values setValue:info.songId forKey:@"sid"];
    }
    
    if (info.channelId) {
        [values setValue:info.channelId forKey:@"channel"];
    }
    
    if (info.user) {
        [values setValue:info.user.userid forKey:@"user_id"];
        [values setValue:info.user.expire forKey:@"expire"];
        [values setValue:info.user.token forKey:@"token"];
    }
    
    [values setValue:[FMApiRequestSongInfo typeString:info.type] forKey:@"type"];
    
    NSString *parameters = [FMHttpClient dicToURLParameterString:values];
    
    self.requestURL = [self.requestURL stringByAppendingString:@"&"];
    self.requestURL = [self.requestURL stringByAppendingString:parameters];
    
}

- (void)sendRequest
{
    [self.httpClient doGet:self.requestURL];
}

#pragma mark - delegate

- (void)client:(FMHttpClient *)client didFailWithError:(NSError *)error
{
    [self.delegate didFailWithError:error];
}

- (void)client:(FMHttpClient *)client didFinishLoadingData:(NSData *)data
{
    FMApiResponseSong *response = [[[FMApiResponseSong alloc] initWithData:data] autorelease];
    [self.delegate didRecieveResponse:response];
}

@end

