//
//  ViewController.h
//  ZapFashion
//
//  Created by bhumesh on 6/1/17.
//  Copyright © 2017 bhumesh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface ViewController : UIViewController<UITableViewDelegate, UITableViewDataSource,UISearchBarDelegate>
{
    NSMutableArray *tableData,*tempMoveData;
    AppDelegate *appDelegateTemp;
}
@property (strong, nonatomic) IBOutlet UIButton *btnmenu2;
@property (strong, nonatomic) IBOutlet UIImageView *Logo;
@property (strong, nonatomic) IBOutlet UIImageView *divder;
@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;
@property (strong, nonatomic) IBOutlet UIButton *btnmenu;
@property (strong, nonatomic) IBOutlet UITableView *tblvw;
- (IBAction)btnCartTapped:(id)sender;
-(void)DisplayBadge;
@property (strong, nonatomic) IBOutlet UIView *TopView;
@property (strong, nonatomic) IBOutlet UILabel *HeaderTitle;
@property (strong, nonatomic) IBOutlet UIButton *btnCart;
@property (strong, nonatomic) IBOutlet UILabel *tempBadge;
-(void)GetData:(NSString*)type;
- (IBAction)rightMenuTapped:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *btnSearch;
-(void)SetConfigForTopView;

@end

