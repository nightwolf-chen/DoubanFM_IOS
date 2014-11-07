//
//  FMApiRequestShow.m
//  DoubanFM
//
//  Created by exitingchen on 14/11/7.
//  Copyright (c) 2014年 nirvawolf. All rights reserved.
//

#import "FMApiRequestShowList.h"
#import "FMApiResponseShowList.h"
#import "FMHttpClient.h"

@implementation FMApiRequestShowList

- (NSString *)getRequestURL
{
    return @"http://douban.fm";
}

- (FMRequestType)getRequestType
{
    return FMRequestTypeShowList;
}

- (FMApiResponse *)parseData:(NSData *)data
{
    return [[[FMApiResponseShowList alloc] initWithData:data] autorelease];
}

- (void)sendRequest
{
    [self.httpClient sendRequest:self.requestURL type:@"GET" parameters:@{}];
}

@end
