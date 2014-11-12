//
//  FMUserCenter.m
//  DoubanFM
//
//  Created by nirvawolf on 21/6/14.
//  Copyright (c) 2014 nirvawolf. All rights reserved.
//

#import "FMUserCenter.h"
#import "FMUser.h"

static FMUserCenter * _instance;

@implementation FMUserCenter

+ (FMUserCenter *)sharedCenter
{
    if (!_instance) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            _instance = [[FMUserCenter alloc] _init];
        });
    }
    
    return _instance;
}

- (id)init
{
    NSAssert(NO, @"Use shared instance instead!");
    return nil;
}

- (id)_init
{
    self = [super init];
    
    if (self) {
        _user = nil;
        _isLogin = NO;
    }
    
    return self;
}

- (void)setUser:(FMUser *)user
{
    if (_user) {
        [_user release];
    }
    
    _user = [user retain];
    
    [_user syncWithDatabase];
}
@end
