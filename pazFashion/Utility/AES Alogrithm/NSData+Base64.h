//
//  NSData+Base64.m
//
//  ZapFashion
//
//  Created by bhumesh on 6/8/17.
//  Copyright © 2017 bhumesh. All rights reserved.
//
#import <Foundation/Foundation.h>

@class NSString;

@interface NSData (Base64Additions)

+ (NSData *)base64DataFromString:(NSString *)string;

@end
