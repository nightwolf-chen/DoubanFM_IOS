//
//  FMApiRequest.m
//  DoubanFM
//
//  Created by nirvawolf on 26/5/14.
//  Copyright (c) 2014 nirvawolf. All rights reserved.
//

#import "FMApiRequest.h"
#import "FMHttpClient.h"

@implementation FMApiRequest

- (id)initWithDelegate:(id)delegate
{
    self = [super init];
    
    if(self)
    {
        _domaimName = @"www.douban.com";
        _protocool = @"http";
        _httpClient = [[FMHttpClient alloc] initWithDelegate:self];
        _delegate = [delegate retain];
    }
    
    return self;
}

#pragma mark - override methods blow in subclass.

- (void)sendRequest
{
    NSAssert(NO, @"Overide this method for custom action.");
}

- (void)client:(FMHttpClient *)client didFinishLoadingData:(NSData *)data
{
    NSAssert(NO, @"Overide this method for custom action.");
}

- (void)client:(FMHttpClient *)client didFailWithError:(NSError *)error
{
    [self.delegate didFailWithError:error];
}
@end
