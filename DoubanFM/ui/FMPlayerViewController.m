//
//  FMRootViewController.m
//  DoubanFM
//
//  Created by nirvawolf on 15/6/14.
//  Copyright (c) 2014 nirvawolf. All rights reserved.
//

#import "FMPlayerViewController.h"
#import "FMApiRequestSongInfo.h"
#import "FMApiRequestSong.h"
#import "FMPlayer.h"
#import "FMApiResponseSong.h"
#import "FMSong.h"
#import "FMUIPlayer.h"
#import <AVFoundation/AVFoundation.h>

@interface FMPlayerViewController ()
{
    FMApiRequestSong *_songRequest;
}

@end

@implementation FMPlayerViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.tabBarItem = [[[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemHistory
                                                                 tag:UITabBarSystemItemHistory] autorelease];
        
        _player = [[FMUIPlayer alloc] initWithSongs:nil delegate:self];
        
        NSString *channelId = @"10086";
        
        FMApiRequestSongInfo *info = [[FMApiRequestSongInfo alloc] initWith:SongRequestTypeNEW
                                                                       song:nil
                                                                    channel:channelId];
        
        _songRequest = [[FMApiRequestSong alloc] initWithDelegate:self info:info];
        
        [info release];

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [_songRequest sendRequest];
    // Do any additional setup after loading the view from its nib.
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    // Dispose of any resources that can be recreated.
}

- (void)didFailWithError:(NSError *)error
{
    NSLog(@"No network connection!");
}

- (void)didRecieveResponse:(FMApiResponse *)response
{
    FMApiResponseSong *songResponse = (FMApiResponseSong *)response;
    _player.songQueue = [NSMutableArray arrayWithArray:songResponse.songs];
    [_player start];
}

- (void)player:(FMUIPlayer *)player currentTime:(double)time
{
    NSString *timeString = [NSString stringWithFormat:@"%f",time];
    [self.timeLabel setText:timeString];
}

- (IBAction)nextClicked:(id)sender {
    [_player next];
}

- (void)playerNeedsMoreSongs:(FMUIPlayer *)player
{
    [_songRequest sendRequest];
}

- (void)dealloc
{
    [_timeLabel release];
    [_songRequest release];
    [super dealloc];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
