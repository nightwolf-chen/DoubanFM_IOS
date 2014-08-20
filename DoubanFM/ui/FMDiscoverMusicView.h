//
//  FMDiscoverMusicView.h
//  DoubanFM
//
//  Created by nirvawolf on 17/8/14.
//  Copyright (c) 2014 nirvawolf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FMDiscoverMusicView : UIView<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,retain) UIButton *hzButton;
@property (nonatomic,retain) UIButton *showButton;
@property (nonatomic,retain) UIButton *searchButton;
@property (nonatomic,retain) UITableView *tableView;

@end
