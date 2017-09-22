//
//  NotificationHistoryVC.h
//  ZapFashion
//
//  Created by bhumesh on 6/6/17.
//  Copyright © 2017 bhumesh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
@interface NotificationHistoryVC : UIViewController
{
    AppDelegate *appDelegateTemp;
    NSMutableArray *tableData;
    NSMutableDictionary *savedValue;
}
@property (strong, nonatomic) IBOutlet UIButton *btnmenu;
@property (strong, nonatomic) IBOutlet UITableView *tblvw;
@property (strong, nonatomic) IBOutlet UIView *TopView;
@property (strong, nonatomic) IBOutlet UILabel *HeaderTitle;
@property (strong, nonatomic) IBOutlet UIButton *btnmenu2;
@property (strong, nonatomic) IBOutlet UIImageView *Logo;
@property (strong, nonatomic) IBOutlet UIImageView *divder;
@property (strong, nonatomic) IBOutlet UIButton *btnCart;
- (IBAction)btnCartTapped:(id)sender;
-(void)DisplayBadge;
@property (strong, nonatomic) IBOutlet UILabel *tempBadge;
@end
