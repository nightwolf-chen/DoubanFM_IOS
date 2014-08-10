//
//  FMApiRequest.h
//  DoubanFM
//
//  Created by nirvawolf on 26/5/14.
//  Copyright (c) 2014 nirvawolf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMHttpClientDelegate.h"
#import "FMApiRequestDelegate.h"
#import "../FMRequestType.h"

@class FMHttpClient;

@interface FMApiRequest : NSObject<FMHttpClientDelegate>

@property (nonatomic,copy) NSString *requestURL;
@property (nonatomic,copy,readonly) NSString *domaimName;
@property (nonatomic,copy,readonly) NSString *protocool;
@property (nonatomic,retain,readonly) FMHttpClient *httpClient;
@property (nonatomic,retain) id<FMApiRequestDelegate> delegate;
@property (nonatomic,assign) FMRequestType requestType;

- (id)initWithDelegate:(id)delegate;

- (void)sendRequest;

@end
