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

FMHttpClient *client = nil;

@implementation FMAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
//    NSDictionary *value = @{
//                            @"app_name" : @"radio_desktop_win",
//                            @"version" : @"100",
//                            @"email" : @"466202783@qq.com",
//                            @"password" : @"a13827970772b"
//                            };
    
//    client = [[FMHttpClient alloc] init];
//    [client doPost:@"http://www.douban.com/j/app/login" parameters:value];
//    
//    FMUser *user = [[FMUser alloc] init];
//    user.email = @"466202783@qq.com";
//    user.password = @"a13827970772b";
//    
//    FMApiRequestUser *userRequest = [[FMApiRequestUser alloc] initWithDelegate:self user:user];
//    [userRequest sendRequest];
//    [userRequest autorelease];
    
//    FMApiRequestChannel *channelRequest = [[FMApiRequestChannel alloc] initWithDelegate:self];
//    [channelRequest sendRequest];
//    [channelRequest autorelease];
    
//    NSString *songId = @"10086";
    NSString *channelId = @"10086";
    
//    FMUser *user = [[FMUser alloc] init];
//    user.token = @"10000";
//    user.expire = @"10000";
//    user.userid = @"10086";
    
    FMApiRequestSongInfo *info = [[FMApiRequestSongInfo alloc] initWith:SongRequestTypeNEW
                                                                   song:nil
                                                                channel:channelId];
//    info.user = user;
    
    FMApiRequestSong *songRequest = [[FMApiRequestSong alloc] initWithDelegate:self info:info];
    
    [songRequest sendRequest];
    
//    [user release];
    [info release];
    
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
