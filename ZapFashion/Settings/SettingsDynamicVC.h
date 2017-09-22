//
//  SettingsDynamicVC.h
//  ZapFashion
//
//  Created by bhumesh on 8/18/17.
//  Copyright © 2017 bhumesh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
@interface SettingsDynamicVC : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    AppDelegate  *appDelegateTemp;
    NSMutableDictionary *savedValue;
}

//- (IBAction)btnLogoutTapped:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *TopView;
@property (strong, nonatomic) IBOutlet UILabel *HeaderTitle;
@property (strong, nonatomic) IBOutlet UIButton *btnmenu;
@property (strong, nonatomic) IBOutlet UITableView *tblvw;
@property (strong, nonatomic) IBOutlet UIButton *btnmenu2;
@property (strong, nonatomic) IBOutlet UIImageView *Logo;
@property (strong, nonatomic) IBOutlet UIImageView *divder;
@property (strong, nonatomic) IBOutlet UIButton *btnCart;
- (IBAction)MenuButttonTapped:(id)sender;
@property (strong, nonatomic) NSString *strTitle;
-(void)DisplayBadge;
@property (strong, nonatomic) IBOutlet UILabel *tempBadge;
@end
