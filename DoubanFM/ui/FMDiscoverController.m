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

@interface FMDiscoverController ()

@property (nonatomic,assign) FMDiscoverMusicView *contentView;
@property (nonatomic,retain) NSArray *channels;

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
        
        self.tabBarItem.title = @"发现音乐";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadChannels];
    // Do any additional setup after loading the view from its nib.
}

- (void)loadChannels
{
    [[FMRequestService sharedService] sendFectchChannelRequestWithSuccess:^(FMApiResponse *response){
        FMApiResponseChannel *channelResponse = (FMApiResponseChannel *)response;
        self.channels = channelResponse.channels;
        [_contentView.tableView reloadData];
    }
                                                                    error:^(NSError *error){
                                                                        NSLog(@"%@",error.localizedDescription);
                                                                    }];
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
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    }
    
    cell.textLabel.text =  ((FMChannel *)_channels[indexPath.row]).nameCN;
    
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

@end
