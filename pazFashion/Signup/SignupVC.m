//
//  SignupVC.m
//  ZapFashion
//
//  Created by bhumesh on 6/2/17.
//  Copyright © 2017 bhumesh. All rights reserved.
//

#import "SignupVC.h"
#import "Globals.h"
#import "LoginVC.h"

@interface SignupVC ()

@end

@implementation SignupVC
@synthesize txtPassword,txtFname,txtEmail,txtMobile,txtConfirm,txtLname;
- (void)viewDidLoad {
    [super viewDidLoad];
     // Do any additional setup after loading the view.
     appDelegateTemp = (AppDelegate *)[[UIApplication sharedApplication]delegate];
//Set Text Field Images
      [self setTextFieldWithImage:[UIImage imageNamed:@"ic_user"] txtField:txtFname];
      [self setTextFieldWithImage:[UIImage imageNamed:@"ic_user"] txtField:txtLname];
      [self setTextFieldWithImage:[UIImage imageNamed:@"ic_email"] txtField:txtEmail];
      [self setTextFieldWithImage:[UIImage imageNamed:@"ic_contact"] txtField:txtMobile];
      [self setTextFieldWithImage:[UIImage imageNamed:@"ic_password"] txtField:txtPassword];
      [self setTextFieldWithImage:[UIImage imageNamed:@"ic_password"] txtField:txtConfirm];
    
}
+(NSArray*)findAllTextFieldsInView:(UIView*)view{
    NSMutableArray* textfieldarray = [[NSMutableArray alloc] init] ;
    for(id x in [view subviews]){
        if([x isKindOfClass:[UITextField class]])
            [textfieldarray addObject:x];
        if([x respondsToSelector:@selector(subviews)]){
            // if it has subviews, loop through those, too
            [textfieldarray addObjectsFromArray:[self findAllTextFieldsInView:x]];
        }
    }
    return textfieldarray;
}

-(void)viewWillAppear:(BOOL)animated
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"Data.plist"];
    NSMutableDictionary *savedValue = [[NSMutableDictionary alloc] initWithContentsOfFile: path];
    [_SignupTitle setTextColor:[self colorWithHexString:[savedValue valueForKey:@"signup_tit_col"]]];
    [_btnSignUp setBackgroundColor:[self colorWithHexString:[savedValue valueForKey:@"signup_btn_col"]]];
    
    
    NSArray* allTextFields = [SignupVC findAllTextFieldsInView:[self view]];
    for ( int i =0; i<allTextFields.count; i++) {
        //[MyAccountVC textField:allTextFields[i] andWithImg:[UIImage imageNamed:allImgTextFields[i]]];
       
        [allTextFields[i] setValue:[self colorWithHexString:[savedValue valueForKey:@"signup_field_col"]]
                        forKeyPath:@"_placeholderLabel.textColor"];
    }
   
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
    newOffset.y = textField.frame.origin.y-200;
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
//Sign Up Method
- (IBAction)btnSignupTapped:(id)sender {
    Globals *objMyGlobals;
    objMyGlobals=[Globals sharedManager];
    [self.view endEditing:YES];
    if (!(txtFname.text.length > 0)) {
        [objMyGlobals Displaymsg:self.view msg:@"FirstName cannot be blank."];
        return;
    }
    if (!(txtLname.text.length > 0)){
        [objMyGlobals Displaymsg:self.view msg:@"FirstName cannot be blank."];
        return;
    }
    else if (!(txtEmail.text.length > 0)){
        [objMyGlobals Displaymsg:self.view msg:@"Email address cannot be blank."];
        return;
    }
    else if (![self isEmailValid:txtEmail]) {
        [objMyGlobals Displaymsg:self.view msg:@"Email address is invalid"];
        //        txtEmail.text=@"";
        return;
    }
    else if(txtPassword.text.length < 4) {
        [objMyGlobals Displaymsg:self.view msg:@"Confirm should be atleast 4 characters"];
        //        txtPassword.text=@"";
        //        txtRetypePassword.text=@"";
        return;
    }
    else if (![txtPassword.text isEqualToString:txtConfirm.text]){
        [objMyGlobals Displaymsg:self.view msg:@"Password and Confirm Password does not match"];
        return;
    }
    else if (!(txtMobile.text.length<=10)) {
        [objMyGlobals Displaymsg:self.view msg:@"Please add valid Mobile number"];
        return;
    }
    // else if([Validations isconnectedToInternet])
    else if([appDelegateTemp checkInternetConnection]==true){
        objMyGlobals.user.firstName=[self.txtFname.text mutableCopy];
        objMyGlobals.user.lastName=[self.txtLname.text mutableCopy];
        objMyGlobals.user.email=[self.txtEmail.text mutableCopy];
        objMyGlobals.user.password=[self.txtPassword.text mutableCopy];
        objMyGlobals.user.mobileNum=[self.txtMobile.text mutableCopy];
       [objMyGlobals showLoaderIn:self.view];
        [objMyGlobals.user registerUser:^(NSString *str, int status){
            if(status==1){
                 [objMyGlobals hideLoader:self.view];
                UIStoryboard *objStoryboard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
                LoginVC *newView = (LoginVC *)[objStoryboard instantiateViewControllerWithIdentifier:@"LoginVC"];
                [self.navigationController pushViewController:newView animated:YES];
            }
            else{
                 [objMyGlobals hideLoader:self.view];
                UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Registration Failed" message:str delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
                [alert show];
                [objMyGlobals hideLoader:self.view];
                // [hud hide:YES];
                //  [Globals ShowAlertWithTitle:@"Error" Message:str ];
            }
        }];
    }
    else
    {
          [objMyGlobals Displaymsg:self.view msg:@"Please check Your Internet Connection"];
         [objMyGlobals hideLoader:self.view];
    }
    
}
//Check Email Validation
-(BOOL)isEmailValid:(UITextField*)textfield
{
    BOOL stricterFilter = NO;
    NSString *stricterFilterString = @"^[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}$";
    NSString *laxString = @"^.+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*$";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:textfield.text ];
}
- (IBAction)btnBackTapped:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
