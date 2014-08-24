//
//  FMTabBarController.m
//  DoubanFM
//
//  Created by exitingchen on 14-8-22.
//  Copyright (c) 2014年 nirvawolf. All rights reserved.
//

#import "FMTabBarController.h"
#import "FMPlayerView.h"
#import "FMTabbarView.h"

@interface FMTabBarController ()

@property (nonatomic,retain) FMTabbarView *myTabbarView;
@property (nonatomic,retain) UIView *contentViewContainer;

@end

@implementation FMTabBarController

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
        self.automaticallyAdjustsScrollViewInsets = NO;
        [self setupContentContainer];
    }
    
    return self;
}

- (void)setupHeader
{
    FMTabbarView *headView = [[FMTabbarView alloc] initWithTabNumber:(int)self.viewControllers.count];
    
    if (_myTabbarView) {
        [_myTabbarView removeFromSuperview];
    }
    
    headView.delegate = self;
    [self.view addSubview:headView];
    
    _myTabbarView = headView;
    
    [headView release];
}

- (void)setupContentContainer
{
    CGPoint tabViewOrigin = [FMTabbarView tabbarOrigin];
    CGFloat tabViewHight = [FMTabbarView tabbarViewHight];
    
    CGPoint playerOrigin = [FMPlayerView sOrigin];
    
    float x = 0;
    float y = tabViewOrigin.y + tabViewHight - STATUSBAR_SIZE.height;
    float hight = playerOrigin.y - (tabViewOrigin.y + tabViewHight);
    float width = SCREEN_SIZE.width;
    CGRect frame = CGRectMake(x, y, width, hight);
    
    _contentViewContainer = [[UIView alloc] initWithFrame:frame];
    _contentViewContainer.backgroundColor = [UIColor redColor];
    _contentViewContainer.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    [self.view addSubview:_contentViewContainer];
}

- (void)setViewControllers:(NSArray *)viewControllers
{
	NSAssert([viewControllers count] >= 2, @"FMTabBarController requires at least two view controllers");
    
    for(UIViewController *viewController in _viewControllers){
        [viewController willMoveToParentViewController:nil];
        [viewController removeFromParentViewController];
    }
    
    SAFE_DELETE(_viewControllers);
    
    _viewControllers = [viewControllers copy];
    
    for(UIViewController *viewController in _viewControllers){
        [self addChildViewController:viewController];
        [viewController didMoveToParentViewController:self];
    }
    
    [self setupHeader];
    
    [self addTabbarItemsToTabbarview];
    
    [self setSelectedIndex:0];
}

- (void)addTabbarItemsToTabbarview
{
    for(int index = 0; index < _viewControllers.count ; index++){
        UIViewController *ctr = _viewControllers[index];
        UIButton *tabButton = _myTabbarView.tabButtons[index];
        
        [tabButton setTitle:ctr.tabBarItem.title forState:UIControlStateNormal];
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	// Only rotate if all child view controllers agree on the new orientation.
	for (UIViewController *viewController in self.viewControllers)
	{
		if (![viewController shouldAutorotateToInterfaceOrientation:interfaceOrientation])
			return NO;
	}
	return YES;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tabbar:(FMTabbarView *)tabbarView didSelected:(int)index
{
    [self setSelectedIndex:index];
}

- (void)setSelectedIndex:(NSUInteger)selectedIndex
{
    UIViewController *tCtr = [_viewControllers objectAtIndex:selectedIndex];
    
    if ([_delegate respondsToSelector:@selector(fm_tabBarController:shouldSelectViewController:atIndex:)]) {
        [_delegate fm_tabBarController:self shouldSelectViewController:tCtr atIndex:selectedIndex];
    }
    
    if (tCtr) {
        if (_selectedViewController) {
            [_selectedViewController.view removeFromSuperview];
        }
        
        _selectedIndex = selectedIndex;
        _selectedViewController = tCtr;
        
        tCtr.view.frame = _contentViewContainer.bounds;
        [_contentViewContainer addSubview:tCtr.view];
        
        if ([_delegate respondsToSelector:@selector(fm_tabBarController:didSelectViewController:atIndex:)]) {
            [_delegate fm_tabBarController:self didSelectViewController:tCtr atIndex:selectedIndex];
        }
    }
}

- (void)setSelectedIndex:(NSUInteger)index animated:(BOOL)animated
{
    [self setSelectedIndex:index];
}

- (void)setSelectedViewController:(UIViewController *)selectedViewController
{
    NSUInteger index = [_viewControllers indexOfObject:selectedViewController];
  
    if (index != NSNotFound) {
        [self setSelectedIndex:index animated:NO];
    }else{
        @throw @"Unkown view controller because it's not in current tab controller's controllers array";
    }
}

- (void)setSelectedViewController:(UIViewController *)selectedViewController animated:(BOOL)animated
{
    [self setSelectedViewController:selectedViewController];
}

@end
