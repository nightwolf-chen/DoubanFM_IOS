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
#import "FMTimeFormateHelper.h"

@interface FMPlayerViewController ()
{
    FMApiRequestSong *_songRequest;
}

@property (retain, nonatomic) UIActivityIndicatorView *actIndicator;

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
        
        //Set up a activity view with blue color
        _actIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        _actIndicator.center = CGPointMake(self.view.frame.size.width/2.0,
                                           self.view.frame.size.height/2.0);
        _actIndicator.color = [UIColor blueColor];
        [self.view addSubview:_actIndicator];
        [self.view bringSubviewToFront:_actIndicator];
        
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

#pragma mark -Request delegate

- (void)didFailWithError:(NSError *)error
{
    [_actIndicator stopAnimating];
    NSLog(@"No network connection!");
}

- (void)didRecieveResponse:(FMApiResponse *)response
{
    [_actIndicator stopAnimating];
    FMApiResponseSong *songResponse = (FMApiResponseSong *)response;
    _player.songQueue = [NSMutableArray arrayWithArray:songResponse.songs];
    [_player start];
}

#pragma mark - FMUIPlayer delegate
- (void)player:(FMUIPlayer *)player currentTime:(double)time totalTime:(double)duration
{
    FMSong * cSong = [player getPlayingSong];

    if ((int)time == 0) {
        
        if (![cSong.songTitle isEqualToString:self.songInfoLabel.text]) {
           
            [_actIndicator stopAnimating];
            
            //Set song info
            [self.songInfoLabel setText:cSong.songTitle];
            [self.artistLabel setText:cSong.artist];
            
            //Set song picture
            NSData *imgData = [NSData dataWithContentsOfURL:[NSURL URLWithString:cSong.pictureUrl]];
            UIImage *img = [UIImage imageWithData:imgData];
            [self.songImgView setImage:img];
            
        }
        
        if (isnan(duration)) {
            duration = 0;
        }
        
        [_durationLabel setText:[FMTimeFormateHelper generateTimeStr:duration]];
    }
   
    self.songProgressSlider.value = time / duration;
    
    NSString *timeString = [FMTimeFormateHelper generateTimeStr:time];
    
    [self.timeLabel setText:timeString];

}

- (void)playerIsLoadingSong:(FMUIPlayer *)player
{
    [_actIndicator startAnimating];
}


- (void)playerNeedsMoreSongs:(FMUIPlayer *)player
{
    [self loadSongsFromServer];
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
    [_actIndicator startAnimating];
}

- (IBAction)nextClicked:(id)sender {
    [_player next];
}


- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    [_timeLabel release];
    [_songRequest release];
    [_songProgressSlider release];
    [_songInfoLabel release];
    [_songImgView release];
    [_actIndicator release];
    [_artistLabel release];
    
    [_durationLabel release];
    [super dealloc];
}

@end
