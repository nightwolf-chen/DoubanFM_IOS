//
//  FMApiResponseShowList.m
//  DoubanFM
//
//  Created by exitingchen on 14/11/7.
//  Copyright (c) 2014年 nirvawolf. All rights reserved.
//

#import "FMApiResponseShowList.h"
#import "FMShow.h"

@implementation FMApiResponseShowList

- (id)initWithData:(NSData *)data
{
    NSString *content = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    NSError *error = nil;
    NSRegularExpression *regx = [NSRegularExpression regularExpressionWithPattern:@"<li data-genre_id=\"(.*?)\" class=\"(.*?)\">(.*?)</li>"
                                                                          options:0
                                                                            error:&error];
    NSMutableArray *tmpArray = [NSMutableArray array];
    
    if (self = [super init]) {
        
        [regx enumerateMatchesInString:content options:NSMatchingWithTransparentBounds range:NSMakeRange(0, content.length) usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags,BOOL *stop){
            
            NSString *categoryId = [content substringWithRange:[result rangeAtIndex:1]];
            NSString *categoryName = [content substringWithRange:[result rangeAtIndex:3]];
            categoryName = [categoryName stringByReplacingOccurrencesOfString:@"amp;" withString:@""];
            NSLog(@"%@,%@",categoryId,categoryName);
            
            FMShow *aShow = [[[FMShow alloc] init] autorelease];
            aShow.showid = categoryId;
            aShow.showName = categoryName;
            [tmpArray addObject:aShow];
        }];
        
        _categorys = [tmpArray retain];
    }
    
    [content release];
    
    return self;
}

@end
