#import <UIKit/UIKit.h>

#define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )

#define DEVICE_FRAME [[ UIScreen mainScreen ] bounds ]
#define OS_VER [[[UIDevice currentDevice] systemVersion] floatValue]
#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ? YES : NO)
#define IS_OS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_RETINA ([[UIScreen mainScreen] scale] >= 2.0)

#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define SCREEN_MAX_LENGTH (MAX(SCREEN_WIDTH, SCREEN_HEIGHT))
#define SCREEN_MIN_LENGTH (MIN(SCREEN_WIDTH, SCREEN_HEIGHT))

#define IS_IPHONE_4_OR_LESS (IS_IPHONE && SCREEN_MAX_LENGTH < 568.0)
#define IS_IPHONE_6 (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)
#define IS_IPHONE_6P (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)
#ifndef Constant_h
#define Constant_h

#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ? YES : NO)

#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_RETINA ([[UIScreen mainScreen] scale] >= 2.0)
#endif /* Constant_h */



#define BASE_URL        @"http://192.168.15.198/magento_sample/web2/"
#define api_key1         @"ICXE1wOphgKgcyMoHr0hVHbbJ"
#define URL_mobileSettings @"http://192.168.15.198/zaptech/web2/mobileSettings.php"
#define URL_mobileCmsPages @"http://192.168.15.198/zaptech/web2/mobileChildMenu.php"
#define URL_mobileMenu @"http://192.168.15.198/zaptech/web2/mobileMenu.php"
#define URL_SignUP           BASE_URL@"customerRegistration.php"
#define URL_Login            BASE_URL@"customerLogin.php"
#define URL_ForgotPassword     BASE_URL@"forgetPassword.php"
#define URL_Allcategory    BASE_URL@"allcategory.php"
#define URL_GetProducts    BASE_URL@"categoryAssignedProdList.php"
#define URL_AddWishList    BASE_URL@"wishlist.php"
#define URL_GetWishList    BASE_URL@"customerWishlist.php"
#define URL_addAddress     BASE_URL@"customerAddressCreate.php"
#define URL_GetAddress     BASE_URL@"customerAddressList.php"
#define URL_EditAddress     BASE_URL@"customerAddressUpdate.php"
#define URL_DeleteAddress     BASE_URL@"customerAddressDelete.php"
#define URL_AddCart     BASE_URL@"cartActions.php"
#define URL_DisplayCart     BASE_URL@"customercart.php"
#define URL_UpdateUserInfo    BASE_URL@"customerInfoUpdate.php"
#define URL_GetUserInfo    BASE_URL@"customerInfo.php"
#define URL_ApplyCoupon    BASE_URL@"couponActions.php"
#define URL_AdvanceProduct   BASE_URL@"advanceProducts.php"
#define URL_SearchProduct    BASE_URL@"searchprod.php"
#define URL_OrderHistory    BASE_URL@"customerOrderHistoryList.php"
#define URL_checkoutPlaceOrder    BASE_URL@"checkoutPlaceOrder.php"
#define URL_ProductDetails   BASE_URL@"productDetails.php"
#define URL_ChangePassword     BASE_URL@"changePassword.php"
#define URL_mobileBanners       BASE_URL@"mobileBanners.php"
#define URL_NotiFication         BASE_URL@"allNotifications.php"

/*#define kUserid @"image-id"

#define RGB(r,g,b)    [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define BG_COLOR        RGB(33,60,136)

#define RECT(x,y,w,h)  CGRectMake(x, y, w, h)
#define POINT(x,y)     CGPointMake(x, y)
#define SIZE(w,h)      CGSizeMake(w, h)
#define RANGE(loc,len) NSMakeRange(loc, len)

#define UDSetObject(value, key) [[NSUserDefaults standardUserDefaults] setObject:value forKey:(key)];[[NSUserDefaults standardUserDefaults] synchronize]
#define UDSetValue(value, key) [[NSUserDefaults standardUserDefaults] setValue:value forKey:(key)];[[NSUserDefaults standardUserDefaults] synchronize]
#define UDSetBool(value, key) [[NSUserDefaults standardUserDefaults] setInteger:value forKey:(key)];[[NSUserDefaults standardUserDefaults] synchronize]
#define UDSetInt(value, key) [[NSUserDefaults standardUserDefaults] setFloat:value forKey:(key)];[[NSUserDefaults standardUserDefaults] synchronize]
#define UDSetFloat(value, key) [[NSUserDefaults standardUserDefaults] setBool:value forKey:(key)];[[NSUserDefaults standardUserDefaults] synchronize]

#define UDGetObject(key) [[NSUserDefaults standardUserDefaults] objectForKey:(key)]
#define UDGetValue(key) [[NSUserDefaults standardUserDefaults] valueForKey:(key)]
#define UDGetInt(key) [[NSUserDefaults standardUserDefaults] integerForKey:(key)]
#define UDGetFloat(key) [[NSUserDefaults standardUserDefaults] floatForKey:(key)]
#define UDGetBool(key) [[NSUserDefaults standardUserDefaults] boolForKey:(key)]

#define topDelegate ((AppDelegate *)[[UIApplication sharedApplication] delegate])


//#define FB_ID @"517480821615042"
//#define THUMB_IMAGE_SIZE 100
//#define KEYBORAD_HEIGHT_IPHONE 216
//#define CELL_HEIGHT 96
//
//#define dt_time_formatter @"MM-dd-yyyy HH:mm:ss"
//#define dt_formatter @"mm-dd-yyyy"
//#define time_formatter @"HH:mm:ss"
#define Padding 20
#define dDate @"dDate"*/
typedef enum {
    HTTPRequestTypeGeneral,
    HTTPRequestTypeLogin,
    HTTPRequestTypeForgotPassword,
    HTTPManagerTypeGetContestList,
    HTTPRequestTypeGetVideoList,
    HTTPRequestTypeSignUp,
    
} HTTPRequestType;

typedef enum {
    jServerError = 0,
    jSuccess,
    jInvalidResponse,
    jNetworkError,
}ErrorCode;
typedef enum {
    
    jGeneralQuery,
    jListQuery,
    jBarTenderQuery,
    jFoodDrinkQuery,
    jSpecialQuery,
    jEventQuery,
    JBarDetailQuery,
    jAddBarRating,
    jLoginWithFB,
    jDeleteQuery,
    jNotificationQuery,
    jFavouriteQuery,
    jGeneralChechIn,
    jBarflyme,
} HTTPRequest;
typedef enum FBRequestType {
    
    fAPIGraphPermission,
    fLogin,
    fAPIGraphUserFriends,
    
}FBRequestType;

