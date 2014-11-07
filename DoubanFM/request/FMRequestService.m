//
//  FMRequestService.m
//  DoubanFM
//
//  Created by exitingchen on 14/11/6.
//  Copyright (c) 2014年 nirvawolf. All rights reserved.
//

#import "FMRequestService.h"

static void *kKVOContext = &kKVOContext;

@interface FMRequestService ()

@property (nonatomic,retain) NSMutableArray *requests;

@end

@implementation FMRequestService

+ (instancetype)sharedService
{
    static id s_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        s_instance = [[[self class] alloc] _init];
    });
    
    return s_instance;
}

- (id)_init
{
    if(self = [super init]){
        _requests = [[NSMutableArray alloc] init];
    }
    
    return self;
}

- (void)sendUserAuthRequest:(FMUser *)user
                    success:(void (^)(FMApiResponse *))successBlock
                      error:(void (^)(NSError *))errorBlock
{
    FMApiRequest *request = [[[FMApiRequestUser alloc] init:user
                                                 completion:successBlock
                                                   errBlock:errorBlock] autorelease];
    [self p_sendRequest:request];
}

- (void)sendFectchChannelRequestWithSuccess:(void (^)(FMApiResponse *))successBlock
                                      error:(void (^)(NSError *))errorBlock
{
    FMApiRequest *request = [[[FMApiRequestChannel alloc] initWithComplete:successBlock
                                                                  errBlock:errorBlock] autorelease];
    [self p_sendRequest:request];
}

- (void)sendSongOperation:(FMApiRequestSongInfo *)info
                    success:(void (^)(FMApiResponse *))successBlock
                      error:(void (^)(NSError *))errorBlock
{
    FMApiRequest *request = [[[FMApiRequestSong alloc] init:info
                                                completion:successBlock
                                                  errBlock:errorBlock] autorelease];
    [self p_sendRequest:request];
}

- (void)sendShowListRequestWithSuccess:(void (^)(FMApiResponse *))successBlock
                                      error:(void (^)(NSError *))errorBlock
{
    FMApiRequest *request = [[FMApiRequestShowList alloc] initWithComplete:successBlock
                                                                  errBlock:errorBlock];
    [self p_sendRequest:request];
}

- (void)sendShowRequestWithSuccess:(void (^)(FMApiResponse *))successBlock
                             error:(void (^)(NSError *))errorBlock
                              show:(FMShow *)show
{
    FMApiRequest *request = [[FMApiRequestShow alloc] initWithComplete:successBlock
                                                                  errBlock:errorBlock
                                                                  show:show];
    [self p_sendRequest:request];
}


- (void)p_sendRequest:(FMApiRequest *)reqeust
{
    [reqeust addObserver:self forKeyPath:NSStringFromSelector(@selector(isFinished)) options:NSKeyValueObservingOptionNew context:kKVOContext];
    [_requests addObject:reqeust];
    [reqeust sendRequest];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:NSStringFromSelector(@selector(isFinished))] && context == kKVOContext) {
        
        if ([change[@"new"] boolValue]) {
            
            [object removeObserver:self forKeyPath:keyPath context:kKVOContext];
            [_requests removeObject:object];
            
        }
        
    }
}


@end
