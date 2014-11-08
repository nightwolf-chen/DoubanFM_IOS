//
//  FMShow.h
//  DoubanFM
//
//  Created by exitingchen on 14/11/7.
//  Copyright (c) 2014年 nirvawolf. All rights reserved.
//

#import "FMEntity.h"

@interface FMShow : FMEntity

@property (nonatomic,copy) NSString *showid;
@property (nonatomic,copy) NSString *showName;

/*
 create table if not exists fm_shows(
 show_id text primary key,
 show_name text
 );
 */

@end
