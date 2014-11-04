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
    NSLog(@"Implement this method to sync data with database.");
}

- (void)deleteFromDatabase
{
    NSLog(@"Implement this method to delete this object from database.");
}
@end
