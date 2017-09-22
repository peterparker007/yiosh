//
//  CacheController.m
//  ZapFashion
//
//  Created by bhumesh on 6/8/17.
//  Copyright © 2017 bhumesh. All rights reserved.


#import "CacheController.h"

static CacheController *sharedInstance = nil;

@implementation CacheController

@synthesize cache;

+(CacheController *)sharedInstance {
    
    if (sharedInstance == nil) {
        
        sharedInstance = [[CacheController alloc] init];
    }
    
    return sharedInstance;
}

+(void)destroySharedInstance {
    
   
    sharedInstance = nil;
}

-(id)init {
    
    self = [super init];
    
    if (self) {
        
        self.cache = [[NSCache alloc] init] ;
    }
    
    return self;
}

-(void)setCache:(id)obj forKey:(NSString *)key {
    if(obj!=nil)
        [cache setObject:obj forKey:key];
    
}


-(id)getCacheForKey:(NSString *)key {
    
    return [cache objectForKey:key];
    
}




@end
