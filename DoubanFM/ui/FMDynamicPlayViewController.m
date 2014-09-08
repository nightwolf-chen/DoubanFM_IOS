//
//  FMPlayViewController.m
//  DoubanFM
//
//  Created by exitingchen on 14-8-22.
//  Copyright (c) 2014年 nirvawolf. All rights reserved.
//

#import "FMDynamicPlayViewController.h"
#import "FMPlayerView.h"
#import "FMTabbarView.h"
#import "FMPlayerManager.h"
#import "FMSong.h"
#import "FMPlayerCircleProgressView.h"

static NSString *const kKVOPathCurrentSong = @"currentSong";

@interface FMDynamicPlayViewController ()

@property (nonatomic,assign) FMPlayerView *playView;
@property (nonatomic,assign) UILabel *songNameLabel;
@property (nonatomic,assign) UILabel *artistLabel;
@property (nonatomic,assign) UIButton *playButton;

@property (nonatomic,assign) FMPlayerCircleProgressView *progreesView;

@property (nonatomic,retain) NSTimer *progressTimer;

@end

@implementation FMDynamicPlayViewController

- (void)dealloc
{
    [[FMPlayerManager sharedInstance].activePlayer removeObserver:self
                                                       forKeyPath:kKVOPathCurrentSong];
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithRootViewController:(UIViewController *)rootViewController
{
    if (self = [super init]) {
        [self addChildViewController:rootViewController];
        
        [[FMPlayerManager sharedInstance].activePlayer addObserver:self
                                                        forKeyPath:kKVOPathCurrentSong
                                                           options:NSKeyValueObservingOptionNew
                                                           context:nil];
        
        _progressTimer = [NSTimer scheduledTimerWithTimeInterval:1.0f
                                                          target:self
                                                        selector:@selector(updateProgressView)
                                                        userInfo:nil
                                                         repeats:YES];
    }
    
    return self;
}


- (UIView *)playView
{
    float y = [FMTabbarView tabbarViewHight];
    FMPlayerView *playerView = [[FMPlayerView alloc] initWithFrame:CGRectMake(0,y,SCREEN_SIZE.width,SCREEN_SIZE.height-y)];
    playerView.backgroundColor = [UIColor lightGrayColor];
    return [playerView autorelease];
}

- (void)updateProgressView
{
    FMPlayer *player = [FMPlayerManager sharedInstance].activePlayer;
//    CGFloat duration = player.totalTime;
//    CGFloat currentTime = player.currentTime;
//    CGFloat percent = (currentTime / duration) * 100.0f;
    _progreesView.percent = (player.currentTime / player.totalTime) * 100.0f;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    UIViewController *rootViewCtr = self.childViewControllers[0];
    [self.view addSubview:rootViewCtr.view];
    
    [self.view addSubview: _playView = [self playView]];
    
    for (int tag = FMPlayerViewTagButtonStart+1 ; tag < FMPlayerViewTagButtonEnd ; tag++) {
        UIButton *button = (UIButton *)[self.view viewWithTag:tag];
        [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    self.songNameLabel = (UILabel *)[self.view viewWithTag:FMPlayerViewTagLabelSong];
    self.artistLabel = (UILabel *)[self.view viewWithTag:FMPlayerViewTagLabelArtist];
    self.playButton = (UIButton *)[self.view viewWithTag:FMPlayerViewTagButtonPlay];
    self.progreesView = (FMPlayerCircleProgressView *)[self.view viewWithTag:FMPlayerViewTagProgressView];
}

- (void)buttonClicked:(id)sender
{
    UIButton *aButton = (UIButton *)sender;
    
    switch (aButton.tag) {
        case FMPlayerViewTagButtonPlay:
        {
            static BOOL playing = YES;
            if (!playing) {
                [[FMPlayerManager sharedInstance].activePlayer resume];
                playing = YES;
            }else{
                [[FMPlayerManager sharedInstance].activePlayer pause];
                playing = NO;
            }
        }
        case FMPlayerViewTagButtonLike:
        {
            [[FMPlayerManager sharedInstance].activePlayer like];
        }
            break;
        case FMPlayerViewTagButtonTrash:
        {
            [[FMPlayerManager sharedInstance].activePlayer trash];
        }
            break;
        case FMPlayerViewTagButtonSkip:
        {
            [[FMPlayerManager sharedInstance].activePlayer skip];
        }
            break;
        case FMPlayerViewTagButtonSimilar:
        {
            
        }
            break;
        case FMPlayerViewTagButtonLrc:
        {
            
        }
            break;
        case FMPlayerViewTagButtonShare:
        {
            
        }
            break;
            
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - KVO

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:kKVOPathCurrentSong]) {
        
        FMSong *song = change[@"new"];
        
        _songNameLabel.text = song.songTitle;
        _artistLabel.text = song.artist;
        
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:song.pictureUrl]];
        UIImage *image = [UIImage imageWithData:data];
    
        [_playButton setBackgroundImage:image forState:UIControlStateNormal];
        [_playButton setBackgroundImage:image forState:UIControlStateSelected];
    }
}

@end
