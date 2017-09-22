//
// UIViewController+SideMenu.h

//  Bhumesh Purohit
//
//  Created by Bhumesh Purohit on 3/17/15.
//  Copyright (c) 2015 Bhumesh Purohit. All rights reserved.
#import <UIKit/UIKit.h>

@class SideMenu;

@interface UIViewController (SideMenu)

@property (strong, readonly, nonatomic) SideMenu *sideMenuViewController;

// IB Action Helper methods

- (IBAction)presentLeftMenuViewController:(id)sender;
- (IBAction)presentRightMenuViewController:(id)sender;

@end
