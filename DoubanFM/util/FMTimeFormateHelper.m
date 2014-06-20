//
//  FMTimeFormateHelper.m
//  DoubanFM
//
//  Created by nirvawolf on 20/6/14.
//  Copyright (c) 2014 nirvawolf. All rights reserved.
//

#import "FMTimeFormateHelper.h"

@implementation FMTimeFormateHelper


+ (NSString *)generateTimeStr:(double)time
{
    int iTime = time;
    int second = iTime % 60;
    iTime /= 60;
    int minus = iTime % 60;
    iTime /= 60;
    int hour = iTime % 60;
    
    NSString *timeString = [NSString stringWithFormat:@"%@:%@:%@",
                            [FMTimeFormateHelper generateTimeIntStr:hour],
                            [FMTimeFormateHelper generateTimeIntStr:minus],
                            [FMTimeFormateHelper generateTimeIntStr:second]
                            ];
    
    return timeString;
}


+ (NSString *)generateTimeIntStr:(int)a
{
    if (a >= 0 && a < 10) {
        return [NSString stringWithFormat:@"0%d",a];
    }else{
        return [NSString stringWithFormat:@"%d",a];
    }
}
@end
