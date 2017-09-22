//
//  SettingsVC.h
//  ZapFashion
//
//  Created by bhumesh on 6/5/17.
//  Copyright © 2017 bhumesh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WelcomeVC.h"
@interface SettingsVC : UIViewController
- (IBAction)btnLogoutTapped:(id)sender;
@property (strong, nonatomic) IBOutlet UISwitch *switchHandler;
@property (strong, nonatomic) IBOutlet UIView *TopView;
@property (strong, nonatomic) IBOutlet UILabel *HeaderTitle;
- (IBAction)ChangeSwitch:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *btnmenu;
@end
