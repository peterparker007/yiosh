//
//  WishListVC.h
//  ZapFashion
//
//  Created by bhumesh on 6/5/17.
//  Copyright © 2017 bhumesh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Globals.h"
#import "AppDelegate.h"



@interface WishListVC : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
     Globals *objMyGlobals;
    AppDelegate *appDelegateTemp;
}
@property (strong, nonatomic) IBOutlet UIButton *btnmenu;
@property (strong, nonatomic) IBOutlet UIButton *btnmenu2;
@property (strong, nonatomic) IBOutlet UIImageView *Logo;
@property (strong, nonatomic) IBOutlet UIImageView *divder;
@property (strong, nonatomic) IBOutlet UIButton *btnCart;
@property (strong, nonatomic) IBOutlet UITableView *tblvw;
@property (strong, nonatomic) IBOutlet UIView *TopView;
@property (strong, nonatomic) IBOutlet UILabel *HeaderTitle;
-(void)getWishList;
- (IBAction)btnCartTapped:(id)sender;
-(void)DisplayBadge;
- (IBAction)ClearWishListData:(id)sender;
-(void)ClearWishList;
@property (strong, nonatomic) IBOutlet UILabel *tempBadge;
@end
