//
//  LoginVC.h
//  ZapFashion
//
//  Created by bhumesh on 6/1/17.
//  Copyright © 2017 bhumesh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Globals.h"
#import "AppDelegate.h"
#import "DEMOLeftMenuViewController.h"
#import "DEMORightMenuViewController.h"
#import "UIViewController+RESideMenu.h"
@interface LoginVC : UIViewController<UITextFieldDelegate,SideMenuDelegate,UITabBarControllerDelegate,UITabBarDelegate>
{
      Globals *objMyGlobals;
    AppDelegate *appDelegateTemp;
    
}
@property (strong, nonatomic) IBOutlet UIButton *btnSignUp;
@property (strong, nonatomic) IBOutlet UIButton *btnLogin;
@property (strong, nonatomic) IBOutlet UITextField *txtUserName;
@property (strong, nonatomic) IBOutlet UITextField *txtPassword;
@property (strong, nonatomic) IBOutlet UILabel *LoginTitle;
- (IBAction)btnLoginTapped:(id)sender;

- (IBAction)btnRemembermeTapped:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *btnRemember;
- (IBAction)btnSignupTapped:(id)sender;
- (IBAction)btnBackTapped:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *forgotView;
- (IBAction)btnForgotTapped:(id)sender;
- (IBAction)ForgotSubmit:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *txtForgotEmail;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;



@end
