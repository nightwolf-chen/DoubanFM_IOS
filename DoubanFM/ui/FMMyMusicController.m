//
//  FMMyMusicControllerViewController.m
//  DoubanFM
//
//  Created by nirvawolf on 23/8/14.
//  Copyright (c) 2014 nirvawolf. All rights reserved.
//

#import "FMMyMusicController.h"
#import "FMMyMusicView.h"

@interface FMMyMusicController ()

@end

@implementation FMMyMusicController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        FMMyMusicView *myView = [[FMMyMusicView alloc] initWithFrame:self.view.frame];
        self.view = myView;
        self.tabBarItem.title = @"我的FM";
        
        [myView release];
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
