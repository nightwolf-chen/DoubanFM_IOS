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

- (void)dealloc
{
    Block_release(_completeBlock);
    Block_release(_errBlock);
    [_domaimName release];
    [_protocool release];
    [_httpClient release];
    
    [super dealloc];
}

- (id)init
{
    NSAssert(NO, @"Try use initWithComplete");
    return nil;
}

- (id)initWithComplete:(void (^)(FMApiResponse *))completeBlock errBlock:(void (^)(NSError *))errBlock
{
    self = [super init];
    
    if(self){
        _domaimName = @"www.douban.com";
        _protocool = @"http";
        _httpClient = [[FMHttpClient alloc] initWithDelegate:self];
        _completeBlock = Block_copy(completeBlock);
        _errBlock = Block_copy(errBlock);
        _requestURL = [[self getRequestURL] retain];
        _requestType = [self getRequestType];
        _isFinished = NO;
    }
    
    return self;
}

#pragma mark - override methods blow in subclass.

- (void)sendRequest
{
    NSAssert(NO, @"Overide this method for custom action.");
}

- (FMApiResponse *)parseData:(NSData *)data
{
    NSAssert(NO, @"This is a abstract method!");
    return nil;
}

- (NSString *)getRequestURL
{
    NSAssert(NO, @"This is a abstract method!");
    return nil;
}

- (FMRequestType)getRequestType
{
    NSAssert(NO, @"This is a abstract method!");
    return FMRequestTypeSong;
}

- (void)client:(FMHttpClient *)client didFinishLoadingData:(NSData *)data
{
    FMApiResponse *response = [self parseData:data];
    _completeBlock(response);
    
    self.isFinished = YES;
}

- (void)client:(FMHttpClient *)client didFailWithError:(NSError *)error
{
    _errBlock(error);
    
    self.isFinished = YES;
}
@end
