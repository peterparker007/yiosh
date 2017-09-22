//
// UIViewController+SideMenu.m

//  Bhumesh Purohit
//
//  Created by Bhumesh Purohit on 3/17/15.
//  Copyright (c) 2015 Bhumesh Purohit. All rights reserved.
#import "UIViewController+RESideMenu.h"
#import "SideMenu.h"

@implementation UIViewController (SideMenu)

- (SideMenu *)sideMenuViewController
{
    UIViewController *iter = self.parentViewController;
    while (iter) {
        if ([iter isKindOfClass:[SideMenu class]]) {
            return (SideMenu *)iter;
        } else if (iter.parentViewController && iter.parentViewController != iter) {
            iter = iter.parentViewController;
        } else {
            iter = nil;
        }
    }
    return nil;
}

#pragma mark -
#pragma mark IB Action Helper methods

- (IBAction)presentLeftMenuViewController:(id)sender
{
    [self.sideMenuViewController presentLeftMenuViewController];
}

- (IBAction)presentRightMenuViewController:(id)sender
{
    [self.sideMenuViewController presentRightMenuViewController];
}

@end
