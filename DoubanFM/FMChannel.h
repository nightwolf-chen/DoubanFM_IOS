//
//  FMChannel.h
//  DoubanFM
//
//  Created by nirvawolf on 26/5/14.
//  Copyright (c) 2014 nirvawolf. All rights reserved.
//

#import "FMEntity.h"

@interface FMChannel : FMEntity

@property (nonatomic,assign) int channelId;
@property (nonatomic,assign) int songNumber;
@property (nonatomic,copy) NSString *nameEn;
@property (nonatomic,copy) NSString *nameCN;
@property (nonatomic,copy) NSString *categoryId;
@property (nonatomic,copy) NSString *categoryName;
@property (nonatomic,copy) NSString *addr_en;
@property (nonatomic,copy) NSString *coverImgUrl;
@property (nonatomic,copy) NSString *introduction;

/*
 create table if not exists fm_channels(
 channel_id int primary key ,
 song_number int,
 name_en text,
 name_cn text,
 category_id text,
 category_name text,
 addr_en text,
 cover_img_url text,
 introduction text
 );
 */
@end
