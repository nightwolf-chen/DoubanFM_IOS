//
//  FMRootViewController.m
//  DoubanFM
//
//  Created by nirvawolf on 15/6/14.
//  Copyright (c) 2014 nirvawolf. All rights reserved.
//

#import "FMRootViewController.h"
#import "FMApiRequestSongInfo.h"
#import "FMApiRequestSong.h"
#import "FMPlayer.h"
#import "FMApiResponseSong.h"
#import "FMSong.h"
#import "FMUIPlayer.h"
#import <AVFoundation/AVFoundation.h>

@interface FMRootViewController ()

@end

FMHttpClient *client = nil;
FMUIPlayer *player = nil;

@implementation FMRootViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    NSString *channelId = @"10086";
    
    FMApiRequestSongInfo *info = [[FMApiRequestSongInfo alloc] initWith:SongRequestTypeNEW
                                                                   song:nil
                                                                channel:channelId];
    
    FMApiRequestSong *songRequest = [[FMApiRequestSong alloc] initWithDelegate:self info:info];
    
    [songRequest sendRequest];
    
    [info release];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    // Dispose of any resources that can be recreated.
}

- (void)didFailWithError:(NSError *)error
{
    
}

- (void)didRecieveResponse:(FMApiResponse *)response
{
    FMApiResponseSong *songResponse = (FMApiResponseSong *)response;
    player = [[FMUIPlayer alloc] initWithSongs:songResponse.songs];
    [player start];
}
- (IBAction)nextClicked:(id)sender {
    [player next];
}

- (void)dealloc
{
    [super dealloc];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
