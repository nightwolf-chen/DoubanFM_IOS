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
#import "FMTabarViewController.h"

@interface FMHomeViewController ()


@end

@implementation FMHomeViewController



- (void)viewWillAppear:(BOOL)animated
{
    APP_DELEGATE.navigationController.navigationBarHidden = YES;
}

@end
