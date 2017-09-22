//
//  MyAccountVC.h
//  ZapFashion
//
//  Created by bhumesh on 6/6/17.
//  Copyright © 2017 bhumesh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "collectionVWCell.h"
#import "AppDelegate.h"
#import "Globals.h"
@interface MyAccountVC : UIViewController<UITextFieldDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
{
    AppDelegate *appDelegateTemp;
     Globals *objMyGlobals;
}
@property (strong, nonatomic) IBOutlet UIButton *btnEditImage;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIImageView *imgProfileView;
@property (strong, nonatomic) IBOutlet UITextField *txtLastName;
@property (strong, nonatomic) IBOutlet UILabel *lblUserName;
@property (strong, nonatomic) IBOutlet UITextField *txtFullName;
@property (strong, nonatomic) IBOutlet UITextField *txtEmail;
@property (strong, nonatomic) IBOutlet UITextField *txtMobile;
@property (strong, nonatomic) IBOutlet UIButton *btnMaleObj;
@property (strong, nonatomic) IBOutlet UIButton *btnFemailObj;
@property (strong, nonatomic) IBOutlet UITextField *txtDay;
@property (strong, nonatomic) IBOutlet UIButton *btnmenu2;
@property (strong, nonatomic) IBOutlet UITextView *txtAddressView;
@property (strong, nonatomic) IBOutlet UIButton *btnAddAnotherAddress;
@property (strong, nonatomic) IBOutlet UIButton *btnSave;
@property (strong, nonatomic) IBOutlet UIButton *btnmenu;
@property (strong, nonatomic) IBOutlet UICollectionView *collectionVW;
@property (strong, nonatomic) IBOutlet UIView *TopView;
@property (strong, nonatomic) IBOutlet UILabel *HeaderTitle;
- (IBAction)btnEditClicked:(id)sender;
- (IBAction)GenderSelection:(id)sender;
- (IBAction)btnAddAnotherAddressClicked:(id)sender;
- (IBAction)btnSaveClicked:(id)sender;
//- (IBAction)btnMenuTapped:(id)sender;
-(void)setDatePicker;
+(NSArray*)findAllTextFieldsInView:(UIView*)view;
- (IBAction)MenuButttonTapped:(id)sender;
- (IBAction)btnImageChanged:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *scrlsubvw;
@property (strong, nonatomic) IBOutlet UIImageView *Logo;


@end
