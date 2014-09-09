//
//  FMPlayerManager.m
//  DoubanFM
//
//  Created by nirvawolf on 30/8/14.
//  Copyright (c) 2014 nirvawolf. All rights reserved.
//

#import "FMPlayerManager.h"
#import "FMPlayer.h"
#import "FMDouStreamAdaptor.h"
#import "FMChannel.h"
#import "FMApiRequestSongInfo.h"
#import "FMApiRequestSong.h"
#import "FMApiResponseSong.h"
#import "FMApiResponse.h"
#import "DOUStreamPlayer/DOUAudioStreamer.h"

static const int kCleanupCount = 10;

@interface FMPlayerManager ()

@property (nonatomic,retain) NSMutableArray *requestQueue;

@end

@implementation FMPlayerManager

+ (instancetype)sharedInstance
{
    static id _instance;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[FMPlayerManager alloc] _init];
    });
    
    return _instance;
}

+ (FMChannel *)defaultChannel
{
    FMChannel *channel = [[FMChannel alloc] init];
    channel.channelId = 0;
    channel.nameCN = @"华语";
    
    return [channel autorelease];
}

- (id)init
{
    NSAssert(NO,@"Must use sharedManager");
    return nil;
}

- (void)dealloc
{
    SAFE_DELETE(_activePlayer);
    SAFE_DELETE(_requestQueue);
    
    [super dealloc];
}

- (id)_init
{
    if (self = [super init]) {
        
        _activePlayer          = [[FMPlayer defaultPlayer] retain];
        _activePlayer.delegate = self;
        _currentChannel        = [[self.class defaultChannel] retain];
        _requestQueue          = [[NSMutableArray alloc] init];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(playerStatusDidChange:)
                                                     name:FMDounStreamAdaptorStatusChangedNotification
                                                   object:nil];
        
        [self loadSongsFromServer:SongRequestTypeNEW];
        
    }
    return self;
}

- (void)loadSongsFromServer:(SongRequestType)type
{
    FMApiRequestSongInfo *info = [[FMApiRequestSongInfo alloc] initWith:type
                                                                   song:nil
                                                                channel:_currentChannel];

    FMApiRequest *request = [[FMApiRequestSong alloc] init:info
                                       completion:^(FMApiResponse *response){
                                           
                                            FMApiResponseSong *songResp = (FMApiResponseSong *)response;
                                            _activePlayer.songs = songResp.songs;
                                            _activePlayer.currentChannel = _currentChannel;
                                            [_activePlayer play];
                                            [self cleanupRequestQueue];
                                       
                                       }
                                         errBlock:^(NSError *error){
                                             
                                             [self handleRequestError];
                                             [self cleanupRequestQueue];
                                             
                                    }];
    
    [_requestQueue addObject:request];
    
    [request sendRequest];
    [request release];
    
    [info release];
}

- (void)operateSongWithType:(SongRequestType)type
{
    FMApiRequestSongInfo *info = [self requestInfoForCurrentSongWithType:type];
    FMApiRequest *request = [[FMApiRequestSong alloc] init:info
                                                completion:^(FMApiResponse *response){
                                                    
                                                    NSLog(@"-Song operation %d did success-",type);
                                                    [self cleanupRequestQueue];
                                                    
                                                }
                                                errBlock:^(NSError *error){
    
                                                    [self handleRequestError];
                                                    [self cleanupRequestQueue];
                                                      
                                              }];
    
    [request sendRequest];
    [_requestQueue addObject:request];
    
    [request release];
}

- (void)setCurrentChannel:(FMChannel *)currentChannel
{
    SAFE_DELETE(_currentChannel);
    
    _currentChannel = [currentChannel retain];
    
    SongRequestType type;
    if ([_activePlayer unplayedSongNumber] > 0) {
        type = SongRequestTypePLAYING;
    }else{
        type = SongRequestTypeNEW;
    }
    [self loadSongsFromServer:type];
}

- (FMApiRequestSongInfo *)requestInfoForCurrentSongWithType:(SongRequestType)type;
{
    FMApiRequestSongInfo *info = [[FMApiRequestSongInfo alloc] initWith:type
                                                                   song:_activePlayer.currentSong
                                                                channel:_currentChannel];
    
    return [info autorelease];
}



#pragma helpers

- (void)handleRequestError
{
    NSLog(@"Request network error!");
}

- (void)cleanupRequestQueue
{
    static int count = kCleanupCount;
    
    if (count-- > 0){
        return;
    }else{
        count = kCleanupCount;
    }
    
    NSMutableIndexSet *indexSet = [NSMutableIndexSet indexSet];
    for(int i = 0 ; i < _requestQueue.count ;i++){
        if(((FMApiRequest *)_requestQueue[i]).isFinished){
            [indexSet addIndex:i];
        }
    }
    [_requestQueue removeObjectsAtIndexes:indexSet];
}


#pragma mark Notification handler
- (void)playerStatusDidChange:(NSNotification *)notificatioin
{
    NSDictionary *userInfo = notificatioin.userInfo;
    
    if ([userInfo[@"status"] integerValue] == DOUAudioStreamerFinished){
        
        if ([_activePlayer unplayedSongNumber] > 0) {
            [_activePlayer skip];
        }else{
            [self loadSongsFromServer:SongRequestTypeNEW];
        }
        
    }
}

#pragma mark - FMPlayer delegate
- (void)player:(FMPlayer *)player didMoveSongToTrash:(FMSong *)song
{
    [self operateSongWithType:SongRequestTypeBYE];
}

- (void)player:(FMPlayer *)player didSkipSong:(FMSong *)song
{
    [self operateSongWithType:SongRequestTypeSKIP];
}

- (void)player:(FMPlayer *)player didLikeSong:(FMSong *)song
{
    [self operateSongWithType:SongRequestTypeRATE];
}

- (void)player:(FMPlayer *)player didDislikeSong:(FMSong *)song
{
    [self operateSongWithType:SongRequestTypeUNRATE];
}

- (void)player:(FMPlayer *)player didEndSong:(FMSong *)song
{
    [self operateSongWithType:SongRequestTypeEND];
}

@end
