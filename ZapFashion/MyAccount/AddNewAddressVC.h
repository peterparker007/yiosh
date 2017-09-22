//
//  AddNewAddressVC.h
//  ZapFashion
//
//  Created by dharmesh  on 6/6/17.
//  Copyright © 2017 bhumesh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "Globals.h"

@interface AddNewAddressVC : UIViewController<UITextFieldDelegate>
{
    AppDelegate *appDelegateTemp;
   Globals *objMyGlobals;
}

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UILabel *lblUserName;
@property (strong, nonatomic) IBOutlet UIImageView *imgProfileView;
@property (strong, nonatomic) IBOutlet UITextField *txtFullName;
@property (strong, nonatomic) IBOutlet UITextView *txtAddressView;
@property (strong, nonatomic) IBOutlet UITextField *txtLastName;
@property (strong, nonatomic) IBOutlet UIView *TopView;
@property (strong, nonatomic) IBOutlet UILabel *HeaderTitle;
@property (strong, nonatomic) IBOutlet UITextField *txtCity;
@property (strong, nonatomic) IBOutlet UITextField *txtState;
@property (strong, nonatomic) IBOutlet UITextField *txtPincode;
@property (strong, nonatomic) IBOutlet UITextField *txtMobileNumber;
@property (strong,nonatomic)  NSMutableDictionary *AddressDataDic;
@property (strong ,nonatomic)NSIndexPath *indexpath;
@property (nonatomic, assign) BOOL isEdit;
- (IBAction)btnSaveTapped:(id)sender;
+(NSArray*)findAllTextFieldsInView:(UIView*)view;
- (IBAction)btnBackClicked:(id)sender;
-(void)addAddress;
@property (strong, nonatomic) IBOutlet UIImageView *logo;
    - (UIImage *)imageFromString:(NSString *)string font:(UIFont *)font size:(CGSize)size;
@property (strong, nonatomic) IBOutlet UIView *scrlsubvw;
@end
