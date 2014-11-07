//
//  FMUpdateManager.m
//  DoubanFM
//
//  Created by exitingchen on 14/11/7.
//  Copyright (c) 2014年 nirvawolf. All rights reserved.
//

#import "FMUpdateManager.h"
#import "FMRequestService.h"
#import "FMChannelUpdator.h"

@implementation FMUpdateManager

+ (instancetype)sharedManager
{
    static id s_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        s_instance = [[[self class] alloc] _init];
    });
    
    return s_instance;
}

- (id)_init
{
    if(self = [super init]){
        
    }
    
    return self;
}

- (void)startUpdating
{
    [[FMChannelUpdator sharedUpdator] update];
}

@end
