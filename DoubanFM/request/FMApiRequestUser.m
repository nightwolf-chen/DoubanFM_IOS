//
//  FMApiRequestUser.m
//  DoubanFM
//
//  Created by nirvawolf on 26/5/14.
//  Copyright (c) 2014 nirvawolf. All rights reserved.
//

#import "FMApiRequestUser.h"
#import "FMHttpClient.h"
#import "FMUser.h"
#import "FMApiResponseUser.h"

@implementation FMApiRequestUser

- (id)initWithDelegate:(id)delegate user:(FMUser *)user
{
    self = [super initWithDelegate:delegate];
    
    if (self) {
        _user = user;
        _isLogin = NO;
        self.requestURL = [NSString stringWithFormat:@"%@:%@/j/app/login",self.protocool,self.domaimName];
    }
    
    return self;
}

- (void)client:(FMHttpClient *)client didFinishLoadingData:(NSData *)data
{
    FMApiResponse *userResponse = [[[FMApiResponseUser alloc] initWithData:data] autorelease];
    [self.delegate didRecieveResponse: userResponse];
}

- (void)sendRequest
{
    NSDictionary *values = @{
                            @"email": self.user.email,
                            @"password" : self.user.password,
                            @"version" : @"100",
                            @"app_name" : @"radio_desktop_win"
                            };
    
    [self.httpClient doPost:self.requestURL parameters:values];
}
@end
