//
//  FMApiResponseUser.m
//  DoubanFM
//
//  Created by nirvawolf on 26/5/14.
//  Copyright (c) 2014 nirvawolf. All rights reserved.
//

#import "FMApiResponseUser.h"
#import "FMUser.h"

@implementation FMApiResponseUser

- (id)initWithData:(NSData *)data
{
    self = [super init];
    
    if (self) {
        _user = [[FMUser alloc] init];
        
        NSDictionary *jsonData = [self paserJsonData:data];
        
        if ( [[jsonData objectForKey:@"r"] intValue] == 0) {
            
            _isSuccess = YES;
            
            _user.email = [jsonData objectForKey:@"email"];
            _user.expire = [jsonData objectForKey:@"expire"];
            _user.token = [jsonData objectForKey:@"token"];
            _user.userid = [jsonData objectForKey:@"user_id"];
            _user.username = [jsonData objectForKey:@"user_name"];
            
        }else{
            _isSuccess = NO;
        }
    }
    
    return self;
}

- (NSDictionary *)paserJsonData:(NSData *)data
{
    NSError *error;
    NSDictionary *jsonData = [NSJSONSerialization JSONObjectWithData:data
                                                             options:NSJSONReadingMutableLeaves
                                                               error:&error];
    return jsonData;
}

@end
