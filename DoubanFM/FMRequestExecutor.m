//
//  FMRequestExecutor.m
//  DoubanFM
//
//  Created by exitingchen on 14-7-21.
//  Copyright (c) 2014年 nirvawolf. All rights reserved.
//

#import "FMRequestExecutor.h"
#import "FMApiRequest.h"
#import "FMApiResponse.h"

@implementation FMRequestExecutor

- (id)initWithRequest:(FMApiRequest *)request complete:(void (^)(FMApiResponse *))completeBlock
{
    self = [super init];
    
    if (self) {
        _request = [request retain];
        _request.delegate = self;
        _completeBlock = Block_copy(completeBlock);
    }
    
    return self;
}

- (void)execute
{
    [self.request sendRequest];
}

- (void)didRecieveResponse:(FMApiResponse *)response
{
    response.requestType = self.request.requestType;
    self.completeBlock(response);
}

- (void)didFailWithError:(NSError *)error
{
    NSLog(@"Error ocurs when trying to execute %@",self.request);
}

- (void)dealloc
{
    [super dealloc];
    [_request release];
    Block_release(_completeBlock);
}

@end
