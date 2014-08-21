//
//  FMTabarViewController.m
//  DoubanFM
//
//  Created by nirvawolf on 17/8/14.
//  Copyright (c) 2014 nirvawolf. All rights reserved.
//

#import "FMTabarViewController.h"
#import "FMTabbarView.h"
#import "FMPlayerView.h"
#import "FMDiscoverMusicView.h"
#import "FMMyMusicView.h"

@interface FMTabarViewController ()
{
    int _currentTabIndex;
}
@end

@implementation FMTabarViewController

- (id)init
{
    self = [super init];
    
    if (self) {
       
        _currentTabIndex = -1;
        
        FMDiscoverMusicView *discoverView = [[FMDiscoverMusicView alloc] init];
        FMMyMusicView *myMusicView = [[FMMyMusicView alloc] init];
        NSArray *tabviews = @[discoverView,myMusicView];
        
        _tabViews = [tabviews retain];
        
        [discoverView release];
        [myMusicView release];
        
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupHeader];
//    [self setupPlayerView];
    
    for(UIView *view in _tabViews){
        float y = _tabbarView.frame.origin.y + _tabbarView.frame.size.height;
        float h = SCREEN_SIZE.height - _tabbarView.frame.size.height;
        CGRect frame = CGRectMake(0,y, SCREEN_SIZE.width, h);
        view.frame = frame;
    }
    
    [self setSelectedTab:1];
    // Do any additional setup after loading the view.
}
- (void)setSelectedTab:(int)index
{
    if (_currentTabIndex >= 0) {
        [(UIView *)_tabViews[_currentTabIndex - 1] removeFromSuperview];
    }
    
    [self.view addSubview:_tabViews[index-1]];
    
    [self.view bringSubviewToFront:_tabbarView];
    [self.view bringSubviewToFront:_playerView];
    
    _currentTabIndex = index;
}
- (void)setupHeader
{
    FMTabbarView *headView = [[FMTabbarView alloc] init];
    [self.view addSubview:headView];
    _tabbarView = headView;
    _tabbarView.delegate = self;
}

- (void)setupPlayerView
{
    float y = _tabbarView.frame.origin.y + _tabbarView.frame.size.height;
    FMPlayerView *playerView = [[FMPlayerView alloc] initWithFrame:CGRectMake(0,y,SCREEN_SIZE.width, SCREEN_SIZE.height-y)];
    playerView.backgroundColor = [UIColor redColor];
    [self.view addSubview:playerView];
    _playerView = playerView;
    
}

- (void)tabbar:(FMTabbarView *)tabbarView didSelected:(int)index
{
    [self setSelectedTab:index];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    APP_DELEGATE.navigationController.navigationBarHidden = YES;
}


@end
