//
//  ViewControllerTblCell.h
//  ZapFashion
//
//  Created by dharmesh  on 6/7/17.
//  Copyright © 2017 bhumesh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewControllerTblCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *imgView;
-(void)downloadFile:(NSURL *)fileUrl forIndexPath:(NSIndexPath *)indexPath cacheKey:(NSString*)cacheKey;
@end
