//
//  SignupVC.h
//  ZapFashion
//
//  Created by bhumesh on 6/2/17.
//  Copyright © 2017 bhumesh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface SignupVC : UIViewController<UITextFieldDelegate>
{
    AppDelegate *appDelegateTemp;
}
@property (strong, nonatomic) IBOutlet UITextField *txtFname;
@property (strong, nonatomic) IBOutlet UITextField *txtLname;
@property (strong, nonatomic) IBOutlet UITextField *txtEmail;
@property (strong, nonatomic) IBOutlet UITextField *txtMobile;
@property (strong, nonatomic) IBOutlet UITextField *txtPassword;
@property (strong, nonatomic) IBOutlet UITextField *txtConfirm;
@property (strong, nonatomic) IBOutlet UIButton *btnSignUp;
- (IBAction)btnSignupTapped:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *SignupTitle;
- (IBAction)btnBackTapped:(id)sender;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@end
