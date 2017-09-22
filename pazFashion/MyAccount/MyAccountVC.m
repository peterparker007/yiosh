//
//  MyAccountVC.m
//  ZapFashion
//
//  Created by bhumesh on 6/6/17.
//  Copyright © 2017 bhumesh. All rights reserved.
//

#import "MyAccountVC.h"
#import "AddNewAddressVC.h"
#import "DEMOLeftMenuViewController.h"
#import "SideMenu.h"
#import "Globals.h"
@interface MyAccountVC ()
{
    NSMutableDictionary *Dict_Address;
    NSMutableDictionary *savedValue;
}
@end
@implementation MyAccountVC
@synthesize txtDay,txtEmail,txtMobile,txtFullName,txtAddressView,txtLastName;

- (void)viewDidLoad {
    [super viewDidLoad];
      appDelegateTemp = (AppDelegate *)[[UIApplication sharedApplication]delegate];
     objMyGlobals=[Globals sharedManager];
    //Getting User Data and Thier Addresses.
    [self GetUserData];
     [self GetAddress];
    NSArray *allImgTextFields = [[NSArray alloc]initWithObjects:@"ic_user",@"ic_user",@"_0003_ic_email",@"ic_contact",@"ic_calander", nil];
    NSArray* allTextFields = [MyAccountVC findAllTextFieldsInView:[self view]];
    [self MenuButttonTapped:_btnmenu];
    [self rightMenuTapped:_btnmenu2];
    for ( int i =0; i<allTextFields.count; i++) {
        [self setTextFieldWithImage:[UIImage imageNamed:allImgTextFields[i]] txtField:allTextFields[i]];
    }
    [self setDatePicker];
    [self.collectionVW reloadData];
}
-(void)viewWillAppear:(BOOL)animated
{
      [self.navigationController setNavigationBarHidden:YES];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"Data.plist"];
    savedValue = [[NSMutableDictionary alloc] initWithContentsOfFile: path];
     [_TopView setBackgroundColor: [self colorWithHexString:[savedValue valueForKey:@"header_color"]]];
    [_HeaderTitle setTextColor:[self colorWithHexString:[savedValue valueForKey:@"header_text_color"]]];
      [_scrlsubvw setBackgroundColor:[self colorWithHexString:[savedValue valueForKey:@"bg_color"]]];
    [self SetConfigForTopView];
    if([appDelegateTemp.strMenuType isEqualToString:@"tab"])
    {
        _btnmenu2.hidden=true;
        _btnmenu.hidden=true;
        
    }
    else if([appDelegateTemp.strMenuType isEqualToString:@"Right"])
    {
        _btnmenu2.hidden=false;
        _btnmenu.hidden=true;
    }    
}
-(void)SetConfigForTopView
{
    _TopView.frame=[objMyGlobals currentDevicePositions:CGRectMake(0, 0, 381, 50) vwRect:self.view.frame];
    _btnmenu.frame=[objMyGlobals currentDevicePositions:CGRectMake(0, 0, 33, 50) vwRect:self.view.frame];
    
   CGRect frame1=[objMyGlobals getXYPositions:[savedValue valueForKey:@"page_title_position"]];
    _HeaderTitle.frame=[objMyGlobals currentDevicePositions:CGRectMake(frame1.origin.x, frame1.origin.y, 130, 21) vwRect:self.view.frame];
    frame1=[objMyGlobals getXYPositions:[savedValue valueForKey:@"logo_position"]];
    _Logo.frame=[objMyGlobals currentDevicePositions:CGRectMake(frame1.origin.x, frame1.origin.y, 77, 18) vwRect:self.view.frame];
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
-(void)GetUserData
{
    objMyGlobals.user.apikey=[@"ICXE1wOphgKgcyMoHr0hVHbbJ" mutableCopy];
  [objMyGlobals showLoaderIn:self.view];
    if([appDelegateTemp checkInternetConnection]==true)
    {
    [objMyGlobals.user GetUserData:^(NSString *str, int status)
     {
         if(status==1){
              [objMyGlobals hideLoader:self.view];
            
             txtFullName.text=[NSString stringWithFormat:@"%@",[appDelegateTemp.localDataDic objectForKey:@"firstname"]];
             txtLastName.text=[NSString stringWithFormat:@"%@",[appDelegateTemp.localDataDic objectForKey:@"lastname"]];
             _lblUserName.text=[NSString stringWithFormat:@"%@ %@",[appDelegateTemp.localDataDic objectForKey:@"firstname"],[appDelegateTemp.localDataDic objectForKey:@"lastname"]];
             txtEmail.text=[NSString stringWithFormat:@"%@",[appDelegateTemp.localDataDic objectForKey:@"email"]];
             
             NSString *string1=[[appDelegateTemp.localDataDic objectForKey:@"firstname"] substringToIndex:1];
             NSString *string2=[[appDelegateTemp.localDataDic objectForKey:@"lastname"] substringToIndex:1];
             NSString *string = [string1 stringByAppendingString: string2];
             
             
             UIImage *img=[self imageFromString:string font:[UIFont systemFontOfSize:20] size:CGSizeMake(50, 50)];
             [_imgProfileView.layer setBorderColor: [[UIColor blackColor] CGColor]];
             [_imgProfileView.layer setBorderWidth: 2.0];
             _imgProfileView.layer.cornerRadius = _imgProfileView.frame.size.height/2;
             _imgProfileView.layer.masksToBounds = YES;
             _imgProfileView.image=img;
            
         }
         else{
             
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
- (UIImage *)imageFromString:(NSString *)string font:(UIFont *)font size:(CGSize)size
    {
        UIGraphicsBeginImageContextWithOptions(size, NO, 0);
        
     //   [string drawInRect:CGRectMake(size.width/2-11, size.height/2-11, 100, 100) withFont:font lineBreakMode: NSLineBreakByWordWrapping];
        
#ifdef __IPHONE_7_0
       
        [string drawInRect:CGRectMake(size.width/2-11, size.height/2-11, 100, 100) withAttributes: @{NSFontAttributeName: font}];
#else
        [string drawInRect:renderingRect withFont:font lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentCenter];
#endif
        
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        return image;
    }
    
-(void)GetAddress
{
    objMyGlobals.user.apikey=[@"ICXE1wOphgKgcyMoHr0hVHbbJ" mutableCopy];
    //objMyGlobals.user.CustID=_CustID;
    if(![objMyGlobals.spinner isDescendantOfView:self.view])
    {
        [objMyGlobals showLoaderIn:self.view];
    }
     if([appDelegateTemp checkInternetConnection]==true)
    {
    [objMyGlobals.user GetAddressData:^(NSString *str, int status)
     {
         if(status==1){
             [objMyGlobals hideLoader:self.view];
             [self.collectionVW reloadData];
             
         }
         else{
              [objMyGlobals hideLoader:self.view];
               [self.collectionVW reloadData];
            
            }
     }];
    }
    else
    {
          [objMyGlobals Displaymsg:self.view msg:@"Please check Your Internet Connection"];
         [objMyGlobals hideLoader:self.view];
    }

}
-(void)viewDidAppear:(BOOL)animated
{
    [self GetAddress];
    [self.collectionVW reloadData];
}
- (IBAction)MenuButttonTapped:(id)sender
{
    
    [sender addTarget:self action:@selector(presentLeftMenuViewController:) forControlEvents:UIControlEventTouchUpInside];
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
//Edit Details
- (IBAction)btnEditClicked:(id)sender {
   [txtFullName becomeFirstResponder];
    _btnEditImage.enabled=YES;
    _btnAddAnotherAddress.hidden = NO;
    _btnSave.hidden = NO;
    _btnFemailObj.enabled=YES;
    _btnMaleObj.enabled=YES;
    txtFullName.enabled = YES;
    txtLastName.enabled = YES;
    txtEmail.enabled = YES;
    txtMobile.enabled = YES;
    txtDay.enabled = YES;
    txtAddressView.editable = YES;
     [txtFullName becomeFirstResponder];
    
}
- (IBAction)GenderSelection:(id)sender {
    UIButton *btn=(UIButton*) sender;
    if(btn.tag==0)
    {
        [_btnFemailObj setImage:[UIImage imageNamed:@"radio_uncheck"] forState:UIControlStateNormal];
        [_btnMaleObj setImage:[UIImage imageNamed:@"radio_check"] forState:UIControlStateNormal];
    }
    else
    {
        [_btnMaleObj setImage:[UIImage imageNamed:@"radio_uncheck"] forState:UIControlStateNormal];
        [_btnFemailObj setImage:[UIImage imageNamed:@"radio_check"] forState:UIControlStateNormal];

    }
}
- (IBAction)btnAddAnotherAddressClicked:(id)sender {
    UIStoryboard *objStoryboard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    AddNewAddressVC *newView = (AddNewAddressVC *)[objStoryboard instantiateViewControllerWithIdentifier:@"AddNewAddressVC"];
    [self.navigationController pushViewController:newView animated:YES];
}

- (IBAction)btnSaveClicked:(id)sender {
//    Globals *objMyGlobals;
//    objMyGlobals=[Globals sharedManager];
    [self.view endEditing:YES];
    
    if (!(txtFullName.text.length > 0))
    {
        [objMyGlobals Displaymsg:self.view msg:@"First Name cannot be blank."];
        return;
    }
    else if (!(txtLastName.text.length > 0))
    {
        [objMyGlobals Displaymsg:self.view msg:@"Last Name cannot be blank."];
        return;
    }
    else if (!(txtEmail.text.length > 0))
    {
        [objMyGlobals Displaymsg:self.view msg:@"Email address cannot be blank."];
        return;
    }
    else if (![self isEmailValid:txtEmail])
    {
        [objMyGlobals Displaymsg:self.view msg:@"Email address is invalid"];
        //        txtEmail.text=@"";
        return;
    }
    else if([appDelegateTemp checkInternetConnection]==true)
    
    {
        objMyGlobals.user.firstName=[self.txtFullName.text mutableCopy];
        objMyGlobals.user.lastName=[self.txtLastName.text mutableCopy];
        objMyGlobals.user.email=[self.txtEmail.text mutableCopy];
       [objMyGlobals showLoaderIn:self.view];
        [objMyGlobals.user SaveAccountData:^(NSString *str, int status){
            if(status==1)
            {
                 [objMyGlobals hideLoader:self.view];
                 [self GetUserData];
                [objMyGlobals Displaymsg:self.view msg:str];
                
            }
            else
            {
                UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Updation Failed" message:str delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
                [alert show];
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
#pragma mark Set & Update Date Using Picker
-(void)setDatePicker
{
    UIDatePicker *datePicker = [[UIDatePicker alloc] init];
    datePicker.datePickerMode = UIDatePickerModeDate;
    [datePicker setMaximumDate:[NSDate date]];
    [datePicker addTarget:self action:@selector(updateTextField:) forControlEvents:UIControlEventValueChanged];
    txtDay.inputView = datePicker;
    UIToolbar *toolBar=[[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40)];
    [toolBar setTintColor:[UIColor grayColor]];
    UIBarButtonItem *doneBtn=[[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(ShowSelectedDate)];
    doneBtn.tintColor=[UIColor blackColor];
    UIBarButtonItem *space=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    [toolBar setItems:[NSArray arrayWithObjects:space,doneBtn, nil]];
    [txtDay setInputAccessoryView:toolBar];
}
-(void)updateTextField:(id)sender
{
    UIDatePicker *pickerDate = (UIDatePicker*)txtDay.inputView;
    // [picker setMaximumDate:[NSDate date]];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    NSDate *eventDate = pickerDate.date;
    [dateFormat setDateFormat:@"dd MMMM yyyy"];
    NSString *dateString = [dateFormat stringFromDate:eventDate];
    txtDay.text = [NSString stringWithFormat:@"%@",dateString];
}
-(void) ShowSelectedDate
{
    [self.view endEditing:true];
}
#pragma mark collectionviewForAddress
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return appDelegateTemp.AddressData.count;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat padding = 10;
    CGFloat cellSize = self.collectionVW.frame.size.width - padding;
    return CGSizeMake(cellSize  , (self.collectionVW.frame.size.height-padding));
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier1 = @"collectionVWCell";
    collectionVWCell *cell1 = [collectionView dequeueReusableCellWithReuseIdentifier:identifier1 forIndexPath:indexPath];
    [cell1.txtView scrollRangeToVisible:NSMakeRange(0, 0)];
    cell1.txtView.layoutManager.allowsNonContiguousLayout = NO;
    NSMutableDictionary *temp=[[NSMutableDictionary alloc]initWithDictionary:[appDelegateTemp.AddressData objectAtIndex:indexPath.row]];
    cell1.btnEdit.tag=indexPath.row;
    cell1.btnDelete.tag=indexPath.row+1000;
    cell1.txtView.text=[NSString stringWithFormat:@"%@\t%@,\n%@,\n%@,\n%@,\n%@,\n%@",[temp objectForKey:@"firstname"],[temp objectForKey:@"lastname"],[[temp objectForKey:@"street"] componentsJoinedByString:@"\n"],[temp objectForKey:@"city"],[temp objectForKey:@"region"],[temp objectForKey:@"postcode"],[temp objectForKey:@"mobile"]];
    NSString *string =  cell1.txtView.text;
    NSCharacterSet *trim = [NSCharacterSet characterSetWithCharactersInString:@"() "];
    NSString *result = [[string componentsSeparatedByCharactersInSet:trim] componentsJoinedByString:@""];
    cell1.txtView.text=result;
    
     [cell1.btnEdit addTarget:self action:@selector(EditAdress:) forControlEvents:UIControlEventTouchUpInside];
   [cell1.btnDelete addTarget:self action:@selector(DeleteAddress:) forControlEvents:UIControlEventTouchUpInside];
    return cell1;
}
#pragma mark -Address Delete and Changed Method
-(void)DeleteAddress:(id)sender
{
    UIButton *btn=sender;
    NSIndexPath* indexpath = [NSIndexPath indexPathForRow:btn.tag inSection:0];
    NSMutableDictionary *temp=[[NSMutableDictionary alloc]initWithDictionary:[appDelegateTemp.AddressData objectAtIndex:indexpath.row-1000]];
    objMyGlobals.user.apikey=[@"ICXE1wOphgKgcyMoHr0hVHbbJ" mutableCopy];
    objMyGlobals.user.EditAddressId=[temp objectForKey:@"address_id"];
  [objMyGlobals showLoaderIn:self.view];
    if([appDelegateTemp checkInternetConnection]==true)
    {
    [objMyGlobals.user DeleteAddressData:^(NSString *str, int status)
     {
         if(status==1){
             [self GetAddress];
            //[self.collectionVW reloadData];
             [objMyGlobals hideLoader:self.view];
         }
         else{
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
-(void)EditAdress:(id)sender
{
    UIButton *btn=sender;
    NSIndexPath* indexpath = [NSIndexPath indexPathForRow:btn.tag inSection:0];
    UIStoryboard *objStoryboard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    AddNewAddressVC *newView = (AddNewAddressVC *)[objStoryboard instantiateViewControllerWithIdentifier:@"AddNewAddressVC"];
    newView.indexpath=indexpath;
    newView.isEdit=true;
  //  newView.AddressDataDic=[appDelegateTemp.AddressData objectAtIndex:indexpath.row];
    [self.navigationController pushViewController:newView animated:YES];
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
}
#pragma mark -Image Selection Methods

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSString *title = [actionSheet buttonTitleAtIndex:buttonIndex];
    UIImagePickerController *controller = [[UIImagePickerController alloc] init];
    controller.delegate = self;
    controller.navigationBar.tintColor=[UIColor whiteColor];
    if ([@"Camera" isEqualToString:title] && [UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera])
    {
        if(IS_IPAD)
        {
            controller.sourceType = UIImagePickerControllerSourceTypeCamera;
            [self presentViewController:controller animated:YES completion:nil];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self presentViewController:controller animated:YES completion:nil];
            });
        }
        else
        {
            controller.sourceType = UIImagePickerControllerSourceTypeCamera;
            [self.navigationController presentViewController:controller animated:YES completion:nil];
        }
    }
    else if ([@"Photo Library" isEqualToString:title])
    {
        if(IS_IPAD)
        {
            controller.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            [self presentViewController:controller animated:YES completion:nil];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self presentViewController:controller animated:YES completion:nil];
            });
        }
        else
        {
            controller.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            [self.navigationController presentViewController:controller animated:YES completion:nil];
        }
        
    } else if ([@"Saved Album" isEqualToString:title])
    {
        if(IS_IPAD)
        {
            controller.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
            [self presentViewController:controller animated:YES completion:nil];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self presentViewController:controller animated:YES completion:nil];
            });
        }
        else
        {
            controller.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
            [self.navigationController presentViewController:controller animated:YES completion:nil];
        }
    }
}
-(void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSMutableDictionary *)info {
    UIImage *originalImage = [info objectForKey:UIImagePickerControllerOriginalImage];
#ifdef DEV_ENVIRONMENT
    DLog (@"Image Size, %f, %f", originalImage.size.width, originalImage.size.height
          );
#endif
      
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
        //[self openCropEditor:originalImage];
       
      _imgProfileView.image=  [self imageByCroppingImage:originalImage toSize:CGSizeMake(originalImage.size.width, originalImage.size.height)];
    }];
}

#pragma mark photo cropper
- (UIImage *)imageByCroppingImage:(UIImage *)image toSize:(CGSize)size
{
    // not equivalent to image.size (which depends on the imageOrientation)!
    double refWidth = CGImageGetWidth(image.CGImage);
    double refHeight = CGImageGetHeight(image.CGImage);
    
    double x = (refWidth - size.width) / 2.0;
    double y = (refHeight - size.height) / 2.0;
    
    CGRect cropRect = CGRectMake(x, y, size.height, size.width);
    CGImageRef imageRef = CGImageCreateWithImageInRect([image CGImage], cropRect);
    
    UIImage *cropped = [UIImage imageWithCGImage:imageRef scale:0.0 orientation:UIImageOrientationUp];
    CGImageRelease(imageRef);
    
    return cropped;
}
- (IBAction)btnImageChanged:(id)sender {
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Camera", @"Photo Library", @"Saved Album", nil];
    actionSheet.tag = 1;
    [actionSheet showInView:self.view];
}
- (IBAction)rightMenuTapped:(id)sender {
    [sender addTarget:self action:@selector(presentRightMenuViewController:) forControlEvents:UIControlEventTouchUpInside];
}
@end
