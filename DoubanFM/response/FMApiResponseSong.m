//
//  FMApiResponseSong.m
//  DoubanFM
//
//  Created by nirvawolf on 26/5/14.
//  Copyright (c) 2014 nirvawolf. All rights reserved.
//

#import "FMApiResponseSong.h"
#import "FMSong.h"

@implementation FMApiResponseSong

- (id)initWithData:(NSData *)data
{
    self = [super init];
    
    if (self) {
        
        if (data){
    
            NSMutableArray *songs = [NSMutableArray array];
            
            NSError *error;
            NSDictionary *jsonObjec = [NSJSONSerialization JSONObjectWithData:data
                                                                      options:NSJSONReadingMutableLeaves
                                                                        error:&error];
            
            _isSuccess = [[jsonObjec objectForKey:@"r"] intValue] == 0 ? true : false;
            _versionMax = [[jsonObjec objectForKey:@"version_max"] intValue];
            
            NSArray *songsArray = [jsonObjec objectForKey:@"song"];
            
            for(NSDictionary *songDic in songsArray){
                
                FMSong *aSong = [[FMSong alloc] init];
                
                aSong.albumPageUrl = [songDic objectForKey:@"album"];
                aSong.pictureUrl = [songDic objectForKey:@"picture"];
    //            aSong.ssid = songObj.getString("ssid");
                aSong.artist = [songDic objectForKey:@"artist"];
                aSong.songUrl = [songDic objectForKey:@"url"];
                aSong.company = [songDic objectForKey:@"company"];
                aSong.songTitle = [songDic objectForKey:@"title"];
                aSong.ratingAverage = [[songDic objectForKey:@"rating_avg"] doubleValue];
                aSong.length = [[songDic objectForKey:@"length"] intValue];
                aSong.subtype = [songDic objectForKey:@"subtype"];
                aSong.sid = [songDic objectForKey:@"sid"];
                aSong.aid = [songDic objectForKey:@"aid"];
                aSong.sha256 = [songDic objectForKey:@"sha256"];
                aSong.albumTitle = [songDic objectForKey:@"albumtitle"];
                aSong.like = [[songDic objectForKey:@"like"] intValue];
                
                [songs addObject:aSong];
                
                [aSong release];
            }
                
                _songs = [songs retain];
        
        }
    }
    
    return self;
}

@end
