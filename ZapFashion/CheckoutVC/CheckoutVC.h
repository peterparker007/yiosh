//
//  CheckoutVC.h
//  ZapFashion
//
//  Created by bhumesh on 6/8/17.
//  Copyright © 2017 bhumesh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CheckouttblvwCell.h"
#import "DropDownListView.h"
#import "AppDelegate.h"
#import "Globals.h"
@interface CheckoutVC : UIViewController<UITableViewDelegate,UICollectionViewDataSource,UITextFieldDelegate>
{
    NSMutableArray *tableData;
   // NSMutableArray *arrCart;
   AppDelegate *appDelegateTemp;
       Globals *objMyGlobals;
    BOOL isApplyCoupon;
}
@property (strong, nonatomic) IBOutlet UILabel *FullTotal;
@property (strong, nonatomic) IBOutlet UILabel *subtotal;
@property (strong, nonatomic) IBOutlet UILabel *totalPrice;
@property (strong, nonatomic) IBOutlet UITableView *tblvw;
@property (strong, nonatomic) IBOutlet UILabel *lblItemCount;
@property (strong, nonatomic)  NSMutableDictionary *arrCart;
@property (strong, nonatomic) IBOutlet UILabel *lblDiscount;
@property (strong, nonatomic) IBOutlet UILabel *DiscountTitle;
@property (strong, nonatomic) IBOutlet UIButton *btnApplyCoupon;
@property (strong, nonatomic) IBOutlet UILabel *lblRemoveOffer;
@property (strong, nonatomic) IBOutlet UITextField *txtCouponCode;
@property (strong, nonatomic) IBOutlet UILabel *lblShipping;
@property (strong, nonatomic) IBOutlet UILabel *lblShipping1;
@property (strong, nonatomic) IBOutlet UIView *TopView;
@property (strong, nonatomic) IBOutlet UILabel *HeaderTitle;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
-(IBAction)addValue:(id)sender;
-(IBAction)minusValue:(id)sender;
-(IBAction)btnBackTapped:(id)sender;
-(void)GetCartData;
-(void)DeleteItemCart:(NSString*)productID;
-(void)UpdateCart:(NSString*)productID quenty:(NSString*)qty;
-(IBAction)ApplyCoupon:(id)sender;
- (IBAction)btnProccedToPay:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *btnProcced;
-(void)ApplyCouponData:(NSString*)flag;
@property (strong, nonatomic) IBOutlet UIView *scrlsubvw;
@property (strong, nonatomic) IBOutlet UIImageView *Logo;
@end
