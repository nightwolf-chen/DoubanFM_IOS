//
//  FMChannelUpdator.m
//  DoubanFM
//
//  Created by exitingchen on 14/11/7.
//  Copyright (c) 2014年 nirvawolf. All rights reserved.
//

#import "FMChannelUpdator.h"
#import "FMRequestService.h"
#import "FMDatabaseManager.h"

NSString *const kFMChannelUpdatorDidUpdateChannels = @"kFMChannelUpdatorDidUpdateChannels";
NSString *const kFMChannelUpdatorDidUpdateShows = @"kFMChannelUpdatorDidUpdateShows";
NSString *const kFMChannelUpdatorFailed = @"kFMChannelUpdatorFailed";

@interface FMChannelUpdator ()

@property (nonatomic,assign) NSInteger showCount;

@end

@implementation FMChannelUpdator

+ (instancetype)sharedUpdator
{
    static id s_instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        s_instance = [[[self class] alloc] _init];
    });
    
    return s_instance;
}

- (id)_init
{
    if (self = [super init]) {
        
    }
    
    return self;
}

- (void)update
{
    [self updateShows];
    [self updateClassicalChannels];
}

- (void)updateShows
{
    FMDatabaseHelper *dbHelper = [FMDatabaseManager sharedManager].helper;
    
    NSArray *showList = [dbHelper getShowList];
    if (showList.count > 0) {
        return;
    }
    
    [[FMRequestService sharedService] sendShowListRequestWithSuccess:^(FMApiResponse *response){
        
        FMApiResponseShowList *showListResp = (FMApiResponseShowList *)response;
        for(FMShow *show in showListResp.categorys){
            [show syncWithDatabase];
            [self p_updateShow:show];
        }
        
        self.showCount = showListResp.categorys.count;
        
    }error:^(NSError *error){
        [[NSNotificationCenter defaultCenter] postNotificationName:kFMChannelUpdatorFailed object:self];
        NSLog(@"Update showlist error!");
    }];
}

- (void)updateClassicalChannels
{
    [[FMRequestService sharedService] sendFectchChannelRequestWithSuccess:^(FMApiResponse *resp){
        FMApiResponseChannel *channelResp = (FMApiResponseChannel *)resp;
        int index = 0;
        for(FMChannel *channel in channelResp.channels){
            [channel syncWithDatabase:^(BOOL is){
                if (index == channelResp.channels.count - 1) {
                    [[NSNotificationCenter defaultCenter] postNotificationName:kFMChannelUpdatorDidUpdateChannels
                                                                        object:self];
                }
            }];
            index++;
        }
        
    } error:^(NSError *error){
        [[NSNotificationCenter defaultCenter] postNotificationName:kFMChannelUpdatorFailed object:self];
        NSLog(@"Update showlist error!");
    }];
}


- (void)p_updateShow:(FMShow *)show
{
    [[FMRequestService sharedService] sendShowRequestWithSuccess:^(FMApiResponse *response){
        
        self.showCount = _showCount-1;
        
        FMApiResponseShow *showResp = (FMApiResponseShow *)response;
        int index = 0;
        for(FMChannel *channel in showResp.channels){
            channel.categoryId = show.showid;
            channel.categoryName = show.showName;
            [channel syncWithDatabase:^(BOOL is){
                if (index == showResp.channels.count-1 && _showCount <= 0) {
                    [[NSNotificationCenter defaultCenter] postNotificationName:kFMChannelUpdatorDidUpdateShows object:self];
                }
            }];
            index++;
        }
        
    } error:^(NSError *error){
        NSLog(@"Update show:%@ error!",show);
        [[NSNotificationCenter defaultCenter] postNotificationName:kFMChannelUpdatorFailed object:self];
    } show:show];
}

- (void)setShowCount:(NSInteger)showCount
{
    @synchronized(self){
        _showCount = showCount;
    }
}
@end
