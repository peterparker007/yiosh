//
//  AESCrypt.h
//
//  
//  ZapFashion
//
//  Created by bhumesh on 6/8/17.
//  Copyright © 2017 bhumesh. All rights reserved.
//
#import <Foundation/Foundation.h>

@interface AESCrypt : NSObject

+ (NSString *)encrypt:(NSString *)message password:(NSString *)password;
+ (NSString *)decrypt:(NSString *)base64EncodedString password:(NSString *)password;

@end
