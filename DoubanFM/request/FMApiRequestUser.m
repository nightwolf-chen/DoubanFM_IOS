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
#import "FMRequestType.h"

@implementation FMApiRequestUser

- (id)init:(FMUser *)user completion:(void (^)(FMApiResponse *))completeBlock errBlock:(void (^)(NSError *))errBlock
{
    self = [super initWithComplete:completeBlock errBlock:errBlock];
    
    if (self) {
        _user = [user retain];
        _isLogin = NO;
    }
    
    return self;
}

- (NSString *)getRequestURL
{
    return [NSString stringWithFormat:@"%@:%@/j/app/login",self.protocool,self.domaimName];
}

- (FMRequestType)getRequestType
{
    return FMRequestTypeUser;
}

- (FMApiResponse *)parseData:(NSData *)data
{
    return [[[FMApiResponseUser alloc] initWithData:data] autorelease];
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
