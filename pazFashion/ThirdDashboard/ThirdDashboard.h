//
//  ThirdDashboard.h
//  ZapFashion
//
//  Created by bhumesh on 7/20/17.
//  Copyright © 2017 bhumesh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CategoryDetailCollCell.h"
#import "ItemCollCell.h"

#import "AppDelegate.h"
#import "Globals.h"


@interface ThirdDashboard : UIViewController<UISearchBarDelegate>{
    AppDelegate *appDelegateTemp;
    NSArray *arrImageData,*aryItemData,*tempMoveData;
    NSMutableArray *arrMostviewedData,*arrDiscountedData,*arrBestsellerData;
    NSTimer *timer;
    int currMinute;
    int currSeconds;
    int currHrs;
    Globals *objMyGlobals;
}
@property (strong, nonatomic) IBOutlet UICollectionView *collItemView;
@property (strong, nonatomic) IBOutlet UICollectionView *collectionvw;
@property (strong, nonatomic) IBOutlet UICollectionView *collectionvw2;
@property (strong, nonatomic) IBOutlet UICollectionView *collectionvw3;
@property (strong, nonatomic) IBOutlet UILabel *tempBadge;
@property (strong, nonatomic) IBOutlet UIPageControl *pageControl;
@property (strong, nonatomic) IBOutlet UIButton *btnMenu;
@property (strong, nonatomic) IBOutlet UILabel *lblTimer;
@property (strong, nonatomic) IBOutlet UIView *TopView;
@property (strong, nonatomic) IBOutlet UILabel *HeaderTitle;
@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;
- (IBAction)MenuButttonTapped:(id)sender;
- (IBAction)btnCartTapped:(id)sender;
- (IBAction)ViewAllData:(id)sender;
- (IBAction)SearchTapped:(id)sender;
-(void)GetData:(NSString*)type;
-(void)GetData;
@property (strong, nonatomic) IBOutlet UIView *scrlsubvw;
@property (strong, nonatomic) IBOutlet UIButton *btnmenu2;
@property (strong, nonatomic) IBOutlet UIImageView *Logo;
@property (strong, nonatomic) IBOutlet UIImageView *divder;
- (IBAction)rightMenuTapped:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *btnSearch;
@property (strong, nonatomic) IBOutlet UIButton *btnCart;
@end
