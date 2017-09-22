//
//  ZapFashion
//
//  Created by bhumesh on 6/8/17.
//  Copyright © 2017 bhumesh. All rights reserved.
//

#import <Foundation/NSString.h>
#import <Foundation/NSData.h>
@interface NSString (Base64Additions)

+ (NSString *)base64StringFromData:(NSData *)data length:(NSUInteger)length;

@end
