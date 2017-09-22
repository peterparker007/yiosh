//
//  AddNewAddressVC.m
//  ZapFashion
//
//  Created by dharmesh  on 6/6/17.
//  Copyright © 2017 bhumesh. All rights reserved.
//

#import "AddNewAddressVC.h"
#import "MyAccountVC.h"
@interface AddNewAddressVC ()
{
    NSMutableDictionary *savedValue;
}
@end

@implementation AddNewAddressVC
@synthesize txtCity,txtPincode,txtState,txtFullName,txtLastName,txtAddressView,txtMobileNumber,AddressDataDic;
- (void)viewDidLoad {
    [super viewDidLoad];
    objMyGlobals=[Globals sharedManager];
    appDelegateTemp = (AppDelegate *)[[UIApplication sharedApplication]delegate];
      _lblUserName.text=[NSString stringWithFormat:@"%@ %@",[appDelegateTemp.localDataDic objectForKey:@"firstname"],[appDelegateTemp.localDataDic objectForKey:@"lastname"]];
    NSString *string1=[[appDelegateTemp.localDataDic objectForKey:@"firstname"] substringToIndex:1];
    NSString *string2=[[appDelegateTemp.localDataDic objectForKey:@"lastname"] substringToIndex:1];
    NSString *string = [string1 stringByAppendingString: string2];
    
    UIImage *img=[self imageFromString:string font:[UIFont systemFontOfSize:20] size:CGSizeMake(50, 50)];
    [_imgProfileView.layer setBorderColor: [[UIColor blackColor] CGColor]];
    [_imgProfileView.layer setBorderWidth: 2.0];
    _imgProfileView.layer.cornerRadius = 22.0;
    _imgProfileView.layer.masksToBounds = YES;
    _imgProfileView.image=img;
    NSArray *allImgTextFields = [[NSArray alloc]initWithObjects:@"ic_user",@"_0001_ic_location",@"_0001_ic_location",@"_0001_ic_location",@"_0001_ic_location",@"ic_contact", nil];
    NSArray* allTextFields = [AddNewAddressVC findAllTextFieldsInView:[self view]];
    for ( int i =0; i<allTextFields.count; i++) {
        //[MyAccountVC textField:allTextFields[i] andWithImg:[UIImage imageNamed:allImgTextFields[i]]];
        [self setTextFieldWithImage:[UIImage imageNamed:allImgTextFields[i]] txtField:allTextFields[i]];
    }
    //Check Is Edit Clicked Or new Adreess add.
        if(_isEdit)
        {
           // _isEdit=true;
        AddressDataDic=[appDelegateTemp.AddressData objectAtIndex:_indexpath.row];
        txtCity.text=[AddressDataDic objectForKey:@"District"];
        txtPincode.text=[AddressDataDic objectForKey:@"postcode"];
        txtState.text=[AddressDataDic objectForKey:@"region"];
        txtFullName.text=[AddressDataDic objectForKey:@"firstname"];
        txtLastName.text=[AddressDataDic objectForKey:@"lastname"];
        txtCity.text=[AddressDataDic objectForKey:@"city"];
        txtAddressView.text=[[AddressDataDic objectForKey:@"street"] componentsJoinedByString:@"\n"];
        txtMobileNumber.text=[AddressDataDic objectForKey:@"mobile"];
    }
}
- (UIImage *)imageFromString:(NSString *)string font:(UIFont *)font size:(CGSize)size
    {
        UIGraphicsBeginImageContextWithOptions(size, NO, 0);
        
#ifdef __IPHONE_7_0
        
        [string drawInRect:CGRectMake(size.width/2-11, size.height/2-11, 100, 100) withAttributes: @{NSFontAttributeName: font}];
#else
        [string drawInRect:renderingRect withFont:font lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentCenter];
#endif
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        return image;
    }
-(void)viewWillAppear:(BOOL)animated
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"Data.plist"];
   savedValue = [[NSMutableDictionary alloc] initWithContentsOfFile: path];
 [_TopView setBackgroundColor: [self colorWithHexString:[savedValue valueForKey:@"header_color"]]];
    [_HeaderTitle setTextColor:[self colorWithHexString:[savedValue valueForKey:@"header_text_color"]]];
    [_scrlsubvw setBackgroundColor:[self colorWithHexString:[savedValue valueForKey:@"bg_color"]]];
    [self SetConfigForTopView];
}
-(void)SetConfigForTopView
{  
    _TopView.frame=[objMyGlobals currentDevicePositions:CGRectMake(0, 0, 381, 50) vwRect:self.view.frame];
   CGRect frame1=[objMyGlobals getXYPositions:[savedValue valueForKey:@"page_title_position"]];
    _HeaderTitle.frame=[objMyGlobals currentDevicePositions:CGRectMake(frame1.origin.x, frame1.origin.y, 105, 21) vwRect:self.view.frame];
    frame1=[objMyGlobals getXYPositions:[savedValue valueForKey:@"logo_position"]];
    _logo.frame=[objMyGlobals currentDevicePositions:CGRectMake(frame1.origin.x, frame1.origin.y, 77, 18) vwRect:self.view.frame];
 
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
#pragma mark textFieldDelegate
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
#pragma mark SaveData
- (IBAction)btnSaveTapped:(id)sender {
     [self.view endEditing:YES];
    if (!(txtFullName.text.length > 0)) {
        [objMyGlobals Displaymsg:self.view msg:@"FullName cannot be blank."];
        return;
    }
    else if(!(txtLastName.text.length > 0))    {
        [objMyGlobals Displaymsg:self.view msg:@"Locality cannot be blank."];
        //        txtPassword.text=@"";
        //        txtRetypePassword.text=@"";
        return;
    }
   else if (!(txtAddressView.text.length > 0)) {
        [objMyGlobals Displaymsg:self.view msg:@"Address cannot be blank."];
        return;
    }
    else if (!(txtCity.text.length > 0))  {
        [objMyGlobals Displaymsg:self.view msg:@"City cannot be blank."];
        return;
    }
    else if (!(txtState.text.length > 0))    {
        [objMyGlobals Displaymsg:self.view msg:@"txtState cannot be blank."];
        //        txtEmail.text=@"";
        return;
    }
  
    
    else if (!(txtPincode.text.length >0))    {
        [objMyGlobals Displaymsg:self.view msg:@"Pincode cannot be blank."];
        //        txtPassword.text=@"";
        //        txtRetypePassword.text=@"";
        return;
        
    }
    else if (!(txtMobileNumber.text.length>0))    {
        [objMyGlobals Displaymsg:self.view msg:@"Mobile number cannot be blank."];
        return;
    }
    else if (txtMobileNumber.text.length<10)    {
        [objMyGlobals Displaymsg:self.view msg:@"Please add valid Mobile number"];
        return;
    }
    //Call Method Appropiate user Requirements
    else if(_isEdit==true)    {
        [self EditAddress];
    }
    else    {
      [self addAddress];
    }
}
#pragma mark Add/Edit Address
-(void)addAddress
{
    objMyGlobals.user.EditFname=[self.txtFullName.text mutableCopy];
    objMyGlobals.user.EditLastname=[self.txtLastName.text mutableCopy];
    //  objMyGlobals.user.EditAddress=[self.txtAddressView.text mutableCopy];
    objMyGlobals.user.apikey=[@"ICXE1wOphgKgcyMoHr0hVHbbJ" mutableCopy];
    objMyGlobals.user.EditAddress=[[NSString stringWithFormat: @"%@",self.txtAddressView.text ]mutableCopy];
    objMyGlobals.user.EditCity=[self.txtCity.text mutableCopy];
    objMyGlobals.user.EditState=[self.txtState.text mutableCopy];
    objMyGlobals.user.EditPincode=[self.txtPincode.text mutableCopy];
    objMyGlobals.user.EditMobilnum=[self.txtMobileNumber.text mutableCopy];
  [objMyGlobals showLoaderIn:self.view];
    if([appDelegateTemp checkInternetConnection]==true)
    {
    [objMyGlobals.user AddAdreess:^(NSString *str, int status)
     {
         if(status==1)
         {
              [objMyGlobals hideLoader:self.view];
             // [appDelegateTemp.AddressData addObject:AddressDataDic];
             [self.navigationController popViewControllerAnimated:true];
         }
         else
         {
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
-(void)EditAddress
{
    objMyGlobals.user.EditFname=[self.txtFullName.text mutableCopy];
    objMyGlobals.user.EditLastname=[self.txtLastName.text mutableCopy];
    //  objMyGlobals.user.EditAddress=[self.txtAddressView.text mutableCopy];
    objMyGlobals.user.apikey=[@"ICXE1wOphgKgcyMoHr0hVHbbJ" mutableCopy];
    objMyGlobals.user.EditAddress=[[NSString stringWithFormat: @"%@",self.txtAddressView.text] mutableCopy];
    objMyGlobals.user.EditCity=[self.txtCity.text mutableCopy];
    objMyGlobals.user.EditState=[self.txtState.text mutableCopy];
    objMyGlobals.user.EditPincode=[self.txtPincode.text mutableCopy];
    objMyGlobals.user.EditMobilnum=[self.txtMobileNumber.text mutableCopy];
    objMyGlobals.user.EditAddressId=[AddressDataDic objectForKey:@"address_id"];
  [objMyGlobals showLoaderIn:self.view];
    if([appDelegateTemp checkInternetConnection]==true)
    {
    [objMyGlobals.user EditAdreess:^(NSString *str, int status)
     {
         if(status==1)
         {
             [objMyGlobals hideLoader:self.view];
             // [appDelegateTemp.AddressData addObject:AddressDataDic];
             [self.navigationController popViewControllerAnimated:true];
             
         }
         
         else
         {
             
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

- (IBAction)btnBackClicked:(id)sender {
    [self.navigationController popViewControllerAnimated:true];
}

@end
