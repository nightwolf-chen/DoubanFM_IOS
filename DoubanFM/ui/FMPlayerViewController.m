////
////  FMRootViewController.m
////  DoubanFM
////
////  Created by nirvawolf on 15/6/14.
////  Copyright (c) 2014 nirvawolf. All rights reserved.
////
//#import <AVFoundation/AVFoundation.h>
//#import "FMPlayerViewController.h"
//#import "FMApiRequestSongInfo.h"
//#import "FMApiRequestSong.h"
//#import "FMAVPlayerAdapter.h"
//#import "FMApiResponseSong.h"
//#import "FMApiResponse.h"
//#import "FMSong.h"
//#import "FMChannel.h"
//#import "FMAVPlayerAdapter.h"
//#import "../util/FMMacros.h"
//#import "FMTimeFormateHelper.h"
//#import "FMNotifications.h"
//#import "FMUserCenter.h"
//
//@interface FMPlayerViewController ()
//{
//}
//
//@property (retain, nonatomic) UIActivityIndicatorView *actIndicator;
//
//@end
//
//@implementation FMPlayerViewController
//
//- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
//{
//    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
//    if (self) {
//        // Custom initialization
//        self.tabBarItem = [[[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemHistory
//                                                                      tag:UITabBarSystemItemHistory] autorelease];
//        
//        _player = [[FMAVPlayerAdapter alloc] initWithSongs:nil delegate:self];
//        
//        //Default channel setting.
//        _channelId = @"1";
//        
//        //Set up a activity view with blue color
//        _actIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
//        _actIndicator.center = CGPointMake(self.view.frame.size.width/2.0,
//                                           self.view.frame.size.height/2.0);
//        _actIndicator.color = [UIColor blueColor];
//        [self.view addSubview:_actIndicator];
//        [self.view bringSubviewToFront:_actIndicator];
//        
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector
//             (didRecieveChannelChangedNotification:) name:FMUIPlayerChannelChangedNotification object:nil];
//       
//        void (^completeBlock)(FMApiResponse *) = ^(FMApiResponse *response){
//            [_actIndicator stopAnimating];
//            FMApiResponseSong *songResponse = (FMApiResponseSong *)response;
//            _player.songs = [NSMutableArray arrayWithArray:songResponse.songs];
//            [_player start];
//        };
//        
//        void (^erroBlock)(NSError *) = ^(NSError *err){
//            [_actIndicator stopAnimating];
//            NSLog(@"erroR!");
//        };
//        
//        
//        FMApiRequestSongInfo *info = [self generateCurrentInfoByType:SongRequestTypeNEW];
//        FMApiRequest *request = [[FMApiRequestSong alloc] init:info
//                                                    completion:completeBlock
//                                                      errBlock:erroBlock];
//        
//        [request sendRequest];
//    }
//    return self;
//}
//
//- (void)viewDidLoad
//{
//    [super viewDidLoad];
//    _channelInfoLabel.text = @"华语";
//
//}
//
//- (void)didReceiveMemoryWarning
//{
//    [super didReceiveMemoryWarning];
//    [[NSNotificationCenter defaultCenter] removeObserver:self];
//    // Dispose of any resources that can be recreated.
//}
//
//#pragma mark - FMUIPlayer delegate
//- (void)player:(FMAVPlayerAdapter *)player currentTime:(double)time totalTime:(double)duration
//{
//    FMSong * cSong = [player getPlayingSong];
//
//    if ((int)time == 0) {
//        
//        if (![cSong.songTitle isEqualToString:self.songInfoLabel.text]) {
//           
//            [_actIndicator stopAnimating];
//            
//            //Set song info
//            [self.songInfoLabel setText:cSong.songTitle];
//            [self.artistLabel setText:cSong.artist];
//            
//            //Set song picture
//            NSData *imgData = [NSData dataWithContentsOfURL:[NSURL URLWithString:cSong.pictureUrl]];
//            UIImage *img = [UIImage imageWithData:imgData];
//            [self.songImgView setImage:img];
//            
//        }
//        
//        if (isnan(duration)) {
//            duration = 0;
//        }
//        
//        [_durationLabel setText:[FMTimeFormateHelper generateSongTimeStr:duration]];
//    }
//   
//    self.songProgressSlider.value = time / duration;
//    
//    NSString *timeString = [FMTimeFormateHelper generateSongTimeStr:time];
//    
//    [self.timeLabel setText:timeString];
//
//}
//
//- (void)playerIsLoadingSong:(FMAVPlayerAdapter *)player
//{
//    [_actIndicator startAnimating];
//}
//
//
//- (void)playerNeedsMoreSongs:(FMAVPlayerAdapter *)player
//{
//    [self loadSongsFromServer];
//}
//
//
//- (void)setChannelId:(NSString *)channelId
//{
//    SAFE_DELETE(_channelId);
//    _channelId = [channelId copy];
//    
//    [self loadSongsFromServer];
//}
//
//- (void)loadSongsFromServer
//{
//    [_actIndicator startAnimating];
//}
//
//- (FMApiRequestSongInfo *)generateCurrentInfoByType:(SongRequestType)type
//{
//    FMSong *cSong = [self.player getPlayingSong];
//    FMUser *cUser = nil;
//    if ([[FMUserCenter sharedCenter] isLogin]) {
//        cUser = [[FMUserCenter sharedCenter] user];
//    }
//    FMApiRequestSongInfo *info = [[[FMApiRequestSongInfo alloc] initWith:type
//                                                                    song:cSong
//                                                                 channel:_channelId] autorelease];
//    info.user = cUser;
//    
//    return info;
//}
//
//- (IBAction)nextClicked:(id)sender {
//    [_player next];
//}
//
//#pragma mark - Notification handler
//
//- (void)didRecieveChannelChangedNotification:(NSNotification *)notification
//{
//    NSDictionary *info = [notification userInfo];
//    FMChannel *channel = [info objectForKey:@"channel"];
//    self.channelId = [NSString stringWithFormat:@"%d",channel.channelId];
//    self.channelInfoLabel.text = channel.nameCN;
//}
//
//- (void)dealloc
//{
//    [[NSNotificationCenter defaultCenter] removeObserver:self];
//    
//    [_timeLabel release];
//    [_songProgressSlider release];
//    [_songInfoLabel release];
//    [_songImgView release];
//    [_actIndicator release];
//    [_artistLabel release];
//    
//    [_durationLabel release];
//    [_channelInfoLabel release];
//    [_player release];
//    [_channelId release];
//    
//    [super dealloc];
//}
//
//@end
