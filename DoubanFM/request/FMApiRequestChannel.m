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


- (id)initWithDelegate:(id)delegate
{
    self = [super initWithDelegate:delegate];
    
    if (self) {
        self.requestURL = [NSString stringWithFormat:@"%@:%@/j/app/radio/channels",self.protocool,self.domaimName];
        self.requestType = FMRequestTypeChannel;
    }
    
    return self;
}

- (void)client:(FMHttpClient *)client didFinishLoadingData:(NSData *)data
{
    FMApiResponse *userResponse = [[[FMApiResponseChannel alloc] initWithData:data] autorelease];
    [self.delegate didRecieveResponse: userResponse];
}

- (void)sendRequest
{
    [self.httpClient doGet:self.requestURL];
}
@end
