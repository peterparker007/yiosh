//
//  ChangePasswordVC.h
//  ZapFashion
//
//  Created by bhumesh on 8/18/17.
//  Copyright © 2017 bhumesh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Globals.h"

#import "AppDelegate.h"
@interface ChangePasswordVC : UIViewController<UITextFieldDelegate>
{
    AppDelegate *appDelegateTemp;
}
@property (strong, nonatomic) IBOutlet UITextField *txtCurrentPassword;
@property (strong, nonatomic) IBOutlet UITextField *txtPassword;
@property (strong, nonatomic) IBOutlet UITextField *txtConfirm;
@property (strong, nonatomic) IBOutlet UIView *TopView;
@property (strong, nonatomic) IBOutlet UIButton *btnSave;
- (IBAction)btnSaveTapped:(id)sender;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UILabel *HeaderTitle;
- (IBAction)btnBackTapped:(id)sender;
@property (strong, nonatomic) IBOutlet UIImageView *divider;
@property (strong, nonatomic) IBOutlet UIImageView *Logo;
@end
