//
//  Globals.h
//  Rover
//
//  Created by Aadil Keshwani on 3/17/15.
//  Copyright (c) 2015 Aadil Keshwani. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Users.h"
#import "Constant.h"
@class Channels;
@interface Globals : NSObject
+ (id)sharedManager;
@property Users *user;
@property (nonatomic,copy)NSMutableArray *arrWishList;
@property (nonatomic,copy)NSMutableArray *arrItems,*arrNewItem;
@property (nonatomic,copy)NSMutableDictionary *SignupData;
@property NSMutableArray *users,*arrGlobalItemsBox;
@property UIActivityIndicatorView *spinner;
@property BOOL addObj;
@property BOOL uploadV;
@property BOOL isSearched,isSwitchRefreshON,isSwitchNotificationON, isFacebookLogin,isTwitterLogin ;
+ (void)ShowAlertWithTitle:(NSString *)title Message:(NSString *)message;
- (void)showLoaderIn:(UIView *)view;
- (void)hideLoader:(UIView *)view;
-(void)Displaymsg:(UIView *)view msg:(NSString*)msg;
-(CGRect )currentDevicePositions:(CGRect )frame vwRect:(CGRect )vwRect;
-(CGRect)getXYPositions:(NSString*)str;
@end
