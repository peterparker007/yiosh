
//
//  APICall.m
//  Bhumesh Purohit
//
//  Created by Bhumesh Purohit on 3/17/15.
//  Copyright (c) 2015 Bhumesh Purohit. All rights reserved.
//

#import "APICall.h"

@implementation APICall


+(void)callPostWebService:(NSString *)urlStr andDictionary:(NSString *)parameter completion:(completion_handler_t)completion
{
    NSData* responseData = nil;
    NSURL *url=[NSURL URLWithString:[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    responseData = [NSMutableData data] ;
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url];
  
    NSString *bodydata=[NSString stringWithFormat:@"%@",parameter];
    
    [request setHTTPMethod:@"POST"];
    //  NSData *req=[NSData dataWithBytes:[bodydata UTF8String] length:[bodydata length]];
    NSData *req= [bodydata dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:req];
    
    NSOperationQueue *mainQueue = [NSOperationQueue mainQueue];
    __block id json;
    [NSURLConnection sendAsynchronousRequest:request queue:mainQueue completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        
        if (data == nil) {
            // Check for problems
            if (connectionError != nil) {
                
                completion(nil, connectionError,connectionError.code);
            }
        }
        else {
            
      //  json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            
         json =    [NSJSONSerialization JSONObjectWithData:data
                                            options:NSJSONReadingMutableContainers
                                              error:&connectionError];
            
            completion(json, nil,connectionError.code);
        }
    }];
}
@end
