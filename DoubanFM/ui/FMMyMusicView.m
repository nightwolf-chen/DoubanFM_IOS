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

@interface FMMyMusicView ()


@end

static const int kCellHeight[] = {200,60,60,60,60};

@implementation FMMyMusicView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor purpleColor];
        
        _tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView setDataSource:self];
        [_tableView setDelegate:self];
        [self addSubview:_tableView];
        
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
    switch (indexPath.row) {
        case 0:
        {
            cell.contentView.backgroundColor = [UIColor blackColor];
        }
            break;
            
        case 1:
        {
            cell.contentView.backgroundColor = [UIColor grayColor];
        }
            break;
        case 2:
        {
            cell.contentView.backgroundColor = [UIColor brownColor];
        }
            break;
        case 3:
        {
            cell.contentView.backgroundColor = [UIColor grayColor];
           
        }
            break;
        case 4:
        {
            cell.contentView.backgroundColor = [UIColor brownColor];
        }
            break;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIViewController *controller = [[FMPlayerViewController alloc] initWithNibName:nil bundle:nil];
    APP_DELEGATE.navigationController.navigationBarHidden = NO;
    [APP_DELEGATE.navigationController pushViewController:[controller autorelease] animated:YES];
}

@end
