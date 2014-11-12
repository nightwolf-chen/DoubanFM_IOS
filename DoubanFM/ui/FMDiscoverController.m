//
//  FMDiscoverController.m
//  DoubanFM
//
//  Created by nirvawolf on 23/8/14.
//  Copyright (c) 2014 nirvawolf. All rights reserved.
//

#import "FMDiscoverController.h"
#import "FMDiscoverMusicView.h"
#import "FMRequestService.h"
#import "FMMacros.h"
#import "FMPlayerManager.h"
#import "FMDatabaseManager.h"
#import "FMChannelUpdator.h"
#import "FMImagePool.h"

static const NSInteger kDefaultSection = 0;

typedef enum FMDiscoverControllerButton{
    FMDiscoverControllerButtonHZ,
    FMDiscoverControllerButtonShow
}FMDiscoverControllerButton;

@interface FMDiscoverController ()

@property (nonatomic,assign) FMDiscoverMusicView *contentView;
@property (nonatomic,retain) NSArray *channels;
@property (nonatomic,retain) NSArray *showChannels;
@property (nonatomic,retain) NSArray *classicChannles;

@property (nonatomic,assign) FMDiscoverControllerButton activeTab;

@end

@implementation FMDiscoverController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        FMDiscoverMusicView *myView = [[FMDiscoverMusicView alloc] initWithFrame:self.view.frame];
        self.view = myView;
        _contentView = myView;
        [myView release];
        
        _contentView.tableView.delegate = self;
        _contentView.tableView.dataSource = self;
        
        _contentView.hzButton.tag = FMDiscoverControllerButtonHZ;
        _contentView.showButton.tag = FMDiscoverControllerButtonShow;
        [_contentView.hzButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [_contentView.showButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        self.tabBarItem.title = @"发现音乐";
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(loadClassicalChannels)
                                                     name:kFMChannelUpdatorDidUpdateChannels
                                                   object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(loadShows)
                                                     name:kFMChannelUpdatorDidUpdateShows
                                                   object:nil];
    }
    return self;
}

- (void)buttonClicked:(id)sender
{
    UIButton *button = sender;
    [self activateTab:button.tag];
}

- (void)activateTab:(FMDiscoverControllerButton)buttonTag
{
    switch (buttonTag) {
        case FMDiscoverControllerButtonShow:
        {
            self.channels = _showChannels;
            self.activeTab = FMDiscoverControllerButtonShow;
        }
            break;
            
        case FMDiscoverControllerButtonHZ:
        {
            self.channels = _classicChannles;
            self.activeTab = FMDiscoverControllerButtonHZ;
        }
            break;
    }
 
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadInitialData];
    // Do any additional setup after loading the view from its nib.
}

- (void)loadInitialData
{
    [self loadClassicalChannels];
    [self loadShows];
    
    [self activateTab:FMDiscoverControllerButtonHZ];
}

- (void)loadClassicalChannels
{
    FMDatabaseHelper *dbHelper = [FMDatabaseManager sharedManager].helper;
    self.classicChannles = [dbHelper getChannels];
    
    if (self.activeTab == FMDiscoverControllerButtonHZ) {
        [self activateTab:FMDiscoverControllerButtonHZ];
    }
    
}

- (void)loadShows
{
    FMDatabaseHelper *dbHelper = [FMDatabaseManager sharedManager].helper;
    self.showChannels = [dbHelper getShows];
    
    if (self.activeTab == FMDiscoverControllerButtonShow) {
        [self activateTab:FMDiscoverControllerButtonShow];
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDelegate and UITableViewDatasouce

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *const reuseIdentifier = @"DiscoverTableViewCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    
    if(!cell){
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier] autorelease];
    }
    
    FMChannel *channelForCell = _channels[indexPath.row];
    cell.textLabel.text = channelForCell.nameCN;
    
    if (!channelForCell.coverImgUrl) {
        cell.imageView.image = nil;
    }else{
    
        [[FMImagePool sharedPool] imageByURL:channelForCell.coverImgUrl completion:^(UIImage *image,BOOL cached){
            cell.imageView.image = image;
            if (!cached) {
                if (indexPath.row < [tableView numberOfRowsInSection:kDefaultSection]) {
                    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
                }
            }
        }];
        
    }
    
    [cell setAccessoryType:UITableViewCellAccessoryDetailButton];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _channels.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [FMPlayerManager sharedInstance].currentChannel = _channels[indexPath.row];
}

- (void)setChannels:(NSArray *)channels
{
    if (_channels) {
        [_channels release];
    }
    
    _channels = [channels retain];
    
    [_contentView.tableView reloadData];
    [_contentView.tableView setContentOffset:CGPointMake(0, 0)];
}

@end
