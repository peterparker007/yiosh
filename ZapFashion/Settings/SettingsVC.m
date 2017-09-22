//
//  SettingsVC.m
//  ZapFashion
//
//  Created by bhumesh on 6/5/17.
//  Copyright © 2017 bhumesh. All rights reserved.
//

#import "SettingsVC.h"
#import "DEMOLeftMenuViewController.h"
#import "AppDelegate.h"
@interface SettingsVC ()
@end
@implementation SettingsVC
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self MenuButttonTapped:_btnmenu];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"Data.plist"];
    NSMutableDictionary *savedValue = [[NSMutableDictionary alloc] initWithContentsOfFile: path];
     [_TopView setBackgroundColor: [self colorWithHexString:[savedValue valueForKey:@"header_color"]]];
    [_HeaderTitle setTextColor:[self colorWithHexString:[savedValue valueForKey:@"header_text_color"]]];
    
}
-(UIColor*)colorWithHexString:(NSString*)hex
{
    NSString *cString = [[hex stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) return [UIColor grayColor];
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    
    if ([cString length] != 6) return  [UIColor grayColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}
- (IBAction)MenuButttonTapped:(id)sender
{
    
    //DEMOLeftMenuViewController *leftMenuViewController = [DEMOLeftMenuViewController shareInstance];
    // [leftMenuViewController MessageCount];
    [sender addTarget:self action:@selector(presentLeftMenuViewController:) forControlEvents:UIControlEventTouchUpInside];
}
#pragma mark -Switch Change
- (IBAction)ChangeSwitch:(id)sender {
    _switchHandler=(UISwitch*)sender;
    
    if ([_switchHandler isOn])
    {
          // objGlobals.isSwitchNotificationON = true;
        [_switchHandler setOn:YES animated:YES];
        
    }
    else
    {
        // objGlobals.isSwitchNotificationON = false;
        [_switchHandler setOn:NO animated:NO];
        
    }

}

- (IBAction)btnLogoutTapped:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:
                                @"Main" bundle:nil];
     AppDelegate *appDelegateTemp = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    WelcomeVC *second=(WelcomeVC *)[storyboard instantiateViewControllerWithIdentifier:@"WelcomeVC"];
    UINavigationController *navVC = [[UINavigationController alloc] initWithRootViewController:second];
    
    appDelegateTemp.window.rootViewController=navVC;
}
@end
