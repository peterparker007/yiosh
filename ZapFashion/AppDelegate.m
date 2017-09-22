//
//  AppDelegate.m
//  ZapFashion
//
//  Created by bhumesh on 6/1/17.
//  Copyright © 2017 bhumesh. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "CategoryTblVC.h"
#import "MyAccountVC.h"
#import "OrderHistoryVC.h"
#import "WishListVC.h"
#import "NotificationHistoryVC.h"
#import "SettingsDynamicVC.h"
#import "NewDashboard.h"
#import "ThirdDashboard.h"
@interface AppDelegate ()

@end

@implementation AppDelegate
@synthesize localDataDic,CategoryData,temp,ProductData,WishListData,CartData,AddressData,TotalPage,DiscountData,TotalCartItem,AdvanceProductData,FilterData,OrderHistoryData,AttributeData,ProductDetailsData,ArrMobileCMS,ArrImageBanner,ArrCategoryBanner,ArrNotifications,strMenuType;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationNone];

    
    // Override point for customization after application launch.
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
     localDataDic=[[NSMutableDictionary alloc]init];
    ProductData=[[NSMutableArray alloc]init];
    CategoryData=[[NSMutableArray alloc]init];
    WishListData=[[NSMutableArray alloc]init];
    CartData=[[NSMutableArray alloc]init];
    AddressData=[[NSMutableArray alloc]init];
    TotalPage=[[NSMutableString alloc]init];
    strMenuType=[[NSMutableString alloc]init];
    TotalCartItem=[[NSMutableString alloc]init];
    DiscountData=[[NSMutableArray alloc]init];
    AdvanceProductData=[[NSMutableArray alloc]init];
     FilterData=[[NSMutableArray alloc]init];
    OrderHistoryData=[NSMutableArray new];
    AttributeData=[NSMutableArray new];
    ProductDetailsData=[NSMutableArray new];
    ArrMobileCMS=[NSMutableArray new];
    ArrImageBanner=[NSMutableArray new];
    ArrCategoryBanner=[NSMutableArray new];
    ArrNotifications=[NSMutableArray new];

     self.objtabBarController.delegate = self;
    
    self.objtabBarController =[[MyUITabBarController alloc] initWithNibName:@"ViewController" bundle:nil];
    
    //create the view controller for the first tab
    // self.ViewController = [[ViewController alloc] initWithNibName:@"ViewController"
    //                                                              bundle:NULL];
   
  //  self.NewDashboard= (NewDashboard *)[objStoryboard instantiateViewControllerWithIdentifier:@"NewDashboard"];
  //  self.ThirdDashboard= (ThirdDashboard *)[objStoryboard instantiateViewControllerWithIdentifier:@"ThirdDashboard"];
    
    
    //create an array of all view controllers that will represent the tab at the bottom
       
    // Override point for customization after application launch.
    return YES;
}
- (void) tabBarController:(UITabBarController*)tabBarController didSelectViewController:(UIViewController*)viewController
{
   
}
-(BOOL)checkInternetConnection
{
    Reachability* reach = [Reachability reachabilityWithHostname:@"www.google.com"];
    
    return [reach isReachable];
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
