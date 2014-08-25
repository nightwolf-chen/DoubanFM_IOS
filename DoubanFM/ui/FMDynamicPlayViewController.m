//
//  FMPlayViewController.m
//  DoubanFM
//
//  Created by exitingchen on 14-8-22.
//  Copyright (c) 2014年 nirvawolf. All rights reserved.
//

#import "FMDynamicPlayViewController.h"
#import "FMTabbarView.h"
#import "FMPlayerView.h"

@interface FMDynamicPlayViewController ()

@property (nonatomic,assign) FMPlayerViewStatus status;
@property (nonatomic,assign) FMPlayerView *playView;

@end

@implementation FMDynamicPlayViewController

- (void)dealloc
{
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithRootViewController:(UIViewController *)rootViewController
{
    if (self = [super init]) {
        [self addChildViewController:rootViewController];
        [self.view addSubview:rootViewController.view];
        
        FMPlayerView *playerView = [self playView];
        _status = playerView.status;
        _playView = playerView;
        [self.view addSubview:playerView];
    }
    
    return self;
}


- (UIView *)playView
{
    float y = [FMTabbarView tabbarViewHight];
    FMPlayerView *playerView = [[FMPlayerView alloc] initWithFrame:CGRectMake(0,y,SCREEN_SIZE.width,SCREEN_SIZE.height-y)];
    playerView.backgroundColor = [UIColor lightGrayColor];
    return [playerView autorelease];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
