//
//  NSNotificationCenter+DoubanFM.m
//  DoubanFM
//
//  Created by exitingchen on 14/11/11.
//  Copyright (c) 2014年 nirvawolf. All rights reserved.
//

#import "NSNotificationCenter+DoubanFM.h"

@implementation NSNotificationCenter(DoubanFM)


- (void)postOnMainNotificationName:(NSString *)aName object:(id)anObject
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self postNotificationName:aName object:anObject];
    });
}
- (void)postOnMainNotificationName:(NSString *)aName object:(id)anObject userInfo:(NSDictionary *)aUserInfo
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self postNotificationName:aName object:anObject userInfo:aUserInfo];
    });
}

@end
