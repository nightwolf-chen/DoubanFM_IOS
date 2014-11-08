//
//  FMShow.m
//  DoubanFM
//
//  Created by exitingchen on 14/11/7.
//  Copyright (c) 2014年 nirvawolf. All rights reserved.
//

#import "FMShow.h"
#import "FMDatabaseManager.h"

static NSString *const kSQLCreateTableShows = @" create table if not exists fm_shows( \
show_id text primary key, \
show_name text \
);";

static NSString *const kSQLInsertTemplate = @"insert into fm_shows values(?,?)";

static NSString *const kSQLUpdateTemplate = @"update fm_shows set show_id=?,show_name=? where show_id=?";

static NSString *const kSQLDeleteTemplate = @"delete from fm_shows where show_id=?";

@implementation FMShow

+ (NSString *)sqlCreateTable
{
    return kSQLCreateTableShows;
}

- (void)syncWithDatabase
{
    [[FMDatabaseManager sharedManager].databaseQueue inDatabase:^(FMDatabase *db){
        if(![db executeUpdate:kSQLInsertTemplate,_showid,_showName]){
            [db executeUpdate:kSQLUpdateTemplate,_showid,_showName,_showid];
        }
    }];
}

- (void)deleteFromDatabase
{
    [[FMDatabaseManager sharedManager].databaseQueue inDatabase:^(FMDatabase *db){
        [db executeUpdate:kSQLDeleteTemplate,_showid];
    }];
}
@end
