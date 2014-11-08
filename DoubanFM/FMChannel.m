//
//  FMChannel.m
//  DoubanFM
//
//  Created by nirvawolf on 26/5/14.
//  Copyright (c) 2014 nirvawolf. All rights reserved.
//

#import "FMChannel.h"
#import "FMDatabaseManager.h"

static NSString *const kSQLCreateTableChannels = @" create table if not exists fm_channels( \
channel_id int primary key , \
song_number int, \
name_en text, \
name_cn text, \
category_id text, \
category_name text, \
addr_en text, \
cover_img_url text, \
introduction text \
);";



static NSString *const kSQLInsertTemplate = @"insert into fm_channels values(?,?,?,?,?,?,?,?,?)";

static NSString *const kSQLUpdateTemplate = @"update fm_channels set  \
song_number=?,name_en=?,name_cn=?,category_id=?,category_name=?, \
addr_en=?,cover_img_url=?,introduction=? where channel_id=?";

static NSString *const kSQLDeleteTemplate = @"delete from fm_channels where channel_id=?";

@implementation FMChannel


- (void)syncWithDatabase
{
    [[FMDatabaseManager sharedManager].databaseQueue inDatabase:^(FMDatabase *db){
        if(![db executeUpdate:kSQLInsertTemplate,@(_channelId),@(_songNumber),_nameEn,_nameCN,_categoryId,_categoryName,_addr_en,_coverImgUrl,_introduction]){
            [db executeUpdate:kSQLUpdateTemplate,_songNumber,_nameEn,_nameCN,_categoryId,_categoryName,_addr_en,_coverImgUrl,_introduction,@(_channelId)];
        }
    }];
}

- (void)deleteFromDatabase
{
    [[FMDatabaseManager sharedManager].databaseQueue inDatabase:^(FMDatabase *db){
        [db executeUpdate:kSQLDeleteTemplate,@(_channelId)];
    }];
}

+ (NSString *)sqlCreateTable
{
    return kSQLCreateTableChannels;
}
@end
