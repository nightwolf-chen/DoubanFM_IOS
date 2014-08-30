//
//  FMPlayViewController.m
//  DoubanFM
//
//  Created by exitingchen on 14-8-22.
//  Copyright (c) 2014年 nirvawolf. All rights reserved.
//

#import "FMDynamicPlayViewController.h"
#import "FMPlayerView.h"
#import "FMTabbarView.h"
#import "FMPlayerManager.h"

@interface FMDynamicPlayViewController ()

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

    UIViewController *rootViewCtr = self.childViewControllers[0];
    [self.view addSubview:rootViewCtr.view];
    
    [self.view addSubview: _playView = [self playView]];
    
    for (int tag = FMPlayerViewTagButtonStart+1 ; tag < FMPlayerViewTagButtonEnd ; tag++) {
        UIButton *button = (UIButton *)[self.view viewWithTag:tag];
        [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)buttonClicked:(id)sender
{
    UIButton *aButton = (UIButton *)sender;
    
    switch (aButton.tag) {
        case FMPlayerViewTagButtonPlay:
        {
            
        }
        case FMPlayerViewTagButtonLike:
        {
            
        }
            break;
        case FMPlayerViewTagButtonTrash:
        {
            
        }
            break;
        case FMPlayerViewTagButtonSkip:
        {
            
        }
            break;
        case FMPlayerViewTagButtonSimilar:
        {
            
        }
            break;
        case FMPlayerViewTagButtonLrc:
        {
            
        }
            break;
        case FMPlayerViewTagButtonShare:
        {
            
        }
            break;
            
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
