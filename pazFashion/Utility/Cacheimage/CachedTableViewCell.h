
//  ZapFashion
//
//  Created by bhumesh on 6/8/17.
//  Copyright © 2017 bhumesh. All rights reserved.

#import <UIKit/UIKit.h>

@interface CachedTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *imgvw;
@property (strong, nonatomic) IBOutlet UILabel *itemDesc;

-(void)downloadFile:(NSURL *)fileUrl forIndexPath:(NSIndexPath *)indexPath;

@end
