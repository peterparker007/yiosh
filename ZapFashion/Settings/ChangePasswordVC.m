//
//  ChangePasswordVC.m
//  ZapFashion
//
//  Created by bhumesh on 8/18/17.
//  Copyright © 2017 bhumesh. All rights reserved.
//

#import "ChangePasswordVC.h"

@interface ChangePasswordVC ()
{
    NSMutableDictionary *savedValue;
}
@end

@implementation ChangePasswordVC
@synthesize txtConfirm,txtPassword,txtCurrentPassword;
- (void)viewDidLoad {
    [super viewDidLoad];
     [self setTextFieldWithImage:[UIImage imageNamed:@"ic_password"] txtField:txtCurrentPassword];
    [self setTextFieldWithImage:[UIImage imageNamed:@"ic_password"] txtField:txtPassword];
    [self setTextFieldWithImage:[UIImage imageNamed:@"ic_password"] txtField:txtConfirm];
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"Data.plist"];
    savedValue = [[NSMutableDictionary alloc] initWithContentsOfFile: path];
    [_TopView setBackgroundColor: [self colorWithHexString:[savedValue valueForKey:@"header_color"]]];
    [_HeaderTitle setTextColor:[self colorWithHexString:[savedValue valueForKey:@"header_text_color"]]];
    [_btnSave setBackgroundColor:[self colorWithHexString:[savedValue valueForKey:@"signup_btn_col"]]];
      [self.view setBackgroundColor:[self colorWithHexString:[savedValue valueForKey:@"bg_color"]]];
    [self SetConfigForTopView];
}

-(void)SetConfigForTopView
{
    Globals *objMyGlobals;
    objMyGlobals=[Globals sharedManager];
    CGRect frame1=[objMyGlobals getXYPositions:[savedValue valueForKey:@"page_title_position"]];
    _HeaderTitle.frame=[objMyGlobals currentDevicePositions:CGRectMake(frame1.origin.x, frame1.origin.y, 145, 21) vwRect:self.view.frame];
    frame1=[objMyGlobals getXYPositions:[savedValue valueForKey:@"logo_position"]];
    _Logo.frame=[objMyGlobals currentDevicePositions:CGRectMake(frame1.origin.x, frame1.origin.y, 77, 18) vwRect:self.view.frame];
    
    CGRect frame= _divider.frame;
    frame.origin.y= _TopView.frame.size.height;
    frame.size.width= _TopView.frame.size.width;
    _divider.frame=frame;
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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    
    CGPoint newOffset;
    newOffset.x = 0;
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

- (IBAction)btnBackTapped:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)btnSaveTapped:(id)sender {
    Globals *objMyGlobals;
    objMyGlobals=[Globals sharedManager];
    [self.view endEditing:YES];
    appDelegateTemp = (AppDelegate *)[[UIApplication sharedApplication]delegate];
//    if (![[[NSUserDefaults standardUserDefaults] objectForKey:@"password"] isEqualToString:txtCurrentPassword.text]){
//        [objMyGlobals Displaymsg:self.view msg:@"Password and Confirm Password does not match"];
//        return;
//    }
    if (![[[NSUserDefaults standardUserDefaults] objectForKey:@"password"]  isEqualToString:txtCurrentPassword.text]){
        [objMyGlobals Displaymsg:self.view msg:@"Current Password is Wrong."];
        return;
    }
   else if(txtPassword.text.length < 4) {
        [objMyGlobals Displaymsg:self.view msg:@"Password should be atleast 4 characters"];
       
        return;
    }
    else if (![txtPassword.text isEqualToString:txtConfirm.text]){
        [objMyGlobals Displaymsg:self.view msg:@"New Password and Confirm Password does not match"];
        return;
    }
    else if([appDelegateTemp checkInternetConnection]==true){
      
        objMyGlobals.user.password=[self.txtPassword.text mutableCopy];
       [objMyGlobals showLoaderIn:self.view];
        [objMyGlobals.user ChangePassword:^(NSString *str, int status){
            if(status==1){
                  [objMyGlobals hideLoader:self.view];
                [objMyGlobals Displaymsg:self.view msg:str];
            }
            else{
                  [objMyGlobals hideLoader:self.view];
              [objMyGlobals Displaymsg:self.view msg:str]; 
            }
        }];
    }
    else
    {
        [objMyGlobals Displaymsg:self.view msg:@"Please check Your Internet Connection"];
        [objMyGlobals hideLoader:self.view];
    }
}
@end
