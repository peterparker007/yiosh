//
//  Users.h
//  Bhumesh Purohit
//
//  Created by Bhumesh Purohit on 3/17/15.
//  Copyright (c) 2015 Bhumesh Purohit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Users : NSObject
@property int pin, accountid;
typedef void(^user_completion_block)(NSString *, int status);
typedef void(^user_completion_block_data)(NSString *, int status,NSDictionary *dict);
//SignUpVC
@property NSMutableString *email,*firstName,*lastName,*password,*currentPassword,*strUserId,*strZipCity,*strToken;
//LoginVC
@property NSMutableString *UserName, *passwordLogin;
@property NSData *sImage;
//EditProfileVC
@property NSMutableString *EditFname, *EditLastname, *EditAddress,*EditCity,*EditLocality,*EditState,*EditPincode,*EditMobilnum, *EditNumber,*EditAddressId;
//other Strings
@property NSMutableString *mobileNum,*apikey,*CatID,*qty,*prod_id,*userid,*pageno,*CouponCode,*flag,*type,*searchKey,*template_no,*CardNum,*CVVNum,*expMonth,*expYear,*cardType;
@property BOOL IsEdit,IsNewItemAdd,IsAppliedCoupon;
@property NSString *toast;
@property NSMutableString *Menu_id;
@property NSMutableDictionary *DataForJason;
@property NSMutableArray *ArrJasonData;
-(void)registerUser:(user_completion_block)completion;
-(void)Setconfiguration:(user_completion_block)completion;
-(void)loginUser:(user_completion_block)completion;
-(void)GetProductData:(user_completion_block)completion;
-(void)allCategory:(user_completion_block)completion;
-(void)addWishList:(user_completion_block)completion;
-(void)getWishList:(user_completion_block)completion;
-(void)AddAdreess:(user_completion_block)completion;
-(void)EditAdreess:(user_completion_block)completion;
-(void)GetAddressData:(user_completion_block)completion;
-(void)GetUserData:(user_completion_block)completion;
-(void)DeleteAddressData:(user_completion_block)completion;
-(void)ForgotPassword:(user_completion_block)completion;
-(void)AddToCart:(user_completion_block)completion;
-(void)DisplayCart:(user_completion_block)completion;
-(void)SaveAccountData:(user_completion_block)completion;
-(void)RemoveFromWishList:(user_completion_block)completion;
-(void)clearWishList:(user_completion_block)completion;
-(void)UpdateCart:(user_completion_block)completion;
-(void)DeleteItemCart:(user_completion_block)completion;
-(void)ApplyCoupon:(user_completion_block)completion;
-(void)GetAdvanceProduct:(user_completion_block)completion;
-(void)GetAdvanceProductForPagination:(user_completion_block)completion;
-(void)SearchData:(user_completion_block)completion;
-(void)GetOrderHistory:(user_completion_block)completion;
-(void)checkoutPlaceOrder:(user_completion_block)completion;
-(void)GetProductDetails:(user_completion_block)completion;
-(void)ChangePassword:(user_completion_block)completion;
-(void)GetSettingPages:(user_completion_block)completion;
-(void)GetMobileBanner:(user_completion_block)completion;
-(void)GetNotificationHistory:(user_completion_block)completion;
-(void)GetMenuData:(user_completion_block)completion;
@end
