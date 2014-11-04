//
//  FMDatabase.h
//  DoubanFM
//
//  Created by exitingchen on 14/9/30.
//  Copyright (c) 2014年 nirvawolf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DFMDatabase : NSObject

+ (instancetype)database;

- (id)insertSong;
- (id)insertChannel;
- (id)insertUser;

- (void)deleteObject:(id)target;
- (void)deleteObjects:(NSArray *)targets;


@end
