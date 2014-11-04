//
//  FMSong.m
//  DoubanFM
//
//  Created by nirvawolf on 26/5/14.
//  Copyright (c) 2014 nirvawolf. All rights reserved.
//

#import "FMSong.h"
#import "FMDatabaseManager.h"

static NSString *const kSQLInsertTemplate = @"insert into fm_songs values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";

static NSString *const kSQLUpdateTemplate = @"update fm_songs set  \
album_page_url=?,album_title=?,picture_url=?,ssid=?,artist=?,song_url=?, \
company=?,subtype=?,sid=?,aid=?,sha256=?,like=?,length=?,rating_average=?, \
song_type=?,current_channel=? where song_title=? and artist=? and song_type=? \
and current_channel=?";

static NSString *const kSQLDeleteTemplate = @"delete from fm_songs where  song_title=? and artist=? and song_type=? and current_channel=?";

@implementation FMSong


- (void)syncWithDatabase
{
    [[FMDatabaseManager sharedManager].databaseQueue inDatabase:^(FMDatabase *db){
        if(![db executeUpdate:kSQLInsertTemplate,_songTitle,_albumPageUrl,_albumTitle,
             _pictureUrl,_ssid,_artist,_songUrl,_company,_subtype,_sid,_aid,_sha256,@(_like),
             @(_length),@(_ratingAverage),@(_songType),@(_currentChannel)]){
            
            [db executeUpdate:kSQLUpdateTemplate,
             _albumPageUrl,_albumTitle,_pictureUrl,_ssid,
             _artist,_songUrl,_company,_subtype,_sid,_aid,_sha256,@(_like),
             @(_length),@(_ratingAverage),@(_songType),@(_currentChannel),_songTitle,_artist,@(_songType),@(_currentChannel)];
            
        }
    }];
}

- (void)deleteFromDatabase
{
    [[FMDatabaseManager sharedManager].databaseQueue inDatabase:^(FMDatabase *db){
        [db executeUpdate:kSQLDeleteTemplate,_songTitle,_artist,@(_songType),@(_currentChannel)];
    }];
}

@end
