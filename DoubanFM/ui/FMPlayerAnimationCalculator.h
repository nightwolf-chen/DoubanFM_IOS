//
//  FMPlayerAnimationCalculator.h
//  DoubanFM
//
//  Created by exitingchen on 14-8-15.
//  Copyright (c) 2014年 nirvawolf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FMPlayerAnimationCalculator : NSObject

+ (float)calculateCurrentValue:(float) start end:(float) end rate:(float) rate;

+ (CGPoint)calculateCurrentPoint:(CGPoint) start end:(CGPoint) end rate:(float) rate;

+ (CGRect)calculateCurrentRect:(CGRect) start end:(CGRect) end rate:(float) rate;

+ (CGSize)calculateCurrentSize:(CGSize) start end:(CGSize) end rate:(float) rate;

+ (float)calculateRate:(float) start end:(float) end current:(float)cur;

@end
