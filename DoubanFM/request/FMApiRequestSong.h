//
//  FMApiRequestSong.h
//  DoubanFM
//
//  Created by nirvawolf on 26/5/14.
//  Copyright (c) 2014 nirvawolf. All rights reserved.
//

#import "FMApiRequest.h"

@class FMApiRequestSongInfo;

@interface FMApiRequestSong : FMApiRequest

- (id)initWithDelegate:(id)delegate info:(FMApiRequestSongInfo *)info;

@end
