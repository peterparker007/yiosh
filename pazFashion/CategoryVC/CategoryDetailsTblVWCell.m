//
//  CategoryDetailsTblVWCell.m
//  ZapFashion
//
//  Created by bhumesh on 7/5/17.
//  Copyright © 2017 bhumesh. All rights reserved.
//

#import "CategoryDetailsTblVWCell.h"
#import "CacheController.h"
@implementation CategoryDetailsTblVWCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)downloadFile:(NSURL *)fileUrl forIndexPath:(NSIndexPath *)indexPath {
    
   
    dispatch_queue_t dispatchQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_async(dispatchQueue, ^ {
        //   NSString *ImageURL =[NSURL URLWithString:fileUrl];
        
        
        NSData *fileData =[NSData dataWithContentsOfURL:fileUrl];
        NSString *cacheKey = [NSString stringWithFormat:@"Cache%ld%ld", (long)indexPath.row, (long)indexPath.section];
        
        [[CacheController sharedInstance] setCache:fileData forKey:cacheKey];
        
        dispatch_async(dispatch_get_main_queue(), ^ {
            
          
            _imgView.image=[UIImage imageWithData:fileData];
            
        });
        
    });
}
@end
