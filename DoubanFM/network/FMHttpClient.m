//
//  FMHttpClient.m
//  DoubanFM
//
//  Created by nirvawolf on 25/5/14.
//  Copyright (c) 2014 nirvawolf. All rights reserved.
//

#import "FMHttpClient.h"

@interface FMHttpClient ()
{
    NSMutableData *_data;
}

@end


@implementation FMHttpClient

- (id)initWithDelegate:(id<FMHttpClientDelegate>)delegate
{
    self = [super init];
    
    if (self) {
        
        _delegate = delegate;
        
    }
    
    return self;
}

- (BOOL)doGet:(NSString *)urlStr
{
    return [self sendRequest:urlStr type:@"GET" parameters:nil];
}

- (BOOL)doPost:(NSString *)urlStr parameters:(NSDictionary *)values
{
    return [self sendRequest:urlStr type:@"POST" parameters:values];
}

- (BOOL)sendRequest:(NSString *) urlStr type:(NSString *)requestType parameters:(NSDictionary *)values
{
    NSURL *url = [NSURL URLWithString:urlStr];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    [request setHTTPMethod:requestType];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
   if([requestType isEqual:@"POST"]){
        
        NSString *bodyData = @"";
        BOOL firstP = true;
       
       for (NSString *key in values.keyEnumerator) {
            
            if (firstP) {
                firstP = false;
            }else{
                bodyData = [bodyData stringByAppendingString:@"&"];
            }
            
            NSString *tmp = [NSString stringWithFormat:@"%@=%@",key,[values objectForKey:key]];
            bodyData = [bodyData stringByAppendingString:tmp];
            
        }
        
        
        [request setHTTPBody:[NSData dataWithBytes:[bodyData UTF8String]
                                                length:strlen([bodyData UTF8String])]];
        
    }
    
    _data = [[NSMutableData alloc] init];
    NSURLConnection *connection = [NSURLConnection connectionWithRequest:request delegate:self];
    [connection start];
    
    return true;
}

#pragma mark - delegate

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSLog(@"finished,%@", [NSString stringWithUTF8String:[_data bytes]]);
    
    [_data release];
    _data = nil;
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [_data appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"error %@",error);
}

#pragma mark - NSObject

- (void)dealloc
{
    [super dealloc];
    
    if (_data) {
        [_data release];
        _data = nil;
    }
}

@end