//
//  FMViewController.m
//  DoubanFM
//
//  Created by nirvawolf on 19/6/14.
//  Copyright (c) 2014 nirvawolf. All rights reserved.
//

#import "FMTabbarViewController.h"
#import "FMChannelViewController.h"
#import "FMPlayerViewController.h"

@interface FMTabbarViewController ()

@end

@implementation FMTabbarViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        FMChannelViewController *channelContr = [[FMChannelViewController alloc] initWithNibName:nibNameOrNil
                                                                                          bundle:nibBundleOrNil];
        
        FMPlayerViewController *playerContr = [[FMPlayerViewController alloc] initWithNibName:nibNameOrNil
                                                                                       bundle:nibBundleOrNil];
        
        NSArray *controllers = @[playerContr,channelContr];
        
        self.viewControllers = controllers;
        
        [channelContr release];
        [playerContr release];
        
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

@end
