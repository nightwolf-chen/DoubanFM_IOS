//
//  FMEntity.h
//  DoubanFM
//
//  Created by nirvawolf on 26/5/14.
//  Copyright (c) 2014 nirvawolf. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FMDatabase;

@interface FMEntity : NSObject

+ (NSString *)sqlCreateTable;

- (void)syncWithDatabase;

- (void)syncWithDatabase:(void (^)(BOOL)) completeBlock;

- (void)deleteFromDatabase;

- (void)deleteFromDatabase:(void (^)(BOOL)) completeBlock;

- (void (^)(FMDatabase *))syncBlock;
- (void (^)(FMDatabase *))deleteBlock;

@end
