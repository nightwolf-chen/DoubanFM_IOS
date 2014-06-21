//
//  FMChannelCell.h
//  DoubanFM
//
//  Created by nirvawolf on 21/6/14.
//  Copyright (c) 2014 nirvawolf. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FMChannel;

@interface FMChannelCell : UITableViewCell

@property (retain, nonatomic) IBOutlet UIImageView *channelImgView;
@property (retain, nonatomic) IBOutlet UILabel *channelNameLabel;

@property (retain, nonatomic) IBOutlet UILabel *introLabel;

@property (retain, nonatomic) FMChannel *channel;

@end
