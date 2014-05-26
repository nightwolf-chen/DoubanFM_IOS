//
//  FMApiRequestDelegate.h
//  DoubanFM
//
//  Created by nirvawolf on 26/5/14.
//  Copyright (c) 2014 nirvawolf. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FMApiResponse;

@protocol FMApiRequestDelegate <NSObject>

@required -(void)didRecieveResponse:(FMApiResponse *)response;
@required -(void)didFailWithError:(NSError *)error;

@end
