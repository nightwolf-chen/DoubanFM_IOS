//
//  FMUserCenterController.m
//  DoubanFM
//
//  Created by nirvawolf on 21/6/14.
//  Copyright (c) 2014 nirvawolf. All rights reserved.
//

#import "FMUserCenterController.h"
#import "FMApiRequestUser.h"
#import "FMUser.h"
#import "FMApiResponseUser.h"
#import "../util/FMMacros.h"
#import "FMUserCenter.h"
#import "FMNotifications.h"
#import "FMRequestExecutor.h"
#import "FMApiResponse.h"

@interface FMUserCenterController ()

@property (retain ,nonatomic) FMRequestExecutor *requestExecutor;

@end

@implementation FMUserCenterController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.tabBarItem = [[[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemMore
                                                                     tag:UITabBarSystemItemMore] autorelease];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(didrecieveLoginSuccess:)
                                                     name:FMUSerLoginSuccessNotification
                                                   object:nil];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIGestureRecognizer *recognizer= [[[UITapGestureRecognizer alloc] initWithTarget:self
                                                                              action:@selector(backgroundTaped:)]
                                      autorelease];
    [self.view addGestureRecognizer:recognizer];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)loginButtonClicked:(id)sender
{
    [self hideKeybord];
    
    if (self.emailTextField.text == nil
        || [self.emailTextField.text isEqualToString:@""]
        || self.passwordTextField.text == nil
        || [self.passwordTextField.text isEqualToString:@""])
    {
        self.loginInfoLabel.text = @"请填写完整信息";
        return;
    }
    
    SAFE_DELETE(_requestExecutor);
    
    FMUser *user = [[FMUser alloc] init];
    user.email = self.emailTextField.text;
    user.password = self.passwordTextField.text;
    
    FMApiRequest *request = [[FMApiRequestUser alloc] initWithDelegate:self user:user];
    _requestExecutor = [[FMRequestExecutor alloc] initWithRequest:request complete:^(FMApiResponse *response){
    
            FMApiResponseUser *userResp = (FMApiResponseUser *)response;
            if (userResp.isSuccess) {
                [[FMUserCenter sharedCenter] setIsLogin:userResp.isSuccess];
                [[FMUserCenter sharedCenter] setUser:userResp.user];
                [[NSNotificationCenter defaultCenter] postNotificationName:FMUSerLoginSuccessNotification
                                                                    object:self];
            }else{
                [[NSNotificationCenter defaultCenter] postNotificationName:FMUserLoginFailedNotification
                                                                    object:self];
                self.loginInfoLabel.text = @"登录失败请重试";
            }

    }];
    
    [request release];
    [user release];
    
    [_requestExecutor execute];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField.isFirstResponder) {
        [textField resignFirstResponder];
        return YES;
    }
    
    return NO;
}

- (void)hideKeybord
{
    [self.emailTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
    
}

- (void)didrecieveLoginSuccess:(NSNotification *)notification
{
    [self.emailTextField setHidden:YES];
    [self.passwordTextField setHidden:YES];
    [self.loginButton setHidden:YES];
    
    FMUserCenter *userCenter = [FMUserCenter sharedCenter];
    FMUser *user = userCenter.user;
    NSString *username = user.username;
    self.loginInfoLabel.text = [NSString stringWithFormat:@"%@ 已登录",username];
}

- (void)backgroundTaped:(UIGestureRecognizer *)recognizer
{
    [self hideKeybord];
}

- (void)dealloc {
    [_emailTextField release];
    [_passwordTextField release];
    SAFE_DELETE(_requestExecutor);
    [_loginButton release];
    [_loginInfoLabel release];
    [super dealloc];
}
@end
