//
//  CheckouttblvwCell.h
//  ZapFashion
//
//  Created by bhumesh on 6/8/17.
//  Copyright © 2017 bhumesh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Globals.h"


@interface PaymentViewController : UIViewController<UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate>


@property BOOL storeCard;
@property (weak, nonatomic) IBOutlet UIView *viewForPicker;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@property (weak, nonatomic) IBOutlet UITextField *txtCardType;
@property (weak, nonatomic) IBOutlet UITextField *txtCardNumber;
@property (weak, nonatomic) IBOutlet UITextField *txtCVVNumber;
@property (weak, nonatomic) IBOutlet UITextField *txtExpiredMonth;
@property (weak, nonatomic) IBOutlet UITextField *txtExpiredYear;
@property (weak, nonatomic) IBOutlet UITextField *txtCardName;
@property (weak,nonatomic) IBOutlet UIButton *btnMonthPressed;
@property (weak,nonatomic) IBOutlet UIButton *btnYearPressed;
@property (weak, nonatomic) IBOutlet UIButton *btnCardSave;
@property (weak, nonatomic) IBOutlet UIImageView *imgCardType;
@property (strong, nonatomic) IBOutlet UIView *TopView;
@property (strong, nonatomic) IBOutlet UILabel *HeaderTitle;
- (IBAction)btnBackTapped:(id)sender;
- (IBAction)btnCardSave:(id)sender;
- (IBAction)btnCardTypePressed:(id)sender;
- (IBAction)btnDonePressed:(id)sender;
- (IBAction)btnMonthPressed:(id)sender;
- (IBAction)btnYearPressed:(id)sender;
- (IBAction)btnProceedPressed:(id)sender;
- (IBAction)btnCancelPressed:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *btnMakePayement;
@property (strong, nonatomic) IBOutlet UIButton *btnCancel;
-(void)fetchCardtype:(UIButton *)btnCardType;
-(void)fetchYear;
-(void)fetchMonth:(UIButton*)btnMonth;
-(void)cardType:(NSString *)card;
@property (strong, nonatomic) IBOutlet UIImageView *divider;
@property (strong, nonatomic) IBOutlet UIImageView *Logo;

@end
