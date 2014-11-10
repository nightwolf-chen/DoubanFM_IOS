//
//  FMUser.m
//  DoubanFM
//
//  Created by nirvawolf on 26/5/14.
//  Copyright (c) 2014 nirvawolf. All rights reserved.
//

#import "FMUser.h"
#import "FMDatabaseManager.h"
#import "FMDB.h"

static NSString *const kSQLCreateTableUsers = @" create table if not exists  fm_users ( \
username text primary key, \
password text, \
token text, \
expire text, \
userid text \
);";



static NSString *const kSQLInsertTemplate = @"insert into fm_users values(?,?,?,?,?,?)";

static NSString *const kSQLUpdateTemplate = @"update fm_users set \
password=?,email=?,token=?,expire=?,userid=? where username=?";

static NSString *const kSQLDeleteTemplate = @"delete from fm_users where username=?";


@implementation FMUser


- (void (^)(FMDatabase *))deleteBlock
{
    void (^block)(FMDatabase *) = ^(FMDatabase *db){
        [db executeUpdate:kSQLDeleteTemplate,_username];
    };
    
     return Block_copy(block);
}

- (void (^)(FMDatabase *))syncBlock
{
    void (^block)(FMDatabase *) = ^(FMDatabase *db){
            if(![db executeUpdate:kSQLInsertTemplate,_username,_password,_email,_token,_expire,_userid]){
            [db executeUpdate:kSQLUpdateTemplate,_password,_email,_token,_expire,_userid,_username];
        }
    };
    
    return Block_copy(block);
}

+ (NSString *)sqlCreateTable
{
    return kSQLCreateTableUsers;
}

@end
