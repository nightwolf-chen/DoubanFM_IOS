//
//  FMApiRequestShow.h
//  DoubanFM
//
//  Created by exitingchen on 14/11/7.
//  Copyright (c) 2014年 nirvawolf. All rights reserved.
//

#import "FMApiRequest.h"

@class FMShow;

@interface FMApiRequestShow : FMApiRequest

- (id)initWithComplete:(void (^)(FMApiResponse *))completeBlock errBlock:(void (^)(NSError *))errBlock show:(FMShow *)show;

@end
