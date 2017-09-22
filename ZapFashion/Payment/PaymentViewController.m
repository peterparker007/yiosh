//
//  CheckouttblvwCell.h
//  ZapFashion
//
//  Created by bhumesh on 6/8/17.
//  Copyright © 2017 bhumesh. All rights reserved.
//
//

#import "PaymentViewController.h"
//#import "UIViewController+NavigationBar.h"
#import "Constant.h"
#import "AESCrypt.h"
#import "AppDelegate.h"

@interface PaymentViewController ()<UITextFieldDelegate>
{
    Globals *OBJGlobal;
    UIButton *btnBadgeCount;
    NSMutableArray *years;
    NSArray *arrMonths, *arrCardType;
    UIButton *btnTag;
    NSString *strEncryptedData, *strCardType;
    BOOL isFlagCVV;
     AppDelegate *appDelegateTemp;
    NSMutableDictionary *savedValue;
}
@end

@implementation PaymentViewController

@synthesize txtCardType,txtCardNumber,txtCVVNumber,txtExpiredMonth,txtExpiredYear,txtCardName,btnMonthPressed,btnYearPressed,pickerView,viewForPicker,storeCard,imgCardType;

- (void)viewDidLoad {
    @try{
        [super viewDidLoad];
        
        OBJGlobal = [Globals sharedManager];
//        OBJGlobal.isCardlistNill=TRUE;
//        [OBJGlobal setTextFieldWithSpace:self.txtCardNumber];
//        [OBJGlobal setTextFieldWithSpace:self.txtCardType];
//        [OBJGlobal setTextFieldWithSpace:self.txtCVVNumber];
//        [OBJGlobal setTextFieldWithSpace:self.txtExpiredMonth];
//        [OBJGlobal setTextFieldWithSpace:self.txtExpiredYear];
//        [OBJGlobal setTextFieldWithSpace:self.txtCardName];
        _btnCardSave.hidden=true;
        [self btncardShow];
        self.txtCardType.delegate=self;
        self.txtCardNumber.delegate=self;
        self.txtCVVNumber.delegate=self;
        self.txtExpiredMonth.delegate=self;
        self.txtExpiredYear.delegate=self;
        self.txtCardName.delegate=self;
        
        [self.btnMonthPressed setTag:100];
//        [self setUpImageBackButton:@"left-arrow"];
//         [self setUpImageProfileEditButton:@"home"];
        
        strEncryptedData = [[NSString alloc]init];
        strCardType = [[NSString alloc]init];
        viewForPicker.hidden=YES;
        storeCard =false;
        
    } @catch (NSException *exception) {
        NSLog(@"Exception At: %s %d %s %s %@", __FILE__, __LINE__, __PRETTY_FUNCTION__, __FUNCTION__,exception);
    }
    
}
-(void)viewWillAppear:(BOOL)animated
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"Data.plist"];
    savedValue = [[NSMutableDictionary alloc] initWithContentsOfFile: path];
      [_TopView setBackgroundColor: [self colorWithHexString:[savedValue valueForKey:@"header_color"]]];
    [_HeaderTitle setTextColor:[self colorWithHexString:[savedValue valueForKey:@"header_text_color"]]];
    [_btnCancel setBackgroundColor: [self colorWithHexString:[savedValue valueForKey:@"signup_btn_col"]]];
    [_btnMakePayement setBackgroundColor: [self colorWithHexString:[savedValue valueForKey:@"login_btn_col"]]];
      [self.view setBackgroundColor:[self colorWithHexString:[savedValue valueForKey:@"bg_color"]]];
    [self SetConfigForTopView];

}
-(void)SetConfigForTopView
{   
    CGRect frame1=[OBJGlobal getXYPositions:[savedValue valueForKey:@"page_title_position"]];
    _HeaderTitle.frame=[OBJGlobal currentDevicePositions:CGRectMake(frame1.origin.x, frame1.origin.y, 116, 21) vwRect:self.view.frame];
    frame1=[OBJGlobal getXYPositions:[savedValue valueForKey:@"logo_position"]];
    _Logo.frame=[OBJGlobal currentDevicePositions:CGRectMake(frame1.origin.x, frame1.origin.y, 77, 18) vwRect:self.view.frame];
 
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
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
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
-(void)fetchMonth:(UIButton *)btnMonth
{
    @try {
        btnTag = btnMonth;
        arrMonths = [NSArray arrayWithObjects:@"01",@"02",@"03",@"04",@"05",@"06",@"07",@"08",@"09",@"10",@"11",@"12",nil];
        pickerView.delegate=self;
        pickerView.dataSource=self;
        
    } @catch (NSException *exception) {
        NSLog(@"Exception At: %s %d %s %s %@", __FILE__, __LINE__, __PRETTY_FUNCTION__, __FUNCTION__,exception);
    }
    
}

-(void)fetchYear
{
    @try {
        NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"YYYY"];
        int currentYear  = [[formatter stringFromDate:[NSDate date]] intValue];        
        int nextYears = currentYear+20;
              years = [[NSMutableArray alloc] init];
        for (int i=currentYear; i<=nextYears; i++) {
            [years addObject:[NSString stringWithFormat:@"%d",i]];
        }
        pickerView.delegate=self;
        pickerView.dataSource=self;
    } @catch (NSException *exception) {
        NSLog(@"Exception At: %s %d %s %s %@", __FILE__, __LINE__, __PRETTY_FUNCTION__, __FUNCTION__,exception);
    }
}

#pragma Mark - PickerView Delegate Method
- (NSInteger)numberOfComponentsInPickerView: (UIPickerView*)thePickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)thePickerView numberOfRowsInComponent:(NSInteger)component
{
    @try {
        if (btnTag.tag==1000) {
            return [arrMonths count];
        }
        else if (btnTag.tag==2000)
        {
            return [arrCardType count];
        }
        else{
            return [years count];
        }
        
    } @catch (NSException *exception) {
        NSLog(@"Exception At: %s %d %s %s %@", __FILE__, __LINE__, __PRETTY_FUNCTION__, __FUNCTION__,exception);
    }
    
}
- (NSString *)pickerView:(UIPickerView *)thePickerView
             titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    @try {
        if (btnTag.tag == 1000) {
            return [arrMonths objectAtIndex:row];
        }
        else if (btnTag.tag == 2000) {
            return [arrCardType objectAtIndex:row];
        }
        else{
            
            return [years objectAtIndex:row];
        }
        
    } @catch (NSException *exception) {
        NSLog(@"Exception At: %s %d %s %s %@", __FILE__, __LINE__, __PRETTY_FUNCTION__, __FUNCTION__,exception);
    }
    
}

#pragma Mark -textField Delegate Method
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    @try{
        if (textField.tag==1 ||textField.tag==2 || textField.tag==3 ||  textField.tag==4) {
            if([string isEqualToString:@" "])
            {
               
                return NO;
            }
        }
        if(textField.text.length==3 && self.txtCardNumber==textField ){
            static int currentLength = 0;
            if ((currentLength += [string length]) == 1) {
                currentLength = 0;
                [textField setText:[NSString stringWithFormat:@"%@%@%c", [textField text], string, '-']];
                return NO;
            }
            
        }
        else if ( textField.text.length==8 &&  self.txtCardNumber==textField )
        {
            static int currentLength = 0;
            if ((currentLength += [string length]) == 1) {
                currentLength = 0;
                [textField setText:[NSString stringWithFormat:@"%@%@%c", [textField text], string, '-']];
                return NO;
            }
            
            
        }
        else if ( textField.text.length==13 &&  self.txtCardNumber==textField )
        {
            static int currentLength = 0;
            if ((currentLength += [string length]) == 1) {
                currentLength = 0;
                [textField setText:[NSString stringWithFormat:@"%@%@%c", [textField text], string, '-']];
                return NO;
            }
            
            
        }
        
        if (isFlagCVV == false) {
            if (self.txtCVVNumber.text.length == 3) {
                isFlagCVV = TRUE;
//                [[IQKeyboardManager sharedManager] setShouldResignOnTouchOutside:YES];
//                [[IQKeyboardManager sharedManager]resignFirstResponder];
            }
        }

        if(range.length + range.location == textField.text.length && ( self.txtCardNumber==textField ))
        {
            NSUInteger newLength = [textField.text length] + [string length] - range.length;
            return newLength < 20;
            
        }
        
        if(range.length + range.location == textField.text.length && ( self.txtCVVNumber==textField ))
        {
            NSUInteger newLength = [textField.text length] + [string length] - range.length;
            return newLength <= 4;
            
        }
        
        
        return YES;
        
    } @catch (NSException *exception) {
        NSLog(@"Exception At: %s %d %s %s %@", __FILE__, __LINE__, __PRETTY_FUNCTION__, __FUNCTION__,exception);
    }
}



- (IBAction)btnDonePressed:(id)sender {
    
    @try {
        if (btnTag.tag==1000) {
            txtExpiredMonth.text=[arrMonths objectAtIndex:[pickerView selectedRowInComponent:0]];
            btnTag = 0;
        }
        else{
            txtExpiredYear.text=[years objectAtIndex:[pickerView selectedRowInComponent:0]];
        }
        viewForPicker.hidden=YES;
        
    } @catch (NSException *exception) {
        NSLog(@"Exception At: %s %d %s %s %@", __FILE__, __LINE__, __PRETTY_FUNCTION__, __FUNCTION__,exception);
    }
    
    
    
}

- (IBAction)btnMonthPressed:(id)sender {
    [self.view endEditing:true];
    @try {
        
        viewForPicker.hidden=NO;
        [self fetchMonth:sender];
        
    } @catch (NSException *exception) {
        NSLog(@"Exception At: %s %d %s %s %@", __FILE__, __LINE__, __PRETTY_FUNCTION__, __FUNCTION__,exception);
    }
    
    
}

- (IBAction)btnYearPressed:(id)sender {
        [self.view endEditing:true];
    @try{
        viewForPicker.hidden=NO;
        [ self fetchYear];
    } @catch (NSException *exception) {
        NSLog(@"Exception At: %s %d %s %s %@", __FILE__, __LINE__, __PRETTY_FUNCTION__, __FUNCTION__,exception);
    }
    
}

- (IBAction)btnBackTapped:(id)sender {
        [self.view endEditing:true];
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)btnCardSave:(id)sender {
    
    @try {
        
        _btnCardSave.selected = !_btnCardSave.selected;
        storeCard = true;
    } @catch (NSException *exception) {
        NSLog(@"Exception At: %s %d %s %s %@", __FILE__, __LINE__, __PRETTY_FUNCTION__, __FUNCTION__,exception);
    }
    
}

- (IBAction)btnCardTypePressed:(id)sender {
    
    @try {
        
        viewForPicker.hidden=NO;
        [self fetchCardtype:sender];
        
    } @catch (NSException *exception) {
        NSLog(@"Exception At: %s %d %s %s %@", __FILE__, __LINE__, __PRETTY_FUNCTION__, __FUNCTION__,exception);
    }
}

-(void)fetchCardtype:(UIButton *)btnCardType
{
    
}
- (IBAction)btnProceedPressed:(id)sender
{
    
    Globals *objMyGlobals;
    objMyGlobals=[Globals sharedManager];
    appDelegateTemp = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    @try{
        [self.view endEditing:TRUE];
      
        if (self.txtCardNumber.text.length <19) {
                [objMyGlobals hideLoader:self.view];
            [objMyGlobals Displaymsg:self.view msg:@"Please Enter Valid Card Number."];
            return;
        }
        else if(self.txtCVVNumber.text.length <3)
        {     [objMyGlobals hideLoader:self.view];
            [objMyGlobals Displaymsg:self.view msg:@"Please Enter Valid CVV Number."];
            return;
        }
        
        
        else if(self.txtExpiredMonth.text.length==0)
        {
                [objMyGlobals hideLoader:self.view];
            [objMyGlobals Displaymsg:self.view msg:@"Please select expire month."];
            return;
            
        }
        else if(self.txtExpiredYear.text.length == 0)
        {     [objMyGlobals hideLoader:self.view];
            [objMyGlobals Displaymsg:self.view msg:@"Please select expire year."];
            return;
        }
        else if(self.txtCardName.text.length == 0)
        {     [objMyGlobals hideLoader:self.view];
            [objMyGlobals Displaymsg:self.view msg:@"Please enter Card Holder Name."];
            return;
        }
        else{
            if([appDelegateTemp checkInternetConnection]==true)
            {
                
                NSString *strTemp = [[NSUserDefaults standardUserDefaults] objectForKey:@"username"];
                NSRange range = [strTemp rangeOfString:@"@"];
                
                NSString *key = [strTemp substringWithRange:NSMakeRange(0, range.location)];
                
                NSLog(@"%@",key);
                NSCharacterSet *trim = [NSCharacterSet characterSetWithCharactersInString:@"-"];
                NSString *result = [[txtCardNumber.text componentsSeparatedByCharactersInSet:trim] componentsJoinedByString:@""];
                
                NSString *strCardNumber = [NSString stringWithFormat:@"%@",result];
                
                strEncryptedData = [AESCrypt encrypt:strCardNumber password:key];
                NSString *stringWithoutSpaces = [strEncryptedData
                                                 stringByReplacingOccurrencesOfString:@"+" withString:@"%"];
                NSLog(@"HaxString:%@",stringWithoutSpaces);
                
                stringWithoutSpaces=strEncryptedData;
                NSString *strDecrypedData = [AESCrypt decrypt:stringWithoutSpaces password:key];
                NSLog(@"Decrypted: %@", strDecrypedData);
                
                
                objMyGlobals.user.CardNum=[strEncryptedData mutableCopy];
                objMyGlobals.user.CVVNum=[txtCVVNumber.text mutableCopy];
                objMyGlobals.user.expMonth=[txtExpiredMonth.text mutableCopy];
                objMyGlobals.user.expYear=[txtExpiredYear.text mutableCopy];
                objMyGlobals.user.cardType=[strCardType mutableCopy];
                
                
                
            
                [objMyGlobals.user checkoutPlaceOrder:^(NSString *str, int status)
                 {
                     
                     if(status==1)
                     {
                                  [objMyGlobals Displaymsg:self.view msg:str];
                         [objMyGlobals hideLoader:self.view];
                         appDelegateTemp.CartData=nil;
                         appDelegateTemp.TotalCartItem=@"0".mutableCopy;
                       
                         [self performSelector:@selector(Navigate) withObject:self afterDelay:1.5];
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
        
    } @catch (NSException *exception) {
        NSLog(@"Exception At: %s %d %s %s %@", __FILE__, __LINE__, __PRETTY_FUNCTION__, __FUNCTION__,exception);
    }
    
   /* @try{
        [self.view endEditing:TRUE];
        BOOL isValid=true;
        if (![Validations checkMinLength:self.txtCardNumber.text withLimit:16 ]) {
            isValid=false;
            [OBJGlobal makeTextFieldBorderRed:self.txtCardNumber];
            [objMyGlobals Displaymsg:self.view msg:ERROR_CARDNUMBER];
            return;
        }
        else if(self.txtCVVNumber.text.length == 3 || self.txtCVVNumber.text.length == 4)
        {
            isValid=true;
            
        }
        
        
        else if([Validations isEmpty:self.txtExpiredMonth.text])
        {
            isValid=false;
            [OBJGlobal makeTextFieldBorderRed:self.txtExpiredMonth];
            [objMyGlobals Displaymsg:self.view msg:ERROR_MONTHEXPIRED];
            return;
            
        }
        else if([Validations isEmpty:self.txtExpiredYear.text])
        {
            isValid=false;
            [OBJGlobal makeTextFieldBorderRed:self.txtExpiredYear];
            return;
            [objMyGlobals Displaymsg:self.view msg:ERROR_YEAREXPIRED];
        }
        else if([Validations isEmpty:self.txtCardName.text])
        {
            isValid=false;
            [OBJGlobal makeTextFieldBorderRed:self.txtCardName];
            [objMyGlobals Displaymsg:self.view msg:ERROR_CARDNAME];
            return;
        }
        else{
            isValid=false;
            [OBJGlobal makeTextFieldBorderRed:self.txtCVVNumber];
            [objMyGlobals Displaymsg:self.view msg:ERROR_CCVNUMBER];
            [self.view resignFirstResponder];
            return;
        }
        
        if (isValid==true) {
            NSString *strTemp = GETOBJECT(@"EmailID");
            NSRange range = [strTemp rangeOfString:@"@"];
            
            NSString *key = [strTemp substringWithRange:NSMakeRange(0, range.location)];
            
            NSLog(@"%@",key);
            NSCharacterSet *trim = [NSCharacterSet characterSetWithCharactersInString:@"-"];
            NSString *result = [[txtCardNumber.text componentsSeparatedByCharactersInSet:trim] componentsJoinedByString:@""];
            
            NSString *strCardNumber = [NSString stringWithFormat:@"%@",result];
            
            strEncryptedData = [AESCrypt encrypt:strCardNumber password:key];
            NSString *stringWithoutSpaces = [strEncryptedData
                                             stringByReplacingOccurrencesOfString:@"+" withString:@"%"];
            NSLog(@"HaxString:%@",stringWithoutSpaces);
            
            
            NSString *strDecrypedData = [AESCrypt decrypt:stringWithoutSpaces password:key];
            NSLog(@"Decrypted: %@", strDecrypedData);
            
            
            MyKartViewController *objMyKartViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"MyKartViewController"];
            [self.navigationController pushViewController:objMyKartViewController animated:NO];
            
            
            objMyKartViewController.strCvvPayment=[[NSString stringWithFormat:@"%@",txtCVVNumber.text] mutableCopy];
            
            objMyKartViewController.strcardType=[[NSString stringWithFormat:@"%@",strCardType] mutableCopy];
            
            objMyKartViewController.strcardNumber=[[NSString stringWithFormat:@"%@",stringWithoutSpaces] mutableCopy];
            
            
            NSArray *arrTemp = [[NSArray alloc]init];
            arrTemp = [txtExpiredMonth.text componentsSeparatedByString:@"-"];
            NSString *strTempMonth = [NSString stringWithFormat:@"%@",[arrTemp objectAtIndex:0]];
            
            objMyKartViewController.strexpiryMonth=[[NSString stringWithFormat:@"%@",strTempMonth] mutableCopy];
            
            objMyKartViewController.strexpiryYear= [[NSString stringWithFormat:@"%@",txtExpiredYear.text] mutableCopy];
            
            objMyKartViewController.strstoreCard=storeCard;
            
            objMyKartViewController.strcardOwnerName=[[NSString stringWithFormat:@"%@",txtCardName.text] mutableCopy];
                       
            OBJGlobal.isOrderSummaryPayment=true;
           
            
        }
              
    } @catch (NSException *exception) {
        NSLog(@"Exception At: %s %d %s %s %@", __FILE__, __LINE__, __PRETTY_FUNCTION__, __FUNCTION__,exception);
    }*/
}
-(void)Navigate
{
    [self dismissViewControllerAnimated:NO completion:nil];
     [self.navigationController popToRootViewControllerAnimated:YES];
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField        // return NO to disallow editing.
{
  /*  @try{
        
        if(textField==self.txtCardType)
        {
            [OBJGlobal makeTextFieldNormal:self.txtCardType];
        }
        else if (textField==self.txtCardNumber)
        {
            [OBJGlobal makeTextFieldNormal:self.txtCardType];
            
        }
        else if (textField==self.txtCVVNumber)
        {
            [OBJGlobal makeTextFieldNormal:self.txtCardNumber];
        }
        else if (textField==self.txtCardName)
        {
            [OBJGlobal makeTextFieldNormal:self.txtCVVNumber];
        }
        else if (textField==self.txtExpiredMonth)
        {
            [OBJGlobal makeTextFieldNormal:self.txtCardName];
        }
        else if (textField==self.txtExpiredYear)
        {
            [OBJGlobal makeTextFieldNormal:self.txtExpiredMonth];
        }
        if (textField==self.txtExpiredYear)
        {
            [OBJGlobal makeTextFieldNormal:self.txtExpiredYear];
        }
        
        
        return YES;
        
    } @catch (NSException *exception) {
        NSLog(@"Exception At: %s %d %s %s %@", __FILE__, __LINE__, __PRETTY_FUNCTION__, __FUNCTION__,exception);
    }*/
    return YES;
}

- (IBAction)btnCancelPressed:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
//    for (UIViewController *controller in self.navigationController.viewControllers) {
//        
//        if ([controller isKindOfClass:[MyKartViewController class]]) {
//            [self.navigationController popToViewController:controller animated:NO];
//            break;
//        }
//    }
}

-(void)btncardShow{
   /* @try{

        [APPDATA showLoader];

        Users *objcard = OBJGlobal.user;

        [objcard checkSaveCard:^(NSDictionary *user, NSString *str, int status) {


            if (status == 1) {
                
                _btnCardSave.hidden=false;
                NSLog(@"success");
                [APPDATA hideLoader];
              
                }
            else {
                _btnCardSave.hidden=true;
               
                NSLog(@"Failed");
                [APPDATA hideLoader];
            }
        }];

    } @catch (NSException *exception) {
        NSLog(@"Exception At: %s %d %s %s %@", __FILE__, __LINE__, __PRETTY_FUNCTION__, __FUNCTION__,exception);
    }*/

}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    @try{
        
        if(txtCardNumber.text.length!=0)
            [self cardType:txtCardNumber.text];
        
    } @catch (NSException *exception) {
        NSLog(@"Exception At: %s %d %s %s %@", __FILE__, __LINE__, __PRETTY_FUNCTION__, __FUNCTION__,exception);
    }
    
    
    
}
-(void)cardType:(NSString *)card{
    @try{
        
        NSString *firstLetter = [card substringToIndex:1];
        NSString *tempSecondLetter =[card substringFromIndex:1];
        NSString *secondLetter =[tempSecondLetter substringToIndex:1];
        NSUInteger strDiscover = [[card substringToIndex:8]integerValue ];
        NSString *cardNumber = card;
        
        if ([cardNumber length]-3==13|| [cardNumber length]-3==16){
            if ([firstLetter isEqualToString:@"4"])
            {
                imgCardType.image = [UIImage imageNamed:@"Visa"];
                strCardType = @"VI";
                
            }
        }
        
        if ([cardNumber length]-3==16) {
            if ([firstLetter isEqualToString:@"5"]) {
                if ([secondLetter isEqual:@"1"] ||[secondLetter isEqual:@"2"] || [secondLetter isEqual:@"3"] || [secondLetter isEqual:@"4"] || [secondLetter isEqual:@"5"]) {
                    
                    imgCardType.image = [UIImage imageNamed:@"MasterCard"];
                    strCardType = @"MC";
                }
            }
            
        }
        if ([cardNumber length]-3==15) {
            if ([firstLetter isEqualToString:@"3"]) {
                if ([secondLetter isEqual:@"4"] ||[secondLetter isEqual:@"7"]) {
                    
                    imgCardType.image = [UIImage imageNamed:@"AmericanExpress"];
                    strCardType = @"AE";
                }
            }
        }
        
        if ([firstLetter isEqualToString:@"6"]){
            if ((strDiscover >= 6011-0000 || strDiscover <=6011-9999) || (strDiscover >= 6500-0000 || strDiscover <= 6599-9999) || (strDiscover >=6221-2600 || strDiscover <= 6229-2599)) {
                if([cardNumber length]-3==16)
                {
                    imgCardType.image = [UIImage imageNamed:@"Discover"];
                    strCardType = @"DI";
                }
            }
        }
    } @catch (NSException *exception) {
        NSLog(@"Exception At: %s %d %s %s %@", __FILE__, __LINE__, __PRETTY_FUNCTION__, __FUNCTION__,exception);
    }
    
}

@end
