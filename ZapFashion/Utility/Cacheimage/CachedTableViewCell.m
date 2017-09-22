
//  ZapFashion
//
//  Created by bhumesh on 6/8/17.
//  Copyright © 2017 bhumesh. All rights reserved.

#import "CachedTableViewCell.h"
#import "CacheController.h"

@implementation CachedTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

}


-(void)downloadFile:(NSURL *)fileUrl forIndexPath:(NSIndexPath *)indexPath {
    
    [_itemDesc setText:@"Downloading file..."];
    dispatch_queue_t dispatchQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_async(dispatchQueue, ^ {
      //   NSString *ImageURL =[NSURL URLWithString:fileUrl];
       
      
        NSData *fileData =[NSData dataWithContentsOfURL:fileUrl];
        NSString *cacheKey = [NSString stringWithFormat:@"Cache%ld%ld", (long)indexPath.row, (long)indexPath.section];
        
        [[CacheController sharedInstance] setCache:fileData forKey:cacheKey];
        
        dispatch_async(dispatch_get_main_queue(), ^ {
           
            [_itemDesc setText:@"Finished downloading file!"];
            _imgvw.image=[UIImage imageWithData:fileData];
            
        });
        
    });
}

@end
