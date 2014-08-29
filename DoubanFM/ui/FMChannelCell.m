//
//  FMChannelCell.m
//  DoubanFM
//
//  Created by nirvawolf on 21/6/14.
//  Copyright (c) 2014 nirvawolf. All rights reserved.
//

#import "FMChannelCell.h"
#import "../util/FMMacros.h"
#import "FMChannel.h"

@implementation FMChannelCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

- (void)setChannel:(FMChannel *)channel
{
    SAFE_DELETE(_channel);
    _channel = [channel retain];
    
    [self.channelNameLabel setText:_channel.nameCN];
    [self.introLabel setText:_channel.introduction];
    
    NSData *imgData = [NSData dataWithContentsOfURL:[NSURL URLWithString:_channel.coverImgUrl]];
    UIImage *img = [UIImage imageWithData:imgData];
    [self.channelImgView setImage:img];
}

- (void)dealloc {
    [_channelImgView release];
    [_channelNameLabel release];
    [_introLabel release];
    [_channel release];
    
    [super dealloc];
}
@end
