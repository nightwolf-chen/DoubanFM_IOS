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
#import "NSNotificationCenter+DoubanFM.h"

NSString *const kFMChannelUpdatorDidUpdateChannels = @"kFMChannelUpdatorDidUpdateChannels";
NSString *const kFMChannelUpdatorDidUpdateShows = @"kFMChannelUpdatorDidUpdateShows";
NSString *const kFMChannelUpdatorFailed = @"kFMChannelUpdatorFailed";

@interface FMChannelUpdator ()

@property (nonatomic,retain) NSOperationQueue *operationQueue;

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
        _operationQueue = [[NSOperationQueue alloc] init];
    }
    
    return self;
}

- (void)update
{
    [self updateShows];
    [self updateClassicalChannels];
}

- (void)updateClassicalChannels
{
    [_operationQueue addOperationWithBlock:^{
        [self p_updateClassicalChannels];
    }];
}

- (void)updateShows
{
    [self p_updateShows];
}

- (void)p_updateShows
{
    FMDatabaseHelper *dbHelper = [FMDatabaseManager sharedManager].helper;
    
    NSArray *showList = [dbHelper getShowList];
    
    if (showList.count > 0) {return;}
    
    [[FMRequestService sharedService] sendShowListRequestWithSuccess:^(FMApiResponse *response,FMApiRequest *req){
        
        FMApiResponseShowList *showListResp = (FMApiResponseShowList *)response;
        for(FMShow *show in showListResp.categorys) {
            [show syncWithDatabase];
        }
        
        [[FMRequestService sharedService] sendShowRequestWithSuccess:^(FMApiResponse *resp,FMApiRequest *req){
            FMApiResponseShow *showResp = (FMApiResponseShow *)resp;
            FMApiRequestShow *showReq = (FMApiRequestShow *)req;
            for(FMChannel *channel in showResp.channels){
                channel.categoryId = showReq.showRequested.showid;
                channel.categoryName = showReq.showRequested.showName;
                [channel syncWithDatabase];
            }
        }error:^(NSError *err){
            NSLog(@"update shows error!");
        }shows:showListResp.categorys completion:^{
            [[NSNotificationCenter defaultCenter] postOnMainNotificationName:kFMChannelUpdatorDidUpdateShows object:self];
        }];
        
    }error:^(NSError *error){
        [[NSNotificationCenter defaultCenter] postOnMainNotificationName:kFMChannelUpdatorFailed object:self];
        NSLog(@"Update showlist error!");
    }];
}



- (void)p_updateClassicalChannels
{
    [[FMRequestService sharedService] sendFectchChannelRequestWithSuccess:^(FMApiResponse *resp,FMApiRequest *req){
        
        FMApiResponseChannel *channelResp = (FMApiResponseChannel *)resp;
        for(FMChannel *channel in channelResp.channels){
            [channel syncWithDatabase];
        }
        [[NSNotificationCenter defaultCenter] postOnMainNotificationName:kFMChannelUpdatorDidUpdateChannels
                                                                   object:self];
        
    } error:^(NSError *error){
        [[NSNotificationCenter defaultCenter] postOnMainNotificationName:kFMChannelUpdatorFailed object:self];
        NSLog(@"Update classical channels error!");
    }];
 
}

@end
