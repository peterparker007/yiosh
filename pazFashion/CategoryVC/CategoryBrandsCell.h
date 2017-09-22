//
//  CategoryBrandsCell.h
//  ZapFashion
//
//  Created by bhumesh on 6/14/17.
//  Copyright © 2017 bhumesh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CategoryBrandsCell : UICollectionViewCell
@property (strong, nonatomic) IBOutlet UIImageView *imgVW;
@property (strong, nonatomic) IBOutlet UIImageView *ImgVW2;
@property (strong, nonatomic) IBOutlet UILabel *lblTag;
-(void)downloadFile:(NSURL *)fileUrl forIndexPath:(NSIndexPath *)indexPath cacheKey:(NSString*)cacheKey;
@end
