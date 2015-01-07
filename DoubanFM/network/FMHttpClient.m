//
//  FMHttpClient.m
//  DoubanFM
//
//  Created by nirvawolf on 25/5/14.
//  Copyright (c) 2014 nirvawolf. All rights reserved.
//

#import "FMHttpClient.h"
#import "AFNetworking.h"

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
    [[AFHTTPRequestOperationManager manager] GET:urlStr
                                      parameters:nil
                                         success:^(AFHTTPRequestOperation *op,id respObj){
                                             [_delegate client:self didFinishLoadingData:op.responseData];
                                         }
                                         failure:^(AFHTTPRequestOperation *op, NSError *error){
                                             [_delegate client:self didFailWithError:error];
                                         }];
    return YES;
}

- (BOOL)doPost:(NSString *)urlStr parameters:(NSDictionary *)values
{
     [[AFHTTPRequestOperationManager manager] GET:urlStr
                                      parameters:values
                                         success:^(AFHTTPRequestOperation *op,id respObj){
                                             [_delegate client:self didFinishLoadingData:op.responseData];
                                         }
                                         failure:^(AFHTTPRequestOperation *op, NSError *error){
                                             [_delegate client:self didFailWithError:error];
                                         }];
    
    return YES;
}

- (BOOL)doGet:(NSString *)urlStr parameters:(NSDictionary *)values
{
    [[AFHTTPRequestOperationManager manager] GET:urlStr
                                      parameters:values
                                         success:^(AFHTTPRequestOperation *op,id respObj){
                                             [_delegate client:self didFinishLoadingData:op.responseData];
                                         }
                                         failure:^(AFHTTPRequestOperation *op, NSError *error){
                                             [_delegate client:self didFailWithError:error];
                                         }];
 
    return YES;
}

- (BOOL)sendRequest:(NSString *) urlStr type:(NSString *)requestType parameters:(NSDictionary *)values
{
    NSURL *url = [NSURL URLWithString:urlStr];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    [request setHTTPMethod:requestType];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
   if([requestType isEqual:@"POST"]){
       
       NSString *bodyData = [FMHttpClient dicToURLParameterString:values];
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
//    NSLog(@"finished,%@", [NSString stringWithUTF8String:[_data bytes]]);
    
    [self.delegate client:self didFinishLoadingData:[[_data copy] autorelease]];
    
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
    [self.delegate client:self didFailWithError:error];
}

#pragma mark - NSObject

- (void)dealloc
{
    if (_data) {
        [_data release];
        _data = nil;
    }
    
    [super dealloc];
}

#pragma mark - helper

+ (NSString *)dicToURLParameterString:(NSDictionary *)values
{
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
    
    return bodyData;
}

@end
