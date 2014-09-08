//
//  FMPlayerPlayButton.m
//  DoubanFM
//
//  Created by nirvawolf on 16/8/14.
//  Copyright (c) 2014 nirvawolf. All rights reserved.
//

#import "FMPlayerPlayButton.h"
#import "FMPlayerCircleProgressView.h"


@implementation FMPlayerPlayButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
       
    }
    return self;
}

- (id)initSmaillOrigin:(CGPoint)bOrigin bigOrigin:(CGPoint)sOrigin
{
    self = [super initSmaillOrigin:bOrigin bigOrigin:sOrigin];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.clipsToBounds = YES;
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

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    self.layer.cornerRadius = self.frame.size.width / 2.0f;
}
@end
