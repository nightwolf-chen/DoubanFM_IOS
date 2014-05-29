//
//  FMSong.h
//  DoubanFM
//
//  Created by nirvawolf on 26/5/14.
//  Copyright (c) 2014 nirvawolf. All rights reserved.
//

#import "FMEntity.h"

@interface FMSong : FMEntity

@property (nonatomic,copy) NSString *albumPageUrl;
@property (nonatomic,copy) NSString *albumTitle;
@property (nonatomic,copy) NSString *pictureUrl;
@property (nonatomic,copy) NSString *ssid;
@property (nonatomic,copy) NSString *artist;
@property (nonatomic,copy) NSString *songUrl;
@property (nonatomic,copy) NSString *company;
@property (nonatomic,copy) NSString *songTitle;
@property (nonatomic,copy) NSString *subtype;
@property (nonatomic,copy) NSString *sid;
@property (nonatomic,copy) NSString *aid;
@property (nonatomic,copy) NSString *sha256;
@property (nonatomic,assign) int like;
@property (nonatomic,assign) int length;
@property (nonatomic,assign) double ratingAverage;


@end
