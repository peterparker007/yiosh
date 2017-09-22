//
//  CacheController.h
//  ZapFashion
//
//  Created by bhumesh on 6/8/17.
//  Copyright © 2017 bhumesh. All rights reserved.


#import <Foundation/Foundation.h>

@interface CacheController : NSObject {
    
    NSCache *cache;
}

@property (retain, nonatomic) NSCache *cache;

+(CacheController *)sharedInstance;
+(void)destroySharedInstance;

-(void)setCache:(id)obj forKey:(NSString *)key;
-(id)getCacheForKey:(NSString *)key;

@end
