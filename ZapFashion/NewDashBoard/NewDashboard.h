//
//  NewDashboard.h
//  ZapFashion
//
//  Created by bhumesh on 7/19/17.
//  Copyright © 2017 bhumesh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CategoryDetailCollCell.h"
#import "ItemCollCell.h"

#import "AppDelegate.h"
@interface NewDashboard : UIViewController<UICollectionViewDelegate,UICollectionViewDataSource,UISearchBarDelegate>{
     AppDelegate *appDelegateTemp;
    NSArray *arrImageData,*aryItemData,*tempMoveData;
}
@property (strong, nonatomic) IBOutlet UICollectionView *collItemView;
@property (strong, nonatomic) IBOutlet UICollectionView *collectionvw;
@property (strong, nonatomic) IBOutlet UIPageControl *pageControl;
@property (strong, nonatomic) IBOutlet UIView *TopView;
@property (strong, nonatomic) IBOutlet UILabel *HeaderTitle;
@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;
@property (strong, nonatomic) IBOutlet UIButton *btnMenu;
- (IBAction)btnCartTapped:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *tempBadge;
- (IBAction)MenuButttonTapped:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *btnmenu2;
@property (strong, nonatomic) IBOutlet UIImageView *Logo;
@property (strong, nonatomic) IBOutlet UIImageView *divder;
- (IBAction)rightMenuTapped:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *btnSearch;
@property (strong, nonatomic) IBOutlet UIButton *btnCart;
@end
