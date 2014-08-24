//
//  FMDiscoverController.m
//  DoubanFM
//
//  Created by nirvawolf on 23/8/14.
//  Copyright (c) 2014 nirvawolf. All rights reserved.
//

#import "FMDiscoverController.h"
#import "FMDiscoverMusicView.h"

@interface FMDiscoverController ()

@end

@implementation FMDiscoverController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        FMDiscoverMusicView *myView = [[FMDiscoverMusicView alloc] initWithFrame:self.view.frame];
        self.view = myView;
        self.tabBarItem.title = @"发现音乐";
        
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
