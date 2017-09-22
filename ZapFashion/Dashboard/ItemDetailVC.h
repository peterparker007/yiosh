//
//  ItemDetailVC.h
//  ZapFashion
//
//  Created by dharmesh  on 6/7/17.
//  Copyright © 2017 bhumesh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "Globals.h"

@interface ItemDetailVC : UIViewController<UICollectionViewDelegate,UICollectionViewDataSource,UIScrollViewDelegate,UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *aryImageData;
    AppDelegate *appDelegateTemp;
    Globals *objMyGlobals;
    UIButton *button;
    int in_stock,count;
    NSMutableArray *AttributesName;
    NSMutableArray *AttributesValue;
    NSMutableDictionary *Dict_Option;
    NSMutableArray *Arr_Options;
}
- (IBAction)btnCheckoutTapped:(id)sender;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;
@property (strong, nonatomic) IBOutlet UICollectionView *collItemView;
@property (strong, nonatomic) IBOutlet UICollectionView *collColorView;
@property (strong, nonatomic) IBOutlet UICollectionView *collSizeView;
@property (copy, nonatomic) NSMutableDictionary *DataDic;
@property (strong, nonatomic) IBOutlet UIPageControl *pageControl;
@property (strong, nonatomic) IBOutlet UILabel *lblItemName;
@property (strong, nonatomic) IBOutlet UILabel *lblDiscountPrice;
@property (strong, nonatomic) IBOutlet UILabel *lblActualPrice;
@property (strong, nonatomic) IBOutlet UIButton *btnLikeObj;
@property (strong, nonatomic) IBOutlet UIButton *btnBack;
- (IBAction)SearchTapped:(id)sender;
- (IBAction)btnFavouriteClicked:(id)sender;
- (IBAction)btnBackClicked:(id)sender;
- (IBAction)btnSizeClicked:(id)sender;
- (IBAction)btnColorClicked:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *lblQuantity;
@property (strong, nonatomic) IBOutlet UILabel *lblDescription;
@property (strong, nonatomic) IBOutlet UIButton *btnXSSize;
@property (strong, nonatomic) IBOutlet UIButton *btnSSize;
@property (strong, nonatomic) IBOutlet UIButton *btnMSize;
@property (strong, nonatomic) IBOutlet UIButton *btnLSize;
@property (strong, nonatomic) IBOutlet UIButton *btnXLSize;
@property (strong, nonatomic) IBOutlet UIButton *btnXXLSize;
@property (strong, nonatomic) IBOutlet UIButton *btnBlackColor;
@property (strong, nonatomic) IBOutlet UIButton *btnRedColor;
@property (strong, nonatomic) IBOutlet UIButton *btnYellowColor;
@property (strong, nonatomic) IBOutlet UIButton *btnSkyBlueColor;
@property (strong, nonatomic) IBOutlet UIButton *btnBlueColor;
@property (strong, nonatomic) IBOutlet UIButton *btnGreenColor;
@property (strong, nonatomic) IBOutlet UIButton *btnAddToBag;
@property (strong, nonatomic) IBOutlet UIButton *btnBuyNow;
@property (nonatomic, retain) NSIndexPath *selectedIndexPath;
- (IBAction)btnQuantityClicked:(id)sender;
- (IBAction)btnBuyNow:(id)sender;
- (IBAction)btnAddtoBag:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *lblStock;
@property (strong, nonatomic) IBOutlet UIButton *btnCart;
@property (strong, nonatomic) IBOutlet UIView *TopView;
-(void)addtocart;
@property (strong, nonatomic) IBOutlet UITableView *tblvw;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *heightTblVw;
@property (strong, nonatomic) IBOutlet UILabel *tempBadge;
@property (strong, nonatomic) IBOutlet UIView *scrlsubvw;
@property (strong, nonatomic) IBOutlet UILabel *lblQTYTitle;
@property (strong, nonatomic) IBOutlet UILabel *lblDescriptionTitle;
@property (strong, nonatomic) IBOutlet UIImageView *Logo;
@property (strong, nonatomic) IBOutlet UIImageView *divder;
@property (strong, nonatomic) IBOutlet UIButton *btnSearch;
-(void)GetData;
@end
