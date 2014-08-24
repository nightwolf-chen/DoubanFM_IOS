//
//  FMMyMusicControllerViewController.m
//  DoubanFM
//
//  Created by nirvawolf on 23/8/14.
//  Copyright (c) 2014 nirvawolf. All rights reserved.
//

#import "FMMyMusicController.h"
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


@interface FMMyMusicController ()
{
    NSArray *_controllerClasses;
}
@end

static const int kCellHeight[] = {200,60,60,60,60};

@implementation FMMyMusicController

- (void)dealloc
{
    [_controllerClasses release];
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        self.tabBarItem.title = @"我的FM";
        
        _tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        [_tableView setDataSource:self];
        [_tableView setDelegate:self];
        
        [self.view addSubview:_tableView];
        
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
        [self.navigationController pushViewController:ctr animated:YES];
        [self.navigationController setNavigationBarHidden:NO animated:YES];
    }
    
    [ctr release];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self handleTableViewSelected:(FMMusicViewCellType)indexPath.row];
}
@end
