//
//  FMDatabaseManager.h
//  DoubanFM
//
//  Created by exitingchen on 14/11/4.
//  Copyright (c) 2014年 nirvawolf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDB.h"
#import "FMDatabaseHelper.h"

@interface FMDatabaseManager : NSObject

@property (nonatomic,readonly) FMDatabaseQueue *databaseQueue;
@property (nonatomic,readonly) FMDatabaseHelper *helper;

+ (instancetype)sharedManager;

- (FMDatabase *)database;

@end
