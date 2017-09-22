//
//  CategoryTblVC.h
//  ZapFashion
//
//  Created by bhumesh on 6/2/17.
//  Copyright © 2017 bhumesh. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AppDelegate.h"
@interface CategoryTblVC : UIViewController<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>
{
    AppDelegate *appDelegateTemp;
    NSMutableArray  *arrayForBool;
    NSMutableArray *sectionTitleArray,*child;
    NSMutableArray *filteredContentList;
    BOOL isSearching;
}
@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;
@property (strong, nonatomic) IBOutlet UITableView *tblvw;
@property (strong, nonatomic) IBOutlet UIButton *btnMenu;
@property (strong, nonatomic) IBOutlet UIView *TopView;
@property (strong, nonatomic) IBOutlet UILabel *HeaderTitle;
- (IBAction)btnCartTapped:(id)sender;
- (IBAction)MenuButttonTapped:(id)sender;
- (IBAction)SearchTapped:(id)sender;
- (IBAction)rightMenuTapped:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *tempBadge;
-(void)DisplayBadge;
@property (strong, nonatomic) IBOutlet UIImageView *Logo;
@property (strong, nonatomic) IBOutlet UIImageView *divder;
@property (strong, nonatomic) IBOutlet UIButton *btnCart;
@property (strong, nonatomic) IBOutlet UIButton *btnSearch;
@property (strong, nonatomic) IBOutlet UIButton *btnMenu2;
@end
