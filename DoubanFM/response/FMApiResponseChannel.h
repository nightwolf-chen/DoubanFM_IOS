//
//  FMApiResponseChannel.h
//  DoubanFM
//
//  Created by nirvawolf on 26/5/14.
//  Copyright (c) 2014 nirvawolf. All rights reserved.
//

#import "FMApiResponse.h"

@interface FMApiResponseChannel : FMApiResponse

@property (nonatomic,retain,readonly) NSArray *channels;
@property (nonatomic,retain,readonly) NSDictionary *categories;

@end
