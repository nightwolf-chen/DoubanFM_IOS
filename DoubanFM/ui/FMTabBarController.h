//
//  FMTabBarController.h
//  DoubanFM
//
//  Created by exitingchen on 14-8-22.
//  Copyright (c) 2014年 nirvawolf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FMTabbarView.h"

@protocol FMTabBarControllerDelegate;

@interface FMTabBarController : UIViewController<FMTabbarViewDelegate>

@property (nonatomic,copy) NSArray *viewControllers;
@property (nonatomic,assign) UIViewController *selectedViewController;
@property (nonatomic,assign) NSUInteger selectedIndex;

@property (nonatomic, assign) id <FMTabBarControllerDelegate> delegate;

- (void)setSelectedIndex:(NSUInteger)index animated:(BOOL)animated;
- (void)setSelectedViewController:(UIViewController *)viewController animated:(BOOL)animated;

@end

/*
 * The delegate protocol for MHTabBarController.
 */
@protocol FMTabBarControllerDelegate <NSObject>
@optional
- (BOOL)fm_tabBarController:(FMTabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController atIndex:(NSUInteger)index;
- (void)fm_tabBarController:(FMTabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController atIndex:(NSUInteger)index;
@end
