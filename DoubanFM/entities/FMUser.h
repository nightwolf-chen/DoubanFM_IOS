//
//  FMUser.h
//  DoubanFM
//
//  Created by nirvawolf on 26/5/14.
//  Copyright (c) 2014 nirvawolf. All rights reserved.
//

#import "FMEntity.h"

@interface FMUser : FMEntity

@property (nonatomic,copy) NSString *username;
@property (nonatomic,copy) NSString *password;
@property (nonatomic,copy) NSString *email;
@property (nonatomic,copy) NSString *token;
@property (nonatomic,copy) NSString *expire;
@property (nonatomic,copy) NSString *userid;

@end
