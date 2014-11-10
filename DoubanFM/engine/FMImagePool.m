//
//  FMImagePool.m
//  DoubanFM
//
//  Created by exitingchen on 14/11/10.
//  Copyright (c) 2014年 nirvawolf. All rights reserved.
//

#import "FMImagePool.h"
#import "AFNetworking.h"

@interface FMImagePool ()

@property (nonatomic,retain) NSCache *imageCache;
@property (nonatomic,retain) AFHTTPRequestOperationManager *requestManager;

@end

@implementation FMImagePool

+ (instancetype)sharedPool
{
    static id s_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        s_instance = [[[self class] alloc] _init];
    });
    
    return s_instance;
}

- (id)_init
{
    if (self = [super init]) {
        _imageCache = [[NSCache alloc] init];
        _requestManager = [[AFHTTPRequestOperationManager manager] retain];
        _requestManager.responseSerializer = [[[AFImageResponseSerializer alloc] init] autorelease];
    }
    return self;
}

- (void)imageByURL:(NSString *)url completion:(void (^)(UIImage *,BOOL))comleteBlock
{
    if (!url) {
        return;
    }
    
    UIImage *requestedImage = [_imageCache objectForKey:url];
    if (requestedImage) {
        comleteBlock(requestedImage,YES);
    }else{
        [_requestManager GET:url
                  parameters:nil
                     success:^(AFHTTPRequestOperation *afOperation,id respObj){
                         UIImage *respImg = [UIImage imageWithData:afOperation.responseData];
                         [_imageCache setObject:respImg forKey:url];
                         comleteBlock(respImg,NO);
                 }
                     failure:^(AFHTTPRequestOperation *afOperation,NSError *error){
                         NSLog(@"Image download failed! %@",[error localizedDescription]);
                 }];
    }
}


@end
