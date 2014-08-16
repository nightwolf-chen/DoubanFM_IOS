//
//  FMPlayerControlButton.h
//  DoubanFM
//
//  Created by exitingchen on 14-8-15.
//  Copyright (c) 2014年 nirvawolf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FMPlayerControlButton : UIButton

@property (nonatomic,assign) CGPoint bOrigin;
@property (nonatomic,assign) CGPoint sOrigin;
@property (nonatomic,assign) CGRect bFrame;
@property (nonatomic,assign) CGRect sFrame;

- (id)initSmaillOrigin:(CGPoint)bOrigin bigOrigin:(CGPoint)sOrigin;

+ (CGSize)sSize;

+ (CGSize)bSize;
@end
