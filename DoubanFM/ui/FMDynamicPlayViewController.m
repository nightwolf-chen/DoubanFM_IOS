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
    [_playView release];
    
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

- (id)init
{
    self = [super init];
    
    if (self) {
        float y = [FMTabbarView tabbarViewHight];
        FMPlayerView *playerView = [[FMPlayerView alloc] initWithFrame:CGRectMake(0,y,SCREEN_SIZE.width,SCREEN_SIZE.height-y)];
        playerView.backgroundColor = [UIColor lightGrayColor];
        self.view = playerView;
        
        _status = playerView.status;
        _playView = playerView;
    }
    
    return self;
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

- (void)presentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)flag completion:(void (^)(void))completion
{
    [super presentViewController:viewControllerToPresent animated:YES completion:completion];
    self.status = _playView.status;
}

@end
