//
//  FMPlayerManager.m
//  DoubanFM
//
//  Created by nirvawolf on 30/8/14.
//  Copyright (c) 2014 nirvawolf. All rights reserved.
//

#import "FMPlayerManager.h"
#import "FMPlayer.h"

@implementation FMPlayerManager

+ (instancetype)sharedInstance
{
    static id _instance;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[FMPlayerManager alloc] init];
    });
    
    return _instance;
}

- (id)init
{
    NSAssert(NO,@"Must use sharedManager");
    return nil;
}

- (id)_init
{
    if (self = [super init]) {
        _activePlayer = [[FMPlayer defaultPlayer] retain];
    }
    return self;
}
@end
