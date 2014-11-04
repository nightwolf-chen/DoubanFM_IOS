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

@property (nonatomic,assign) int songType;
@property (nonatomic,assign) int currentChannel;

/*
 create table if not exists fm_songs (
    song_title text ,
    album_page_url text,
    album_title text,
    picture_url text,
    ssid text,
    artist text,
    song_url text,
    company text,
    subtype text,
    sid text,
    aid text,
    sha256 text,
    like int,
    length int,
    rating_average real,
    song_type int,
    current_channel int,
    primary key(song_title,artist,song_type,current_channel)
 );
 */

@end
