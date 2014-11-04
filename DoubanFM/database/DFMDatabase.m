//
//  FMDatabase.m
//  DoubanFM
//
//  Created by exitingchen on 14/9/30.
//  Copyright (c) 2014年 nirvawolf. All rights reserved.
//

#import "DFMDatabase.h"
#import <CoreData/CoreData.h>

static NSString *const kDatabaseName = @"FMDatabase.xcdatamodeld";

@interface DFMDatabase ()

@property (nonatomic,retain) NSManagedObjectModel *model;
@property (nonatomic,retain) NSManagedObjectContext *context;
@property (nonatomic,retain) NSPersistentStoreCoordinator *coordinator;

@end

@implementation DFMDatabase

+ (instancetype)database
{
    static id s_instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        s_instance = [[DFMDatabase alloc] p_init];
    });
    
    return s_instance;
}

- (id)p_init
{
    self = [super init];
    if (self) {
        _model = [[NSManagedObjectModel mergedModelFromBundles:nil] retain];
        
        NSURL *storeUrl = [NSURL fileURLWithPath:[[self p_applicationDocumentsDirectory] stringByAppendingPathComponent: kDatabaseName]];
        
        _coordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:_model];
        NSError *error = nil;
        if (![_coordinator addPersistentStoreWithType:NSSQLiteStoreType
                                       configuration:nil
                                                 URL:storeUrl
                                             options:nil
                                               error:&error]) {
            NSLog(@"%@",[error localizedDescription]);
        }
        
        _context = [[NSManagedObjectContext alloc] init];
        _context.persistentStoreCoordinator = _coordinator;
    }
    
    return self;
}

- (void)dealloc
{
    SAFE_DELETE(_context);
    SAFE_DELETE(_coordinator);
    SAFE_DELETE(_model);
    
    [super dealloc];
}

- (NSString *)p_applicationDocumentsDirectory {
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                         NSUserDomainMask, YES);
    NSString *basePath = [paths firstObject];
    return basePath;
}

- (id)p_insertWithEntityName:(NSString *)name
{
    id desc = [NSEntityDescription insertNewObjectForEntityForName:name
                                                              inManagedObjectContext:_context];
    return desc;
}

- (NSArray *)p_fetchWithEntityName:(NSString *)name
{
    NSEntityDescription *desc = [NSEntityDescription entityForName:name
                                            inManagedObjectContext:_context];
    
    return [self p_fetchWithEntityDescrision:desc];
}

- (NSArray *)p_fetchWithEntityDescrision:(NSEntityDescription *)desciption
{
    NSFetchRequest *fRequest = [[NSFetchRequest alloc] init];
    fRequest.entity = desciption;
    
    NSError *error = nil;
    
    NSArray *result = [_context executeFetchRequest:fRequest error:&error];
    
    if (error) {
        NSLog(@"%@",[error localizedDescription]);
    }
    
    [fRequest release];
    
    return result;
}

- (id)insertChannel
{
    return [self p_insertWithEntityName:];
}

- (id)insertSong
{
    
}

- (id)insertUser
{
    
}

@end
