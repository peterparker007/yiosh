
//  APICall.h

//  Bhumesh Purohit
//
//  Created by Bhumesh Purohit on 3/17/15.
//  Copyright (c) 2015 Bhumesh Purohit. All rights reserved.
//
#import <Foundation/Foundation.h>

@interface APICall : NSObject
typedef void(^completion_handler_t)(NSMutableDictionary *, NSError*error, long code);
//+(NSDictionary *)postDataToUrl:(NSString*)urlString jsonString:(NSString*)jsonString;
+(void)callPostWebService:(NSString *)urlStr andDictionary:(NSString *)parameter completion:(completion_handler_t)completion;
@end
