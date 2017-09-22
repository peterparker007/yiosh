//
//  DEMORightMenuViewController.h
//  ZapFashion
//
//  Created by bhumesh on 9/8/17.
//  Copyright © 2017 bhumesh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SideMenu.h"
@interface DEMORightMenuViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

+(DEMORightMenuViewController *)shareInstance;
-(void) setLeftmenuItems:(NSInteger)tag;
@end
