//
//  FMPlayerAnimationCalculator.m
//  DoubanFM
//
//  Created by exitingchen on 14-8-15.
//  Copyright (c) 2014年 nirvawolf. All rights reserved.
//

#import "FMPlayerAnimationCalculator.h"

@implementation FMPlayerAnimationCalculator

+ (float)calculateCurrentValue:(float)start end:(float)end rate:(float)rate
{
    return start + (end - start) * rate;
}

+ (float)calculateRate:(float)start end:(float)end current:(float)cur
{
    NSAssert(start-end!=0, @"Cannot devide 0!");
    return (cur - start) / (end - start);
}

+ (CGPoint)calculateCurrentPoint:(CGPoint)start end:(CGPoint)end rate:(float)rate
{
    int x = [self calculateCurrentValue:start.x end:end.x rate:rate];
    int y = [self calculateCurrentValue:start.y end:end.y rate:rate];
    return CGPointMake(x, y);
}

+ (CGSize)calculateCurrentSize:(CGSize)start end:(CGSize)end rate:(float)rate
{
    int h = [self calculateCurrentValue:start.height end:end.height rate:rate];
    int w = [self calculateCurrentValue:start.width end:end.width rate:rate];
    return CGSizeMake(w,h);
}

+ (CGRect)calculateCurrentRect:(CGRect)start end:(CGRect)end rate:(float)rate
{
    int x = [self calculateCurrentValue:start.origin.x end:end.origin.x rate:rate];
    int y = [self calculateCurrentValue:start.origin.y end:end.origin.y rate:rate];
    int w = [self calculateCurrentValue:start.size.width end:end.size.width rate:rate];
    int h = [self calculateCurrentValue:start.size.height end:end.size.height rate:rate];
    return CGRectMake(x, y, w, h);
}

@end

