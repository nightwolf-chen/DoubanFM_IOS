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
#import "FMApiResponseSong.h"
#import "FMSong.h"
#import "FMPlayerViewController.h"
#import "FMHomeViewController.h"
#import "FMDiscoverMusicView.h"
#import "FMPlayerView.h"
#import "FMTabbarView.h"
#import "FMDynamicPlayViewController.h"
#import "FMTabBarController.h"
#import "FMChannelViewController.h"
#import "FMDiscoverController.h"
#import "FMMyMusicController.h"
#import "FMPlayer.h"
#import "FMApiRequestSong.h"
#import "FMApiRequestSongInfo.h"
#import "FMApiRequest.h"
#import "FMApiResponse.h"
#import "FMApiResponseSong.h"
#import "FMChannel.h"
#import "FMPlayerManager.h"
#import "DFMDatabase.h"

@implementation FMAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    
    
#ifdef FM_TEST
    
    UITabBarController *tabController = [[FMTabBarController alloc] init];
    FMPlayerViewController *playerViewController = [[FMPlayerViewController alloc] initWithNibName:nil bundle:nil];
    FMChannelViewController *channelViewController = [[FMChannelViewController alloc] initWithNibName:nil bundle:nil];
    
    self.window.rootViewController = tabController;
    tabController.viewControllers = @[playerViewController,channelViewController];
    
    [playerViewController release];
    [channelViewController release];
    [tabController release];
    
#else
    FMTabBarController *tabbarController = [[FMTabBarController alloc] init];
    UIViewController *discoverController = [[FMDiscoverController alloc] initWithNibName:nil bundle:nil];
    UIViewController *myMusicViewController = [[FMMyMusicController alloc] initWithNibName:nil bundle:nil];
    tabbarController.viewControllers = @[discoverController, myMusicViewController];
    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:tabbarController];
    
    UIViewController *rootController = [[FMDynamicPlayViewController alloc] initWithRootViewController:navigationController];
    
    self.window.rootViewController = rootController;
    
    [tabbarController release];
    [navigationController release];
    [rootController release];
    [discoverController release];
    [myMusicViewController release];
    
    [DFMDatabase database];
    
//    FMPlayer *aPlayer = [[FMPlayer defaultPlayer] retain];
//    FMChannel *channel = [[FMChannel alloc] init];
//    channel.channelId = 0;
//    NSString *channelId = [NSString stringWithFormat:@"%d",channel.channelId];
//    FMApiRequestSongInfo *info = [[FMApiRequestSongInfo alloc] initWith:SongRequestTypeNEW song:nil channel:channelId];
//    
//    FMApiRequest *request = [[FMApiRequestSong alloc] init:info
//                                                completion:^(FMApiResponse *response){
//                                                    
//                                                    FMApiResponseSong *songResp = (FMApiResponseSong *)response;
//                                                    aPlayer.songs = songResp.songs;
//                                                    [aPlayer play];
//                                                    
//                                                }
//                                                  errBlock:^(NSError *error){
//                                                      NSLog(@"Error loading songs via network!");
//                                                  }];
//    
//    [request sendRequest];
//
    [FMPlayerManager sharedInstance];
    
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
