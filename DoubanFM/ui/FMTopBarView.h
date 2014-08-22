//
//  FMTopBarView.h
//  DoubanFM
//
//  Created by exitingchen on 14-8-22.
//  Copyright (c) 2014年 nirvawolf. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum FMTopBarViewType{
    FMTopBarViewTypeTabbar,
    FMTopBarViewTypePresentedTopbar,
}FMTopBarViewType;

@interface FMTopBarView : UIView

+ (float)tabbarViewHight;

+ (CGPoint)tabbarOrigin;

+ (id)topbarWithType:(FMTopBarViewType) type;

@end

