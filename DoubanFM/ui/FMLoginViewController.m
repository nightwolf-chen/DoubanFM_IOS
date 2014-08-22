//
//  FMLoginViewController.m
//  DoubanFM
//
//  Created by exitingchen on 14-8-21.
//  Copyright (c) 2014年 nirvawolf. All rights reserved.
//

#import "FMLoginViewController.h"
#import "FMPresentedViewTopbar.h"
#import "FMTopBarView.h"

@interface FMLoginViewController ()

@property (nonatomic,assign) CGRect normalFrame;
@property (nonatomic,assign) CGRect hiddenFrame;

@end

@implementation FMLoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        FMPresentedViewTopbar *topbar = [FMTopBarView topbarWithType:FMTopBarViewTypePresentedTopbar];
        [self.view addSubview:topbar];
        
        _normalFrame = self.view.frame;
        _hiddenFrame = self.view.frame;
        _hiddenFrame.origin.y = SCREEN_SIZE.height;
        
        topbar.buttonClickedBlock = ^{
            [self hideViewWithAnimation];
        };
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

- (void)showViewWithAnimaition
{
    self.view.frame = _hiddenFrame;
    
    [APP_DELEGATE.window addSubview:self.view];
    
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         self.view.frame = _normalFrame;
                     }
                     completion:nil];
}

- (void)hideViewWithAnimation
{
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         self.view.frame = _hiddenFrame;
                     }
                     completion:^(BOOL is){
                        [self.view removeFromSuperview];
                     }];
    
}

@end
