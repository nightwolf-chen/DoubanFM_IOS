//
//  FMApiRequestShow.m
//  DoubanFM
//
//  Created by exitingchen on 14/11/7.
//  Copyright (c) 2014年 nirvawolf. All rights reserved.
//

#import "FMApiRequestShow.h"
#import "FMShow.h"
#import "FMHttpClient.h"
#import "FMApiResponseShow.h"

@interface FMApiRequestShow ()

@property (nonatomic,copy) FMShow *showRequested;

@end

@implementation FMApiRequestShow

- (id)initWithComplete:(void (^)(FMApiResponse *))completeBlock errBlock:(void (^)(NSError *))errBlock show:(FMShow *)show
{
    if (self = [super initWithComplete:completeBlock errBlock:errBlock]) {
        _showRequested = [show retain];
    }
    
    return self;
}

- (NSString *)getRequestURL
{
    return @"http://douban.fm/j/explore/genre";
}

- (FMRequestType)getRequestType
{
    return FMRequestTypeShow;
}

- (FMApiResponse *)parseData:(NSData *)data
{
    return [[[FMApiResponseShow alloc] initWithData:data] autorelease];
}

- (void)sendRequest
{
    [self.httpClient doGet:self.requestURL parameters:@{@"gid":_showRequested.showid,@"start":@"0",@"limit":@"20"}];
}


@end
