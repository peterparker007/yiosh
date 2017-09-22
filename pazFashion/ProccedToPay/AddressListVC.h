//
//  AddressListVC.h
//  ZapFashion
//
//  Created by bhumesh on 7/28/17.
//  Copyright © 2017 bhumesh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

#import "Globals.h"

@interface AddressListVC : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *tableData;
    AppDelegate *appDelegateTemp;
      Globals *objMyGlobals;
    NSString *selectedIndex;
}
- (IBAction)btnMakePaymentTapped:(id)sender;
- (IBAction)AddNewAddress:(id)sender;
@property (strong, nonatomic) IBOutlet UITableView *tblvw;

- (IBAction)btnBackTapped:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *btnMakePayement;
@property (strong, nonatomic) IBOutlet UIImageView *divider;
@property (strong, nonatomic) IBOutlet UIImageView *Logo;


@property (strong, nonatomic) IBOutlet UIView *TopView;
@property (strong, nonatomic) IBOutlet UIButton *btnAddNewAddress;
@property (strong, nonatomic) IBOutlet UILabel *HeaderTitle;
@end
