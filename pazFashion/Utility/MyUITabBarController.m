//
//  MyUITabBarController.m
//  TabbarController
//
//  Created by bhumesh on 9/18/17.
//  Copyright © 2017 bhumesh. All rights reserved.
//

#import "MyUITabBarController.h"

@interface MyUITabBarController ()

@end

@implementation MyUITabBarController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    CGRect frame = CGRectMake(0.0, 0.0, self.view.bounds.size.width, 48);
    
//    v = [[UIView alloc] initWithFrame:frame];
//    [v setBackgroundColor:[UIColor lightGrayColor]];
//    [v setAlpha:0.5];
//    [[self tabBar] addSubview:v];
   // [[self tabBar]setBackgroundColor:[UIColor redColor]];
    //set the tab bar title appearance for normal state
//    [self.tabBarController.tabBar setBackgroundColor:
//     [UIColor  whiteColor]];
    [self.tabBar setBackgroundColor:[UIColor whiteColor]];
//    [self.tabBarController.tabBar setTranslucent:NO];
    
    UIImage* tabBarBackground = [UIImage imageNamed:@"Transperentvw"];
    [[UITabBar appearance] setBackgroundImage:tabBarBackground];
    [[UITabBarItem appearance]
     setTitleTextAttributes:@{UITextAttributeTextColor : [UIColor lightGrayColor],
                              UITextAttributeFont:[UIFont boldSystemFontOfSize:12.0f]}
     forState:UIControlStateNormal];
    
    //set the tab bar title appearance for selected state
    [[UITabBarItem appearance]
     setTitleTextAttributes:@{ UITextAttributeTextColor : [UIColor blackColor],
                               UITextAttributeFont:[UIFont boldSystemFontOfSize:12.0f]}
     
     forState:UIControlStateSelected];
    
    [[UITabBar appearance] setSelectedImageTintColor:[UIColor blueColor]];

    //create a custom view for the tab bar
}
-(void)setTabBarColor:(UIColor*)color
{
    [self.tabBar setBackgroundColor:color];
}
//-(void)viewWillAppear:(BOOL)animated
//{
//    
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString *documentsDirectory = [paths objectAtIndex:0];
//    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"Data.plist"];
//    NSMutableDictionary   *savedValue  = [[NSMutableDictionary alloc] initWithContentsOfFile: path];
//   
//    
//}
//-(UIColor*)colorWithHexString:(NSString*)hex
//{
//    NSString *cString = [[hex stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
//    // String should be 6 or 8 characters
//    if ([cString length] < 6) return [UIColor grayColor];
//    // strip 0X if it appears
//    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
//    if ([cString length] != 6) return  [UIColor grayColor];
//    // Separate into r, g, b substrings
//    NSRange range;
//    range.location = 0;
//    range.length = 2;
//    NSString *rString = [cString substringWithRange:range];
//    range.location = 2;
//    NSString *gString = [cString substringWithRange:range];
//    range.location = 4;
//    NSString *bString = [cString substringWithRange:range];
//    // Scan values
//    unsigned int r, g, b;
//    [[NSScanner scannerWithString:rString] scanHexInt:&r];
//    [[NSScanner scannerWithString:gString] scanHexInt:&g];
//    [[NSScanner scannerWithString:bString] scanHexInt:&b];
//    return [UIColor colorWithRed:((float) r / 255.0f)
//                           green:((float) g / 255.0f)
//                            blue:((float) b / 255.0f)
//                           alpha:1.0f];
//}
-(void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    
}
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    return YES;
}
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    if (viewController == tabBarController.moreNavigationController && tabBarController.moreNavigationController.delegate == nil) {
        // here we replace the "More" tab table delegate with our own implementation
        // this allows us to replace viewControllers seamlessly
        
//        UITableView *view = (UITableView *)self.tabBarController.moreNavigationController.topViewController.view;
//        self.originalDelegate = view.delegate;
//        view.delegate = self;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // this is the delegate for the "More" tab table
    // it intercepts any touches and replaces the selected view controller if needed
    // then, it calls the original delegate to preserve the behavior of the "More" tab
    
    // do whatever here
    // and call the original delegate afterwards
  
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
