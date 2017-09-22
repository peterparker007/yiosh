//
//  CategoryDetailCollCell.h
//  ZapFashion
//
//  Created by dharmesh  on 6/6/17.
//  Copyright © 2017 bhumesh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CategoryDetailCollCell : UICollectionViewCell
@property (strong, nonatomic) IBOutlet UIImageView *imgItemView;
@property (strong, nonatomic) IBOutlet UIImageView *imgCartView;
@property (strong, nonatomic) IBOutlet UILabel *lblItemName;
@property (strong, nonatomic) IBOutlet UILabel *lblDiscountPrice;
@property (strong, nonatomic) IBOutlet UILabel *lblActualPrice;
@property (strong, nonatomic) IBOutlet UIButton *btnLike;
-(void)downloadFile:(NSURL *)fileUrl forIndexPath:(NSIndexPath *)indexPath cacheKey:(NSString*)cacheKey;
@end
