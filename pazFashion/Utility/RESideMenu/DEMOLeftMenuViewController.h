//
//  DEMOMenuViewController.h


//  Bhumesh Purohit
//
//  Created by Bhumesh Purohit on 3/17/15.
//  Copyright (c) 2015 Bhumesh Purohit. All rights reserved.
#import <UIKit/UIKit.h>
#import "SideMenu.h"
//#import "UsersData.h"
@interface DEMOLeftMenuViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
   //  UsersData *objUser;
}
+(DEMOLeftMenuViewController *)shareInstance;
-(void) setLeftmenuItems:(NSInteger)tag;
@end
