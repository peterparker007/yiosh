//
//  CategoryDetailsVC.h
//  ZapFashion
//
//  Created by disha on 6/6/17.
//  Copyright © 2017 bhumesh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PriceSlider.h"
#import "Globals.h"
@interface CategoryDetailsVC : UIViewController<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>
{
    NSMutableArray  *arrPrice,*arrProductImage,*arrDiscountPrice,*arrWishList;
    NSMutableDictionary *FilterData;
    Globals *objMyGlobals;
    BOOL filterDone;
    
    UIRefreshControl  *refreshControl ;
    UIActivityIndicatorView *indicatorFooter;
    int pagenum,SortedIndex;
    NSMutableArray  *arrayForBool;
    NSMutableArray *sectionTitleArray,*child;

}
@property (strong, nonatomic) IBOutlet UIImageView *imgDivider;

@property (strong, nonatomic) IBOutlet UIButton *btnFilter;
@property (strong, nonatomic) IBOutlet UICollectionView *categoryCollView;
@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;
- (IBAction)btnBackClicked:(id)sender;
- (IBAction)btnSoryBtClicked:(id)sender;
- (IBAction)btnGridToListTapped:(id)sender;
- (IBAction)btnFilterClicked:(id)sender;

- (IBAction)SearchTapped:(id)sender ;
@property (strong, nonatomic) IBOutlet UIButton *btnSortby;
@property (strong, nonatomic) IBOutlet UIButton *btnBack;
@property (strong, nonatomic) NSString *strType;
@property (strong, nonatomic) IBOutlet UIButton *btnList_Grid;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *viewTrailingConstraints;
@property (strong, nonatomic) IBOutlet UIView *viewFilter;
@property (strong, nonatomic) IBOutlet UICollectionView *collViewColor;
@property (strong, nonatomic) IBOutlet UIView *vwWithNoFilter;
- (IBAction)sliderValueChanged:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *lblValueFilter;
@property (strong, nonatomic) IBOutlet UILabel *lblMinValue;
- (IBAction)btnCheckoutTapped:(id)sender;

@property (strong, nonatomic) IBOutlet UITableView *tblvwDetails;

@property (strong, nonatomic) IBOutlet UIView *TopView;
@property (strong, nonatomic) IBOutlet UILabel *HeaderTitle;
@property (nonatomic, retain) NSIndexPath *selectedIndexPath;
@property (strong, nonatomic) IBOutlet PriceSlider *SliderForPrice;
@property (strong, nonatomic) IBOutlet UIButton *btnClearFilter;
@property (strong, nonatomic) IBOutlet UIButton *btnApplyFilter;
- (IBAction)sliderValueChange:(id)sender;
- (IBAction)btnApplyFilterTapped:(id)sender;
- (IBAction)btnClearFilterTapped:(id)sender;
-(void)RemoveItemWishList:(NSString*)prdctid;
-(void)addItemWishList:(NSString*)prdctid;
@property (strong, nonatomic) IBOutlet UILabel *tempBadge;
@property (strong, nonatomic) IBOutlet UITableView *tblvw;
@property (strong, nonatomic) IBOutlet UIImageView *Logo;
@property (strong, nonatomic) IBOutlet UIImageView *divder;
@property (strong, nonatomic) IBOutlet UIButton *btnCart;
@property (strong, nonatomic) IBOutlet UIButton *btnSearch;
@end
