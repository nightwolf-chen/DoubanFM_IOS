//
//  FMFavoriteViewController.m
//  DoubanFM
//
//  Created by exitingchen on 14-8-21.
//  Copyright (c) 2014年 nirvawolf. All rights reserved.
//

#import "FMFavoriteViewController.h"

@interface FMFavoriteViewController ()

@end

@implementation FMFavoriteViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.navigationItem.title = @"我的收藏";
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
