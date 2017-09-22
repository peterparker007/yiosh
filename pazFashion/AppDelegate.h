//
//  AppDelegate.h
//  ZapFashion
//
//  Created by bhumesh on 6/1/17.
//  Copyright © 2017 bhumesh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Reachability.h"
#import "MyUITabBarController.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate,UITabBarDelegate,UITabBarControllerDelegate>
{
UITabBarController *tabBarController;
}
@property (strong, nonatomic) UITabBarController *tabBarController;
@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic)  NSMutableDictionary *localDataDic,*temp;
@property (strong, nonatomic)  NSMutableArray *CategoryData,*ProductData,*WishListData,*CartData,*AddressData,*DiscountData,*AdvanceProductData,*FilterData,*OrderHistoryData,*AttributeData,*ProductDetailsData,*ArrMobileCMS,*ArrImageBanner,*ArrCategoryBanner,*ArrNotifications,*ArrMenuItems;
@property (strong, nonatomic)NSMutableString *TotalPage,*TotalCartItem,*strMenuType;
@property (strong, nonatomic) MyUITabBarController *objtabBarController;
-(BOOL)checkInternetConnection;
@end

