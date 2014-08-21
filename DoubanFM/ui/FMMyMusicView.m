//
//  FMMyMusicView.m
//  DoubanFM
//
//  Created by nirvawolf on 17/8/14.
//  Copyright (c) 2014 nirvawolf. All rights reserved.
//

#import "FMMyMusicView.h"
#import "FMPlayerView.h"
#import "FMPlayerViewController.h"
#import "FMUserCenterController.h"

@interface FMMyMusicView ()


@end

static const int kCellHeight[] = {200,60,60,60,60};

@implementation FMMyMusicView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView setDataSource:self];
        [_tableView setDelegate:self];
        [self addSubview:_tableView];
        
        self.backgroundColor = [UIColor redColor];
        _tableView.backgroundColor = [UIColor blueColor];
    }
    
    return self;
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    self.tableView.frame = CGRectMake(0, 0, SCREEN_SIZE.width, frame.size.height-[FMPlayerView smallPlayerHeight]);
}

#pragma mark - UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *const reuseableIdentifier = @"reuseableTableCell";
    UITableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:reuseableIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseableIdentifier];
        [cell autorelease];
    }
    
    [self setCell:cell ForIndexPath:indexPath];
    
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kCellHeight[indexPath.row];
}

- (void)setCell:(UITableViewCell *)cell ForIndexPath:(NSIndexPath *)indexPath
{
    
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    
    switch (indexPath.row) {
        case 0:
        {
            cell.backgroundColor = [UIColor blackColor];
            [cell setAccessoryType:UITableViewCellAccessoryNone];
        }
            break;
            
        case 1:
        {
            cell.textLabel.text = @"我的离线";
        }
            break;
        case 2:
        {
            cell.textLabel.text = @"手机里的歌曲";
        }
            break;
        case 3:
        {
            cell.textLabel.text = @"我的收藏";
        }
            break;
        case 4:
        {
            cell.textLabel.text = @"设置";
        }
            break;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIViewController *controller = [[FMUserCenterController alloc] initWithNibName:nil bundle:nil];
    [APP_DELEGATE.navigationController pushViewController:[controller autorelease] animated:YES];
    APP_DELEGATE.navigationController.navigationBarHidden = NO;
    
}



@end
