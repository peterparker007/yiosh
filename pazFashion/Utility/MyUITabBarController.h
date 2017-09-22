//
//  MyUITabBarController.h
//  TabbarController
//
//  Created by bhumesh on 9/18/17.
//  Copyright © 2017 bhumesh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyUITabBarController : UITabBarController<UITabBarDelegate,UITabBarControllerDelegate>
{
    UIView *v;
}
-(void)setTabBarColor:(UIColor*)color;
@end
