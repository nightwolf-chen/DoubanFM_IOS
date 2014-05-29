//
//  FMApiResponseSong.h
//  DoubanFM
//
//  Created by nirvawolf on 26/5/14.
//  Copyright (c) 2014 nirvawolf. All rights reserved.
//

#import "FMApiResponse.h"

@interface FMApiResponseSong : FMApiResponse

@property (nonatomic,retain) NSArray *songs;
@property (nonatomic,assign) BOOL isSuccess;
@property (nonatomic,assign) int versionMax;

@end
