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

- (id)init:(FMApiRequestSongInfo *)info
completion:(void (^)(FMApiResponse *)) completeBlock
  errBlock:(void (^)(NSError *)) errBlock;

@end
