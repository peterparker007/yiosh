//
//  collectionVWCell.h
//  ZapShop
//
//  Created by bhumesh on 7/6/17.
//  Copyright © 2017 bhumesh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface collectionVWCell : UICollectionViewCell
@property (strong, nonatomic) IBOutlet UITextView *txtView;
@property (strong, nonatomic) IBOutlet UIButton *btnEdit;
@property (strong, nonatomic) IBOutlet UIButton *btnDelete;
@end
