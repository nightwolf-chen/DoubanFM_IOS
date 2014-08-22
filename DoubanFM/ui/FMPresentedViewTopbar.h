//
//  FMPresentedViewTopbar.h
//  DoubanFM
//
//  Created by exitingchen on 14-8-22.
//  Copyright (c) 2014年 nirvawolf. All rights reserved.
//

#import "FMTopBarView.h"

@interface FMPresentedViewTopbar : FMTopBarView

@property (nonatomic,retain) UIButton *cancleButton;
@property (nonatomic,copy) void (^buttonClickedBlock)();

@end
