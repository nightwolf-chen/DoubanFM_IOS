//
//  FMEntity.h
//  DoubanFM
//
//  Created by nirvawolf on 26/5/14.
//  Copyright (c) 2014 nirvawolf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FMEntity : NSObject

+ (NSString *)sqlCreateTable;

- (void)syncWithDatabase;

- (void)deleteFromDatabase;

@end
