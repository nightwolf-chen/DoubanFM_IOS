//
//  NSNotificationCenter+DoubanFM.h
//  DoubanFM
//
//  Created by exitingchen on 14/11/11.
//  Copyright (c) 2014年 nirvawolf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSNotificationCenter(DoubanFM)

- (void)postOnMainNotificationName:(NSString *)aName object:(id)anObject;
- (void)postOnMainNotificationName:(NSString *)aName object:(id)anObject userInfo:(NSDictionary *)aUserInfo;

@end
