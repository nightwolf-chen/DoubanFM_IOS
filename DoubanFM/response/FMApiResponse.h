//
//  FMApiResponse.h
//  DoubanFM
//
//  Created by nirvawolf on 26/5/14.
//  Copyright (c) 2014 nirvawolf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMRequestType.h"

@interface FMApiResponse : NSObject

@property (nonatomic,assign) FMRequestType requestType;

- (id)initWithData:(NSData *)data;

@end
