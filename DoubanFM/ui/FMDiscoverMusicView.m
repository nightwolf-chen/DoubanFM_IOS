//
//  FMDiscoverMusicView.m
//  DoubanFM
//
//  Created by nirvawolf on 17/8/14.
//  Copyright (c) 2014 nirvawolf. All rights reserved.
//

#import "FMDiscoverMusicView.h"
#import "FMPlayerView.h"
#import "FMTabbarView.h"

@implementation FMDiscoverMusicView

static const float kButtonHight = 40;

static const float kHzButtonOriginX = 0;
static const float kHzButtonOriginY = 0;
static const float kHzButtonWidth = 130;

static const float kShowButtonOriginX = kHzButtonOriginX + kHzButtonWidth;
static const float kShowButtonOriginY = kHzButtonOriginY;
static const float kShowButtonWidth = kHzButtonWidth;

static const float kSearchButtonOriginX = kShowButtonOriginX + kShowButtonWidth;
static const float kSearchButtonOriginY = kShowButtonOriginY;
static const float kSearchButtonWidth = 320 - kHzButtonWidth - kShowButtonWidth;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor grayColor];
        
        _hzButton = [[UIButton alloc] initWithFrame:CGRectMake(kHzButtonOriginX, kHzButtonOriginY, kHzButtonWidth, kButtonHight)];
        [_hzButton setTitle:@"MHz" forState:UIControlStateNormal];
        _hzButton.backgroundColor = [UIColor orangeColor];
        
        _showButton = [[UIButton alloc] initWithFrame:CGRectMake(kShowButtonOriginX, kShowButtonOriginY, kShowButtonWidth, kButtonHight)];
        [_showButton setTitle:@"Show" forState:UIControlStateNormal];
        _showButton.backgroundColor = [UIColor orangeColor];
        
        _searchButton = [[UIButton alloc] initWithFrame:CGRectMake(kSearchButtonOriginX, kSearchButtonOriginY, kSearchButtonWidth, kButtonHight)];
        [_searchButton setTitle:@"S" forState:UIControlStateNormal];
        _searchButton.backgroundColor = [UIColor orangeColor];
        
        
        [self addSubview:_hzButton];
        [self addSubview:_showButton];
        [self addSubview:_searchButton];
        
        
        float tableViewHight = SCREEN_SIZE.height - [FMPlayerView smallPlayerHeight] - kButtonHight - [FMTabbarView tabbarViewHight];
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kButtonHight,SCREEN_SIZE.width, tableViewHight)
                                                  style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        
        [self addSubview:_tableView];
    }
    return self;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *const reuseableIdentifier = @"tableViewCell";
    UITableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:reuseableIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseableIdentifier];
        [cell autorelease];
    }
    
    cell.contentView.backgroundColor = [UIColor blueColor];
    
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 30;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}
@end
