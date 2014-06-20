//
//  FMChannelViewController.m
//  DoubanFM
//
//  Created by nirvawolf on 19/6/14.
//  Copyright (c) 2014 nirvawolf. All rights reserved.
//

#import "FMChannelViewController.h"
#import "FMApiRequestChannel.h"

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
        
        _channelRequest = [[FMApiRequestChannel alloc] init];
        [_channelRequest sendRequest];
        
        _channels = [[NSMutableArray alloc] init];
       
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
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
    
}

- (void)didFailWithError:(NSError *)error
{
    
}

#pragma mark - UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _channels.count;
}
@end
