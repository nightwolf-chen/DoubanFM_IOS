//
//  FMPlayerCircleProgressView.h
//  DoubanFM
//
//  Created by nirvawolf on 7/9/14.
//  Copyright (c) 2014 nirvawolf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FMPlayerCircleProgressView : UIView

@property (nonatomic,assign) CGFloat percent;
@property (nonatomic,assign) CGFloat lineWidth;
@property (nonatomic,readonly) UIButton *buttonAttachedTo;

- (id)initWithUIButton:(UIButton *)button;

@end
