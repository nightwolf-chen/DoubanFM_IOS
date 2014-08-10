//
//  FMApiRequestChannel.m
//  DoubanFM
//
//  Created by nirvawolf on 26/5/14.
//  Copyright (c) 2014 nirvawolf. All rights reserved.
//

#import "FMApiRequestChannel.h"
#import "FMChannel.h"
#import "FMApiResponseChannel.h"
#import "FMHttpClient.h"
#import "FMRequestType.h"

@implementation FMApiRequestChannel

- (NSString *)getRequestURL
{
    return  [NSString stringWithFormat:@"%@:%@/j/app/radio/channels",self.protocool,self.domaimName];
}

- (FMRequestType)getRequestType
{
    return FMRequestTypeChannel;
}

- (FMApiResponse *)parseData:(NSData *)data
{
    return [[[FMApiResponseChannel alloc] initWithData:data] autorelease];
}

- (void)sendRequest
{
    [self.httpClient doGet:self.requestURL];
}
@end
