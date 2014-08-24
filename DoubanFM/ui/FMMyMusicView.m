//
//  FMMyMusicView.m
//  DoubanFM
//
//  Created by nirvawolf on 17/8/14.
//  Copyright (c) 2014 nirvawolf. All rights reserved.
//

#import "FMMyMusicView.h"
#import "FMPlayerView.h"
#import "FMPlayerViewController.h"
#import "FMUserCenterController.h"
#import "FMLoginViewController.h"
#import "FMOffilineViewController.h"
#import "FMFavoriteViewController.h"
#import "FMSettingsViewController.h"
#import "FMLocalSongsViewController.h"

typedef enum FMMusicViewCellType{
    FMMusicViewCellTypeUserInfo = 0,
    FMMusicViewCellTypeOffline,
    FMMusicViewCellTypeLocalSongs,
    FMMusicViewCellTypeFavorite,
    FMMusicViewCellTypeSettings,
}FMMusicViewCellType;

@interface FMMyMusicView ()
{
    NSArray *_controllerClasses;
}

@end

static const int kCellHeight[] = {200,60,60,60,60};

@implementation FMMyMusicView

- (void)dealloc
{
    [_controllerClasses release];
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView setDataSource:self];
        [_tableView setDelegate:self];
        [self addSubview:_tableView];
        
        _controllerClasses = @[
                               [FMLoginViewController class],
                               [FMOffilineViewController class],
                               [FMLocalSongsViewController class],
                               [FMFavoriteViewController class],
                               [FMSettingsViewController class]
                               ];
        
        [_controllerClasses retain];
    }
    
    return self;
}

#pragma mark - UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *const reuseableIdentifier = @"reuseableTableCell";
    UITableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:reuseableIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseableIdentifier];
        [cell autorelease];
    }
    
    [self setCell:cell forCellType:(FMMusicViewCellType)indexPath.row];
    
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kCellHeight[indexPath.row];
}

- (void)setCell:(UITableViewCell *)cell forCellType:(FMMusicViewCellType)type
{
    
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    
    switch (type) {
        case FMMusicViewCellTypeUserInfo:
        {
            cell.backgroundColor = [UIColor blackColor];
            [cell setAccessoryType:UITableViewCellAccessoryNone];
        }
            break;
            
        case FMMusicViewCellTypeOffline:
        {
            cell.textLabel.text = @"我的离线";
        }
            break;
        case FMMusicViewCellTypeLocalSongs:
        {
            cell.textLabel.text = @"手机里的歌曲";
        }
            break;
        case FMMusicViewCellTypeFavorite:
        {
            cell.textLabel.text = @"我的收藏";
        }
            break;
        case FMMusicViewCellTypeSettings:
        {
            cell.textLabel.text = @"设置";
        }
            break;
    }
}

- (void)handleTableViewSelected:(FMMusicViewCellType)type{
   
    Class aClass = _controllerClasses[type];
    
    UIViewController *ctr = [[aClass alloc] initWithNibName:nil bundle:nil];
    
    if (type == FMMusicViewCellTypeUserInfo) {
        [(FMLoginViewController *)ctr showViewWithAnimaition];
    }else{
        [APP_DELEGATE.navigationController pushViewController:ctr animated:YES];
        APP_DELEGATE.navigationController.navigationBarHidden = NO;
    }
    
    [ctr release];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self handleTableViewSelected:(FMMusicViewCellType)indexPath.row];
}



@end
