//
//  FMHomeViewController.m
//  DoubanFM
//
//  Created by exitingchen on 14-8-13.
//  Copyright (c) 2014年 nirvawolf. All rights reserved.
//

#import "FMHomeViewController.h"
#import "FMTabbarView.h"
#import "FMPlayerView.h"

@interface FMHomeViewController ()
{
    FMTabbarView *_tabBarView;
    FMPlayerView *_playerView;
}

@end

@implementation FMHomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupHeader];
    [self setupPlayerView];
    // Do any additional setup after loading the view.
}

- (void)setupHeader
{
    FMTabbarView *headView = [[FMTabbarView alloc] init];
    [self.view addSubview:headView];
    _tabBarView = headView;
}

- (void)setupPlayerView
{
    float y = _tabBarView.frame.origin.y + _tabBarView.frame.size.height;
    FMPlayerView *playerView = [[FMPlayerView alloc] initWithFrame:CGRectMake(0,y,SCREEN_SIZE.width, SCREEN_SIZE.height-y)];
    playerView.backgroundColor = [UIColor redColor];
    [self.view addSubview:playerView];
    _playerView = playerView;
}
- (void)didReceiveMemoryWarning
{
   
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
