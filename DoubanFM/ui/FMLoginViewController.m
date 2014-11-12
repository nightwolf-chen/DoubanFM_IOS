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
#import "SVProgressHUD.h"
#import "FMRequestService.h"
#import "FMUserCenter.h"

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
            [self dismissViewControllerAnimated:YES completion:nil];
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

- (IBAction)loginButtonClicked:(id)sender {
    [self startLogin];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self startLogin];
    return YES;
}

- (void)startLogin
{
    if (![self invalidateInput]) {
        return;
    }
    
    [SVProgressHUD show];
    FMUser *user = [[FMUser alloc] init];
    
    user.email = _usernameTextField.text;
    user.password = _passwordTextField.text;
    
    [self hideKeyborad];
    
    [[FMRequestService sharedService] sendUserAuthRequest:user success:^(FMApiResponse *resp,FMApiRequest *req){
        FMApiResponseUser *userResp = (FMApiResponseUser *)resp;
        if (userResp.isSuccess) {
            [[FMUserCenter sharedCenter] login:userResp.user];
            [SVProgressHUD dismiss];
            [self dismissViewControllerAnimated:YES completion:^{}];
        }else{
            [SVProgressHUD showErrorWithStatus:@"登录失败请重试"];
        }
    } error:^(NSError *err){
        [SVProgressHUD showErrorWithStatus:@"登录失败请重试"];
    }];
}

- (BOOL)invalidateInput
{
    if (_usernameTextField.text == nil
        || [_usernameTextField.text isEqualToString:@""]
        || _passwordTextField.text == nil
        || [_passwordTextField.text isEqualToString:@""]) {
        
        [SVProgressHUD showErrorWithStatus:@"请填写用户名和密码"];
        return NO;
        
    }
    
    return YES;
}

- (void)hideKeyborad
{
    [_passwordTextField resignFirstResponder];
    [_usernameTextField resignFirstResponder];
}

- (void)dealloc {
    [_usernameTextField release];
    [_passwordTextField release];
    [super dealloc];
}
@end
