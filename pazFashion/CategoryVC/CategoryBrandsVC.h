//
//  CategoryBrandsVC.h
//  ZapFashion
//
//  Created by bhumesh on 6/14/17.
//  Copyright © 2017 bhumesh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
@interface CategoryBrandsVC : UIViewController<UICollectionViewDelegate,UICollectionViewDataSource>
{
    NSMutableArray *arrSize, *arrImages,*arrProductImage;
    AppDelegate *appDelegateTemp;
}

@property (strong, nonatomic) IBOutlet UILabel *TitleLabel;
@property (strong, nonatomic) IBOutlet UIView *TopView;
@property (strong, nonatomic) IBOutlet UILabel *HeaderTitle;
@property (strong, nonatomic) IBOutlet UICollectionView *collectionVW;
@property (strong,nonatomic)NSMutableString *CatID,*lblTitle;
- (IBAction)btnBackTapped:(id)sender;
- (IBAction)btnCartTapped:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *tempBadge;
-(void)initView;
@end
