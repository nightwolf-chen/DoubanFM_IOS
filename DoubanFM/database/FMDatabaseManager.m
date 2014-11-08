//
//  FMDatabaseManager.m
//  DoubanFM
//
//  Created by exitingchen on 14/11/4.
//  Copyright (c) 2014年 nirvawolf. All rights reserved.
//

#import "FMDatabaseManager.h"

static NSString *const kDatabaseName = @"FMDatabaseFile.sqlite";

@interface FMDatabaseManager ()

@property (nonatomic,retain) NSArray *entityClasses;

@end

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
        _helper = [[FMDatabaseHelper alloc] init];
        
        _entityClasses = @[[FMSong class],[FMUser class],[FMShow class],[FMChannel class]];
        [_entityClasses retain];
        
        [_databaseQueue inDatabase:^(FMDatabase *db){
            for(Class clazz in _entityClasses){
                [db executeUpdate:[clazz sqlCreateTable]];
            }
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
