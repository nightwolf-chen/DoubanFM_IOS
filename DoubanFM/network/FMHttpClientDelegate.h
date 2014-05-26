//
//  FMHttpClientDelegate.h
//  DoubanFM
//
//  Created by nirvawolf on 25/5/14.
//  Copyright (c) 2014 nirvawolf. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FMHttpClient;

@protocol FMHttpClientDelegate <NSObject>

@required -(void)client:(FMHttpClient *)client didFinishLoadingData:(NSData *)data;
@required -(void)client:(FMHttpClient *)client didFailWithError:(NSError *)error;
 
@end
