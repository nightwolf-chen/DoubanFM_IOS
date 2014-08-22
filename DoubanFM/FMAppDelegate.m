//
//  FMAppDelegate.m
//  DoubanFM
//
//  Created by nirvawolf on 25/5/14.
//  Copyright (c) 2014 nirvawolf. All rights reserved.
//

#import "FMAppDelegate.h"
#import "FMHttpClient.h"
#import "FMUser.h"
#import "FMApiRequestUser.h"
#import "FMApiRequestChannel.h"
#import "FMApiRequestSongInfo.h"
#import "FMApiRequestSong.h"
#import "FMPlayer.h"
#import "FMApiResponseSong.h"
#import "FMSong.h"
#import "FMPlayerViewController.h"
#import "FMHomeViewController.h"
#import "FMDiscoverMusicView.h"
#import "FMMyMusicView.h"
#import "FMTabarViewController.h"
#import "FMPlayerView.h"
#import "FMTabbarView.h"
#import "FMDynamicPlayViewController.h"
#import "FMTabBarController.h"
#import "FMChannelViewController.h"

@implementation FMAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    
    
#ifdef FM_TEST
    FMTabBarController *tabController = [[FMTabBarController alloc] init];
    FMPlayerViewController *playerViewController = [[FMPlayerViewController alloc] initWithNibName:nil bundle:nil];
    FMChannelViewController *channelViewController = [[FMChannelViewController alloc] initWithNibName:nil bundle:nil];
    
    tabController.viewControllers = @[tabController,channelViewController];
    self.window.rootViewController = tabController;
    
    [playerViewController release];
    [channelViewController release];
    [tabController release];
#endif
    
#ifndef FM_TEST
    
    UIViewController *rootController = [[FMHomeViewController alloc] init];
    
    self.navigationController = [[[UINavigationController alloc] initWithRootViewController:rootController] autorelease];
    self.window.rootViewController = self.navigationController;
    self.navigationController.navigationBarHidden = YES;

    UIViewController *playerController = [[FMDynamicPlayViewController alloc] init];
    
    [self.window addSubview:playerController.view];
    self.playViewController = playerController;
    
    [rootController release];
    [playerController release];
#endif
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
