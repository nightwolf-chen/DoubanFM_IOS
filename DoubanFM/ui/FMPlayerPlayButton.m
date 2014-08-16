//
//  FMPlayerPlayButton.m
//  DoubanFM
//
//  Created by nirvawolf on 16/8/14.
//  Copyright (c) 2014 nirvawolf. All rights reserved.
//

#import "FMPlayerPlayButton.h"

@implementation FMPlayerPlayButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

+ (CGSize)sSize
{
    return CGSizeMake(40, 40);
}

+ (CGSize)bSize
{
    return CGSizeMake(160, 160);
}
@end
