//
//  ItemCollCell.m
//  ZapFashion
//
//  Created by dharmesh  on 6/7/17.
//  Copyright © 2017 bhumesh. All rights reserved.
//

#import "ItemCollCell.h"
#import "CacheController.h"
@implementation ItemCollCell
-(void)downloadFile:(NSURL *)fileUrl forIndexPath:(NSIndexPath *)indexPath cacheKey:(NSString*)cacheKey {
    
    
    dispatch_queue_t dispatchQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_async(dispatchQueue, ^ {
        //   NSString *ImageURL =[NSURL URLWithString:fileUrl];
        
        
        NSData *fileData =[NSData dataWithContentsOfURL:fileUrl];
        
        
        [[CacheController sharedInstance] setCache:fileData forKey:cacheKey];
        
        dispatch_async(dispatch_get_main_queue(), ^ {
            
            
            _imgItemView.image=[UIImage imageWithData:fileData];
            
        });
        
    });
}
@end
