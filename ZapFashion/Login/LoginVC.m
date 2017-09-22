//
//  LoginVC.m
//  ZapFashion
//
//  Created by bhumesh on 6/1/17.
//  Copyright © 2017 bhumesh. All rights reserved.
//
#import "LoginVC.h"
#import "DEMOLeftMenuViewController.h"
#import "ViewController.h"
#import "AppDelegate.h"
#import "SignupVC.h"
#import "CustomFontLabel.h"
#import "DetailsSettingsVC.h"
#import "SettingsDynamicVC.h"
#import "CategoryTblVC.h"
#import "MyAccountVC.h"
#import "OrderHistoryVC.h"
#import "WishListVC.h"
#import "NotificationHistoryVC.h"
@interface LoginVC ()
{
    NSMutableArray *arrTitles;
    NSMutableArray *arrImages;
    NSMutableDictionary *savedValue ;
}
@property (strong, nonatomic) ViewController *ViewController;
@property (strong, nonatomic) CategoryTblVC *CategoryTblVC;
@property (strong, nonatomic) MyAccountVC *MyAccountVC;
@property (strong, nonatomic) OrderHistoryVC *OrderHistoryVC;
@property (strong, nonatomic) WishListVC    *WishListVC;
@property (strong, nonatomic) NotificationHistoryVC *NotificationHistoryVC;
@property (strong, nonatomic) SettingsDynamicVC *SettingsDynamicVC;
@end
@implementation LoginVC
@synthesize txtPassword,txtUserName,forgotView;
- (void)viewDidLoad {
    [super viewDidLoad];
 
      [self.navigationController setNavigationBarHidden:YES];
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor yellowColor]}];
    self.navigationController.navigationBar.topItem.title  = @"Login";
    self.title = @"Login";
    self.navigationItem.title = @"Login";
  appDelegateTemp = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    appDelegateTemp.strMenuType=[@"Left" mutableCopy];
    objMyGlobals=[Globals sharedManager];
    _btnRemember.selected=true;
    forgotView.hidden=TRUE;
    forgotView.layer.cornerRadius = 5;
    forgotView.layer.masksToBounds = true;
    [self setTextFieldWithImage:[UIImage imageNamed:@"ic_email"] txtField:txtUserName];
    [self setTextFieldWithImage:[UIImage imageNamed:@"ic_password"] txtField:txtPassword];
    NSUserDefaults *defaults= [NSUserDefaults standardUserDefaults];
    if([[[defaults dictionaryRepresentation] allKeys] containsObject:@"username"]&&[[[defaults dictionaryRepresentation] allKeys] containsObject:@"password"])
    {
        txtUserName.text=[[NSUserDefaults standardUserDefaults] objectForKey:@"username"];
        txtPassword.text=[[NSUserDefaults standardUserDefaults] objectForKey:@"password"];
    }
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                          action:@selector(handleSingleTap:)];
    [self.view addGestureRecognizer:tap];
}
- (void)handleSingleTap:(UITapGestureRecognizer *)sender
{
   
    forgotView.hidden=true;
    
}
-(void)viewWillAppear:(BOOL)animated
{
     [self GetMenuData];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"Data.plist"];
    savedValue  = [[NSMutableDictionary alloc] initWithContentsOfFile: path];
    
    [_btnLogin setBackgroundColor:[self colorWithHexString:[savedValue valueForKey:@"login_btn_col"]]];
    [_btnSignUp setBackgroundColor:[self colorWithHexString:[savedValue valueForKey:@"signup_btn_on_login_col"]]];
    [_btnLogin setTitleColor:[self colorWithHexString:[savedValue valueForKey:@"login_btn_txt_col"]] forState:UIControlStateNormal];
    [_btnSignUp setTitleColor:[self colorWithHexString:[savedValue valueForKey:@"signup_btn_on_login_txt_col"]] forState:UIControlStateNormal];
     [_LoginTitle setTextColor:[self colorWithHexString:[savedValue valueForKey:@"login_tit_col"]]];
    [_txtForgotEmail setValue:[self colorWithHexString:[savedValue valueForKey:@"login_field_col"]]
                   forKeyPath:@"_placeholderLabel.textColor"];
    [txtUserName setValue:[self colorWithHexString:[savedValue valueForKey:@"login_field_col"]]
                   forKeyPath:@"_placeholderLabel.textColor"];
    [txtPassword setValue:[self colorWithHexString:[savedValue valueForKey:@"login_field_col"]]
                   forKeyPath:@"_placeholderLabel.textColor"];
    
    
}
-(UIColor*)colorWithHexString:(NSString*)hex
{
    NSString *cString = [[hex stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    // String should be 6 or 8 characters
    if ([cString length] < 6) return [UIColor grayColor];
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    if ([cString length] != 6) return  [UIColor grayColor];
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}
-(void)viewDidAppear:(BOOL)animated
{
     NSUserDefaults *defaults= [NSUserDefaults standardUserDefaults];
    if([[[defaults dictionaryRepresentation] allKeys] containsObject:@"username"]&&[[[defaults dictionaryRepresentation] allKeys] containsObject:@"password"])
    {
        txtUserName.text=[[NSUserDefaults standardUserDefaults] objectForKey:@"username"];
        txtPassword.text=[[NSUserDefaults standardUserDefaults] objectForKey:@"password"];
    }
}

#pragma textFieldDelegate
-(void)setTextFieldWithImage:(UIImage*)image txtField:(UITextField*)txtField
{
    txtField.rightViewMode = UITextFieldViewModeAlways;
    UIImageView *imageView2 = [[UIImageView alloc] initWithFrame:
                               CGRectMake(0, 0, image.size.width, image.size.height)];
    imageView2.image = image;
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, image.size.width+5, image.size.height)];
    [paddingView addSubview:imageView2];
    txtField.rightView = paddingView;
}
-(void)GetMenuData
{
    NSMutableArray *myViewControllers = [[NSMutableArray alloc] init];
      UIStoryboard *objStoryboard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    self.ViewController=(ViewController *)[objStoryboard instantiateViewControllerWithIdentifier:@"ViewController"];
    //create the view controller for the second tab
    self.CategoryTblVC = (CategoryTblVC *)[objStoryboard instantiateViewControllerWithIdentifier:@"CategoryTblVC"];
    self.MyAccountVC= (MyAccountVC *)[objStoryboard instantiateViewControllerWithIdentifier:@"MyAccountVC"];
    self.OrderHistoryVC= (OrderHistoryVC *)[objStoryboard instantiateViewControllerWithIdentifier:@"OrderHistoryVC"];
    self.WishListVC= (WishListVC *)[objStoryboard instantiateViewControllerWithIdentifier:@"WishListVC"];
    self.NotificationHistoryVC= (NotificationHistoryVC *)[objStoryboard instantiateViewControllerWithIdentifier:@"NotificationHistoryVC"];
    self.SettingsDynamicVC= (SettingsDynamicVC *)[objStoryboard instantiateViewControllerWithIdentifier:@"SettingsDynamicVC"];
    arrTitles=[NSMutableArray new];
    arrImages=[NSMutableArray new];
    if([appDelegateTemp checkInternetConnection]==true)
    {
        //  [objMyGlobals showLoaderIn:self.view];
        [objMyGlobals.user GetMenuData:^(NSString *str, int status)
         {
             if(status==1)
             {               //  [objMyGlobals hideLoader:self.view];
                 
               
                 for(int i=0;i<appDelegateTemp.ArrMenuItems.count;i++)
                 {
                     NSMutableDictionary *Parent=[[NSMutableDictionary alloc]initWithDictionary:[appDelegateTemp.ArrMenuItems objectAtIndex:i]];

                     if ([[[appDelegateTemp.ArrMenuItems objectAtIndex:i] valueForKey:@"is_cms"] isEqualToString:@"1"])
                     {
                       
                         DetailsSettingsVC *newView = (DetailsSettingsVC *)[objStoryboard instantiateViewControllerWithIdentifier:@"DetailsSettingsVC"];
                         newView.strTitle=[[appDelegateTemp.ArrMenuItems objectAtIndex:i]valueForKey:@"menu_name"];
                         newView.strContents=[[appDelegateTemp.ArrMenuItems objectAtIndex:i]valueForKey:@"content"];
                         [myViewControllers addObject:newView];
                         
                     }
                     else if ([[[appDelegateTemp.ArrMenuItems objectAtIndex:i] valueForKey:@"child"]  isEqualToString:@"1"])
                     {
                         
                         objMyGlobals.user.Menu_id=[[appDelegateTemp.ArrMenuItems objectAtIndex:i] valueForKey:@"id"];
                         SettingsDynamicVC *ObjSettingsVC = (SettingsDynamicVC *)[objStoryboard instantiateViewControllerWithIdentifier:@"SettingsDynamicVC"];
                         ObjSettingsVC.strTitle=[[appDelegateTemp.ArrMenuItems objectAtIndex:i]valueForKey:@"menu_name"];
                           [myViewControllers addObject:ObjSettingsVC];
                     }
                     else if ([[Parent objectForKey:@"menu_name"] isEqualToString:@"Home"])
                     {
                         
                         
                         UINavigationController *navigationControllerViewController = [[UINavigationController alloc] initWithRootViewController:self.ViewController] ;
                         [myViewControllers addObject:navigationControllerViewController];
                         [[myViewControllers objectAtIndex:i] setTitle: [Parent objectForKey:@"menu_name"]];
                     }
                     else if ([[Parent objectForKey:@"menu_name"] isEqualToString:@"Category"])
                     {
                    
                           UINavigationController *navigationControllerCategoryTblVC = [[UINavigationController alloc] initWithRootViewController:self.CategoryTblVC] ;
                         [myViewControllers addObject:navigationControllerCategoryTblVC];
                           [[myViewControllers objectAtIndex:i] setTitle: [Parent objectForKey:@"menu_name"]];
                     }
                     else if ([[Parent objectForKey:@"menu_name"] isEqualToString:@"My Account"])
                     {
                          UINavigationController *navigationControllerMyAccountVC = [[UINavigationController alloc] initWithRootViewController:self.MyAccountVC] ;
                         [myViewControllers addObject:navigationControllerMyAccountVC];
                            [[myViewControllers objectAtIndex:i] setTitle: [Parent objectForKey:@"menu_name"]];
                     }
                     else if ([[Parent objectForKey:@"menu_name"] isEqualToString:@"Order History"])
                     {
                         
                   UINavigationController *navigationControllerOrderHistoryVC= [[UINavigationController alloc] initWithRootViewController:self.OrderHistoryVC] ;
                         [myViewControllers addObject:navigationControllerOrderHistoryVC];
                         [[myViewControllers objectAtIndex:i] setTitle:[Parent objectForKey:@"menu_name"]];
                     }
                     
                     else if ([[Parent objectForKey:@"menu_name"] isEqualToString:@"WishList"])
                     {
                           UINavigationController *navigationControllerWishListVC= [[UINavigationController alloc] initWithRootViewController:self.WishListVC] ;                         [myViewControllers addObject:navigationControllerWishListVC];
                          [[myViewControllers objectAtIndex:i] setTitle: [Parent objectForKey:@"menu_name"]];
                     }
                     
                     else if ([[Parent objectForKey:@"menu_name"] isEqualToString:@"Notification History"])
                     {
                       UINavigationController *navigationControllerNotificationHistoryVC= [[UINavigationController alloc] initWithRootViewController:self.NotificationHistoryVC] ;                         [myViewControllers addObject:navigationControllerNotificationHistoryVC];
                          [[myViewControllers objectAtIndex:i] setTitle: [Parent objectForKey:@"menu_name"]];
                     }
                 }
                 appDelegateTemp.objtabBarController = [[MyUITabBarController alloc] init];
                 [appDelegateTemp.objtabBarController setViewControllers:myViewControllers];
                 for(int i=0;i<appDelegateTemp.ArrMenuItems.count;i++)
                 {
                      NSMutableDictionary *Parent=[[NSMutableDictionary alloc]initWithDictionary:[appDelegateTemp.ArrMenuItems objectAtIndex:i]];
                 if(i<4)
                 {
                     UITabBarItem *tabBarItem = [appDelegateTemp.objtabBarController.tabBar.items objectAtIndex:i];
                     NSURL *fileUrl =[NSURL URLWithString:[Parent objectForKey:@"icon"]];
                     
                     NSData *fileData =[NSData dataWithContentsOfURL:fileUrl];
                     
                     dispatch_async(dispatch_get_main_queue(), ^ {
                         
                         [tabBarItem setImage:[[UIImage imageWithData:fileData]imageWithRenderingMode:UIImageRenderingModeAutomatic]];
                         
                     });
                 }
                 }
                 UITableView *view = (UITableView *)appDelegateTemp.objtabBarController.moreNavigationController.topViewController.view;
                 view.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
                 view.backgroundColor = [self colorWithHexString:[savedValue valueForKey:@"drawer_bg_col"]];
                 [view setSeparatorColor:[self colorWithHexString:[savedValue valueForKey:@"mb_drw_border_col"]]];

                 int i=4;
                 if ([[view subviews] count]) {
                     for (UITableViewCell *cell in [view visibleCells]) {
                        
                        // cell.imageView.backgroundColor=[UIColor redColor];
                          cell.backgroundColor = [UIColor clearColor];
                         NSMutableDictionary *Parent=[[NSMutableDictionary alloc]initWithDictionary:[appDelegateTemp.ArrMenuItems objectAtIndex:i]];
                        
                         NSURL *fileUrl =[NSURL URLWithString:[Parent objectForKey:@"icon"]];
                         NSData *fileData =[NSData dataWithContentsOfURL:fileUrl];
                         
                         dispatch_async(dispatch_get_main_queue(), ^ {
                             UIImageView *img=[[UIImageView alloc]initWithImage:[UIImage imageWithData:fileData]];
                             img.frame=CGRectMake(5, 10, img.frame.size.width, img.frame.size.height);
                             [cell addSubview:img];
                         });
                        i++;
                    }
                 
                 }
             }
             else
             {
                 [objMyGlobals Displaymsg:self.view msg:str];
                 [objMyGlobals hideLoader:self.view];
             }
         }];
    }
    else
    {
        [objMyGlobals Displaymsg:self.view msg:@"Please check Your Internet Connection"];
        [objMyGlobals hideLoader:self.view];
    }
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    CGPoint newOffset;
    newOffset.x = 0;
    if(textField.tag==3)
        newOffset.y = textField.frame.origin.y+50;
    else
        newOffset.y = textField.frame.origin.y-100;

    [self.scrollView setContentOffset:newOffset animated:YES];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    CGPoint newOffset;
    newOffset.x = 0;
    newOffset.y = 0;
    [self.scrollView setContentOffset:newOffset animated:YES];
    NSInteger nextTag = textField.tag + 1;
    // Try to find next responder
    UIResponder* nextResponder = [textField.superview viewWithTag:nextTag];
    if (nextResponder) {
        // Found next responder, so set it.
        [nextResponder becomeFirstResponder];
    } else {
      
        // Not found, so remove keyboard.
        [textField resignFirstResponder];
    }
    return NO;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)btnLoginTapped:(id)sender {
    [self.view endEditing:YES];
    CGPoint newOffset;
    newOffset.x = 0;
    newOffset.y = 0;
    [self.scrollView setContentOffset:newOffset animated:YES];
     [[NSUserDefaults standardUserDefaults]setObject:txtPassword.text forKey:@"password"];
    if(_btnRemember.isSelected)
    {
        [[NSUserDefaults standardUserDefaults] setObject:txtUserName.text forKey:@"username"];       
    }
    else
    {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"username"];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"password"];
    }
    if (!(txtUserName.text.length > 0))
    {
        [objMyGlobals Displaymsg:self.view msg:@"Email address cannot be blank."];
        return;
    }
    else if (![self isEmailValid:txtUserName])
    {
        [objMyGlobals Displaymsg:self.view msg:@"Email address is invalid"];
        txtUserName.text=@"";
        return;
    }
    else if(!(txtPassword.text.length >3))
    {
        [objMyGlobals Displaymsg:self.view msg:@"Password needs to be longer then 3 characters"];
        txtPassword.text=@"";
        return;
    }
    else if([appDelegateTemp checkInternetConnection]==true)
    {
        objMyGlobals.user.UserName=[self.txtUserName.text mutableCopy];
    objMyGlobals.user.passwordLogin=[self.txtPassword.text mutableCopy];
        objMyGlobals.user.apikey=[@"ICXE1wOphgKgcyMoHr0hVHbbJ" mutableCopy];
        [objMyGlobals showLoaderIn:self.view];
    [objMyGlobals.user loginUser:^(NSString *str, int status)
     {
         if(status==1)
         {
            if([appDelegateTemp.strMenuType isEqualToString:@"Left"])
            {
                [objMyGlobals hideLoader:self.view];
                ViewController *objViewController=(ViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"ViewController"];
                UINavigationController *navigationController= [[UINavigationController alloc] initWithRootViewController:objViewController];
                DEMOLeftMenuViewController *leftMenuViewController = [DEMOLeftMenuViewController shareInstance];
               // DEMORightMenuViewController *rightMenuViewController = [DEMORightMenuViewController shareInstance];
                SideMenu *sideMenuViewController = [[SideMenu alloc] initWithContentViewController:navigationController
                                                                            leftMenuViewController:leftMenuViewController
                                                                           rightMenuViewController:nil];
                UIColor *background = [UIColor grayColor];
                sideMenuViewController.view.backgroundColor=background;
                sideMenuViewController.menuPreferredStatusBarStyle = 1; // UIStatusBarStyleLightContent
                sideMenuViewController.delegate = self;
                sideMenuViewController.contentViewShadowOpacity =0;
                appDelegateTemp.window.rootViewController = sideMenuViewController;
            }else if([appDelegateTemp.strMenuType isEqualToString:@"Right"])
            {
                [objMyGlobals hideLoader:self.view];
                ViewController *objViewController=(ViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"ViewController"];
                UINavigationController *navigationController= [[UINavigationController alloc] initWithRootViewController:objViewController];
             //   DEMOLeftMenuViewController *leftMenuViewController = [DEMOLeftMenuViewController shareInstance];
                DEMORightMenuViewController *rightMenuViewController = [DEMORightMenuViewController shareInstance];
                SideMenu *sideMenuViewController = [[SideMenu alloc] initWithContentViewController:navigationController
                                                                            leftMenuViewController:nil
                                                                           rightMenuViewController:rightMenuViewController];
                UIColor *background = [UIColor grayColor];
                sideMenuViewController.view.backgroundColor=background;
                sideMenuViewController.menuPreferredStatusBarStyle = 1; // UIStatusBarStyleLightContent
                sideMenuViewController.delegate = self;
                sideMenuViewController.contentViewShadowOpacity =0;
                appDelegateTemp.window.rootViewController = sideMenuViewController;
            }
            else if([appDelegateTemp.strMenuType isEqualToString:@"tab"])
             {
//                 MyUITabBarController *objMyUITabBarController=[[MyUITabBarController alloc]init];
                 [appDelegateTemp.objtabBarController setTabBarColor:[self colorWithHexString:[savedValue valueForKey:@"drawer_bg_col"]]];

                 [objMyGlobals hideLoader:self.view];
                 
                 appDelegateTemp.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
                 [appDelegateTemp.window setRootViewController:appDelegateTemp.objtabBarController];
                 
                 //set the window background color and make it visible
                 appDelegateTemp.window.backgroundColor = [UIColor whiteColor];
                 [appDelegateTemp.window makeKeyAndVisible];
             }
         }
         else
         {
             [objMyGlobals Displaymsg:self.view msg:@"Invalid Email ID and Password"];
             [objMyGlobals hideLoader:self.view];
         }
     }];
    }
    else
    {
         [objMyGlobals Displaymsg:self.view msg:@"Please check Your Internet Connection"];
   [objMyGlobals hideLoader:self.view];
        [[UIApplication sharedApplication] endIgnoringInteractionEvents];
    }
 
}
-(BOOL)isEmailValid:(UITextField*)textfield
{
    BOOL stricterFilter = NO;
    NSString *stricterFilterString = @"^[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}$";
    NSString *laxString = @"^.+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*$";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:textfield.text ];
    
}
- (IBAction)btnRemembermeTapped:(id)sender {
    _btnRemember.selected=!_btnRemember.selected;
}
- (IBAction)btnSignupTapped:(id)sender {
    UIStoryboard *objStoryboard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    CGPoint newOffset;
    newOffset.x = 0;
    newOffset.y = 0;
    [self.scrollView setContentOffset:newOffset animated:YES];
    SignupVC *newView = (SignupVC *)[objStoryboard instantiateViewControllerWithIdentifier:@"SignupVC"];
    [self.navigationController pushViewController:newView animated:YES];
}

- (IBAction)btnBackTapped:(id)sender {
      [self.navigationController popToRootViewControllerAnimated:YES];  
}
- (IBAction)btnForgotTapped:(id)sender {
    CGAffineTransform trans = CGAffineTransformScale(forgotView.transform, 0.01, 0.01);
   	// do it instantly, no animation
    forgotView.hidden=FALSE;
     forgotView.transform = trans;
    // now return the view to normal dimension, animating this tranformation
    [UIView animateWithDuration:0.5  delay:0.0 options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         forgotView.transform = CGAffineTransformScale(forgotView.transform, 100.0, 100.0);
                     }
                     completion:nil];    
}

- (IBAction)ForgotSubmit:(id)sender {
    [self.view endEditing:YES];
    CGPoint newOffset;
    newOffset.x = 0;
    newOffset.y = 0;
    [self.scrollView setContentOffset:newOffset animated:YES];
    objMyGlobals.user.email=[self.txtForgotEmail.text mutableCopy];
    objMyGlobals.user.apikey=[@"ICXE1wOphgKgcyMoHr0hVHbbJ" mutableCopy];
   [objMyGlobals showLoaderIn:self.view];
    [objMyGlobals.user ForgotPassword:^(NSString *str, int status)
     {
         if(status==1)
         {
             [objMyGlobals Displaymsg:self.view msg:str];
         [objMyGlobals hideLoader:self.view];
         }
         else
         {
             [objMyGlobals Displaymsg:self.view msg:@"Invalid Email ID"];
           [objMyGlobals hideLoader:self.view];
         }
     }];
    forgotView.hidden=TRUE;
}
@end
