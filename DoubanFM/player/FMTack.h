//
//  FMTack.h
//  DoubanFM
//
//  Created by exitingchen on 14-8-29.
//  Copyright (c) 2014年 nirvawolf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DOUAudioFile.h"

@class FMSong;

@interface FMTack : NSObject<DOUAudioFile>

+ (id)trackWithSong:(FMSong *)song;

- (id)initWithSong:(FMSong *)song;

- (id)init;

@end
