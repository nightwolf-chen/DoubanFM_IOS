//
//  FMEntity.m
//  DoubanFM
//
//  Created by nirvawolf on 26/5/14.
//  Copyright (c) 2014 nirvawolf. All rights reserved.
//

#import "FMEntity.h"
#import "FMDatabaseManager.h"

@implementation FMEntity

- (void)syncWithDatabase
{
    void (^block)(FMDatabase *) = [self syncBlock];
    [[FMDatabaseManager sharedManager].databaseQueue inDatabase:block];
    Block_release(block);
}

- (void)deleteFromDatabase
{
    void (^block)(FMDatabase *) = [self deleteBlock];
    [[FMDatabaseManager sharedManager].databaseQueue inDatabase:[self deleteBlock]];
    Block_release(block);
}

- (void)syncWithDatabase:(void (^)(BOOL))completeBlock
{
    void (^block)(FMDatabase *) = [self syncBlock];
    [[FMDatabaseManager sharedManager].databaseQueue inDatabase:^(FMDatabase *db){
        block(db);
        completeBlock(YES);
    }];
    Block_release(block);
}

- (void)deleteFromDatabase:(void (^)(BOOL))completeBlock
{
    void (^block)(FMDatabase *) = [self deleteBlock];
    [[FMDatabaseManager sharedManager].databaseQueue inDatabase:^(FMDatabase *db){
        block(db);
        completeBlock(YES);
    }];
    
    Block_release(block);
}

- (void (^)(FMDatabase *))deleteBlock
{
    NSAssert(NO, @"Needs an implementation");
    return NULL;
}

- (void (^)(FMDatabase *))syncBlock
{
    NSAssert(NO, @"Needs an implementation");
    return NULL;
}

+ (NSString *)sqlCreateTable
{
    return @"";
}
@end
