//
//  FMRootViewController.m
//  DoubanFM
//
//  Created by nirvawolf on 15/6/14.
//  Copyright (c) 2014 nirvawolf. All rights reserved.
//
#import <AVFoundation/AVFoundation.h>
#import "FMPlayerViewController.h"
#import "FMApiRequestSongInfo.h"
#import "FMApiRequestSong.h"
#import "FMPlayer.h"
#import "FMApiResponseSong.h"
#import "FMSong.h"
#import "FMUIPlayer.h"
#import "../util/FMMacros.h"

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
        
        //Default channel setting.
        _channelId = @"10086";
        FMApiRequestSongInfo *info = [[[FMApiRequestSongInfo alloc] initWith:SongRequestTypeNEW
                                                                       song:nil
                                                                    channel:_channelId] autorelease];
        
        _songRequest = [[FMApiRequestSong alloc] initWithDelegate:self info:info];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadSongsFromServer];
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
    [self loadSongsFromServer];
}

- (void)dealloc
{
    [_timeLabel release];
    [_songRequest release];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    [_songProgressSlider release];
    [_songInfoLabel release];
    [_songImgView release];
    [super dealloc];
}

- (void)setChannelId:(NSString *)channelId
{
    SAFE_DELETE(_channelId);
    _channelId = [channelId copy];
    
    FMApiRequestSongInfo *info = [[[FMApiRequestSongInfo alloc] initWith:SongRequestTypeNEW
                                                                   song:nil
                                                                channel:_channelId] autorelease];
    SAFE_DELETE(_songRequest);
    _songRequest = [[FMApiRequestSong alloc] initWithDelegate:self info:info];
    
    [self loadSongsFromServer];
}

- (void)loadSongsFromServer
{
    [_songRequest sendRequest];
}

@end
