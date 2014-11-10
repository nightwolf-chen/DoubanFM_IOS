//
//  FMImagePool.h
//  DoubanFM
//
//  Created by exitingchen on 14/11/10.
//  Copyright (c) 2014年 nirvawolf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FMImagePool : NSObject

+ (instancetype)sharedPool;

- (void)imageByURL:(NSString *)url completion:(void (^)(UIImage *image,BOOL cached)) comleteBlock;

@end
