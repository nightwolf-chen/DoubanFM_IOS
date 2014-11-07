//
//  FMHttpClient.h
//  DoubanFM
//
//  Created by nirvawolf on 25/5/14.
//  Copyright (c) 2014 nirvawolf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMHttpClientDelegate.h"

@interface FMHttpClient : NSObject<NSURLConnectionDataDelegate>

@property (nonatomic,retain) id<FMHttpClientDelegate> delegate;

- (id)initWithDelegate:(id<FMHttpClientDelegate>) delegate;

- (BOOL)doPost:(NSString *)urlStr parameters:(NSDictionary *)values;

- (BOOL)doGet:(NSString *)urlStr;

- (BOOL)doGet:(NSString *)urlStr parameters:(NSDictionary *)values;

+ (NSString *)dicToURLParameterString:(NSDictionary *)values;

- (BOOL)sendRequest:(NSString *) urlStr type:(NSString *)requestType parameters:(NSDictionary *)values;
@end
