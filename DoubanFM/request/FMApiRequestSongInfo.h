//
//  FMApiRequestSongInfo.h
//  DoubanFM
//
//  Created by nirvawolf on 29/5/14.
//  Copyright (c) 2014 nirvawolf. All rights reserved.
//

#import <Foundation/Foundation.h>

@class  FMUser;

typedef enum{
    SongRequestTypeBYE=0,
    SongRequestTypeEND,
    SongRequestTypeSKIP,
    SongRequestTypeRATE,
    SongRequestTypeUNRATE,
    SongRequestTypeNEW,
    SongRequestTypePLAYING,
    SongRequestTypeCount
}SongRequestType;

@interface FMApiRequestSongInfo : NSObject


@property (nonatomic,retain) FMUser *user;
@property (nonatomic,copy) NSString *songId;
@property (nonatomic,copy) NSString *channelId;
@property (nonatomic,assign) SongRequestType type;

- (id)initWith:(SongRequestType)type song:(NSString *)songId channel:(NSString *)channelId;

+ (NSString *)typeString:(SongRequestType)type;

@end
