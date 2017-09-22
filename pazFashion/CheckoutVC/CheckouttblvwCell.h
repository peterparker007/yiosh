//
//  CheckouttblvwCell.h
//  ZapFashion
//
//  Created by bhumesh on 6/8/17.
//  Copyright © 2017 bhumesh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CheckouttblvwCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *imgView;
@property (strong, nonatomic) IBOutlet UILabel *itemName;
@property (strong, nonatomic) IBOutlet UILabel *NewPrice;
@property (strong, nonatomic) IBOutlet UILabel *oldPrice;
@property (strong, nonatomic) IBOutlet UILabel *lblsize;
@property (strong, nonatomic) IBOutlet UIButton *btnMinus;
@property (strong, nonatomic) IBOutlet UIButton *btnPlus;
@property (strong, nonatomic) IBOutlet UILabel *lblQty;
@property (strong, nonatomic) IBOutlet UIButton *btnQty;
@property (strong, nonatomic) IBOutlet UIButton *btnDeleteItem;
@property (strong, nonatomic) IBOutlet UITextField *txtQTY;
-(void)downloadFile:(NSURL *)fileUrl forIndexPath:(NSIndexPath *)indexPath cacheKey:(NSString*)cacheKey;

@end
