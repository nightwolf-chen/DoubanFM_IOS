//
//  FMDatabaseHelper.m
//  DoubanFM
//
//  Created by exitingchen on 14/11/7.
//  Copyright (c) 2014年 nirvawolf. All rights reserved.
//

#import "FMDatabaseHelper.h"
#import "FMDatabaseManager.h"
#import "FMChannel.h"
#import "FMUser.h"

@implementation FMDatabaseHelper


- (NSArray *)getChannels
{
    NSMutableArray *tmpArray = [NSMutableArray array];
    
    FMDatabase *db = [[FMDatabaseManager sharedManager] database];
    [db open];
    FMResultSet *rs = [db executeQuery:@"select * from fm_channels where cover_img_url is null"];
    
    while([rs next]){
        FMChannel *channel = [[[FMChannel alloc] init] autorelease];
        
        channel.channelId = [rs intForColumn:@"channel_id"];
        channel.songNumber = [rs intForColumn:@"song_number"];
        channel.nameCN = [rs stringForColumn:@"name_cn"];
        channel.nameEn = [rs stringForColumn:@"name_en"];
        channel.categoryId = [rs stringForColumn:@"category_id"];
        channel.categoryName = [rs stringForColumn:@"category_name"];
        channel.addr_en = [rs stringForColumn:@"addr_en"];
        channel.coverImgUrl = [rs stringForColumn:@"cover_img_url"];
        channel.introduction = [rs stringForColumn:@"introduction"];
        
        [tmpArray addObject:channel];
    }
    [db close];
    return tmpArray;
}

- (NSArray *)getShows
{
    NSMutableArray *tmpArray = [NSMutableArray array];
    
    FMDatabase *db = [[FMDatabaseManager sharedManager] database];
    [db open];
    FMResultSet *rs = [db executeQuery:@"select * from fm_channels where cover_img_url is not null"];
    
    while([rs next]){
        FMChannel *channel = [[[FMChannel alloc] init] autorelease];
        
        channel.channelId = [rs intForColumn:@"channel_id"];
        channel.songNumber = [rs intForColumn:@"song_number"];
        channel.nameCN = [rs stringForColumn:@"name_cn"];
        channel.nameEn = [rs stringForColumn:@"name_en"];
        channel.categoryId = [rs stringForColumn:@"category_id"];
        channel.categoryName = [rs stringForColumn:@"category_name"];
        channel.addr_en = [rs stringForColumn:@"addr_en"];
        channel.coverImgUrl = [rs stringForColumn:@"cover_img_url"];
        channel.introduction = [rs stringForColumn:@"introduction"];
        
        [tmpArray addObject:channel];
    }
    [db close];
    return tmpArray;
 
}

- (NSArray *)getShowList
{
    NSMutableArray *tmpArray = [NSMutableArray array];
    
    FMDatabase *db = [[FMDatabaseManager sharedManager] database];
    [db open];
    FMResultSet *rs = [db executeQuery:@"select * from fm_shows"];
    
    while([rs next]){
        FMShow *show = [[[FMShow alloc] init] autorelease];
        show.showid = [rs stringForColumn:@"show_id"];
        show.showName = [rs stringForColumn:@"show_name"];
        
        [tmpArray addObject:show];
    }
    [db close];
    return tmpArray;
 
}

/*
create table if not exists  fm_users (
                                      username text primary key,
                                      password text,
                                      email text,
                                      token text,
                                      expire text,
                                      userid text)
*/

- (NSArray *)getUsers
{
    NSMutableArray *tmpArray = [NSMutableArray array];
    
    FMDatabase *db = [[FMDatabaseManager sharedManager] database];
    [db open];
    FMResultSet *rs = [db executeQuery:@"select * from fm_users"];
    
    while([rs next]){
        FMUser *user = [[[FMUser alloc] init] autorelease];
        user.username = [rs stringForColumn:@"username"];
        user.password = [rs stringForColumn:@"password"];
        user.email = [rs stringForColumn:@"email"];
        user.token = [rs stringForColumn:@"token"];
        user.expire = [rs stringForColumn:@"expire"];
        user.userid = [rs stringForColumn:@"userid"];
        
        [tmpArray addObject:user];
    }
    [db close];
    return tmpArray;
 
}

@end
