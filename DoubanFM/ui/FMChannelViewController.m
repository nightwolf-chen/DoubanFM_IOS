//
//  FMChannelViewController.m
//  DoubanFM
//
//  Created by nirvawolf on 19/6/14.
//  Copyright (c) 2014 nirvawolf. All rights reserved.
//

#import "FMChannelViewController.h"
#import "FMApiRequestChannel.h"
#import "FMApiResponseChannel.h"
#import "FMChannelCell.h"
#import "FMNotifications.h"

static NSString *cellIdentifier = @"channelCell";

@interface FMChannelViewController ()
{
    UITableView *_tableView;
    NSMutableArray *_channels;
}
@property (retain, nonatomic) FMApiRequestChannel *channelRequest;

@end

@implementation FMChannelViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.tabBarItem = [[[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemFeatured
                                                                        tag:UITabBarSystemItemFeatured] autorelease];
        _tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];       
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerNib:[UINib nibWithNibName:@"FMChannelCell" bundle:nil]
                                                       forCellReuseIdentifier:cellIdentifier];
        [self.view addSubview:_tableView];

        _channelRequest = [[FMApiRequestChannel alloc] initWithDelegate:self];
        [_channelRequest sendRequest];
        
        _channels = [[NSMutableArray alloc] init];
       
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [_tableView reloadData];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - request delegate

- (void)didRecieveResponse:(FMApiResponse *)response
{
    FMApiResponseChannel *channelRespones = (FMApiResponseChannel *)response;
    _channels = [[NSMutableArray alloc] initWithArray:channelRespones.channels];
    [_tableView reloadData];
}

- (void)didFailWithError:(NSError *)error
{
    NSLog(@"Errors ocur when trying to get channels!");
}

#pragma mark - UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FMChannelCell *cell = [tableView  dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    if (!cell) {
        cell = [[[FMChannelCell alloc] initWithStyle:UITableViewCellStyleDefault
                                    reuseIdentifier:cellIdentifier] autorelease];
    }
    
    cell.channel = [_channels objectAtIndex:indexPath.row];
    
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _channels.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    FMChannelCell *cell = (FMChannelCell *)[tableView cellForRowAtIndexPath:indexPath];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:FMUIPlayerChannelChangedNotification
                                                        object:cell
                                                      userInfo:@{@"channel": cell.channel}];
    
    [self.tabBarController setSelectedIndex:0];
    
}

- (void)dealloc
{
    [_tableView release];
    [_channelRequest release];
    [_channels release];
    
    [super dealloc];
}
@end
