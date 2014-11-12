//
//  FMUserCenter.m
//  DoubanFM
//
//  Created by nirvawolf on 21/6/14.
//  Copyright (c) 2014 nirvawolf. All rights reserved.
//

#import "FMUserCenter.h"
#import "FMUser.h"
#import "FMDatabaseManager.h"

static FMUserCenter * _instance;

@interface FMUserCenter ()

@property (retain ,nonatomic) FMUser *user;
@property (assign ,nonatomic) BOOL isLogin;

@end

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
        
        FMDatabaseHelper *helper = [FMDatabaseManager sharedManager].helper;
        NSArray *users = [helper getUsers];
        
        if (users.count > 0) {
            [self login:users[0]];
        }
    }
    
    return self;
}

- (void)login:(FMUser *)user
{
    self.user = user;
    self.isLogin = YES;
    
    [self.user syncWithDatabase];
}

- (void)logout
{
    [self.user deleteFromDatabase];
    self.user = nil;
    self.isLogin = NO;
}

@end
