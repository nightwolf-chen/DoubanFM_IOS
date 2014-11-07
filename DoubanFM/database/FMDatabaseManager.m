//
//  FMDatabaseManager.m
//  DoubanFM
//
//  Created by exitingchen on 14/11/4.
//  Copyright (c) 2014年 nirvawolf. All rights reserved.
//

#import "FMDatabaseManager.h"

static NSString *const kDatabaseName = @"FMDatabaseFile.sqlite";

static NSString *const kSQLCreateTableSongs = @" create table if not exists fm_songs ( \
song_title text , \
album_page_url text, \
album_title text, \
picture_url text, \
ssid text, \
artist text, \
song_url text, \
company text, \
subtype text, \
sid text, \
aid text, \
sha256 text, \
like int, \
length int, \
rating_average real, \
song_type int, \
current_channel int, \
primary key(song_title,artist,song_type,current_channel) \
);";

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

static NSString *const kSQLCreateTableUsers = @" create table if not exists  fm_users ( \
username text primary key, \
password text, \
token text, \
expire text, \
userid text \
);";

@implementation FMDatabaseManager

+ (instancetype)sharedManager
{
    static id s_instance ;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        s_instance = [[FMDatabaseManager alloc] _init];
    });
    
    return s_instance;
}

- (id)_init
{
    if (self = [super init]) {
        
        _databaseQueue = [[FMDatabaseQueue alloc ] initWithPath:[self databaseFilePath]];
        _helper = [[FMDatabaseHelper alloc] init]
        ;
        [_databaseQueue inDatabase:^(FMDatabase *db){
            [db executeUpdate:kSQLCreateTableSongs];
            [db executeUpdate:kSQLCreateTableChannels];
            [db executeUpdate:kSQLCreateTableUsers];
        }];
    }
    
    return self;
}



- (NSString *)databaseFilePath
{
    NSArray *dirs = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDir = [dirs lastObject];
    
    return [documentDir stringByAppendingPathComponent:kDatabaseName];
}

- (FMDatabase *)database
{
    return [[[FMDatabase alloc] initWithPath:[self databaseFilePath]] autorelease];
}

@end
