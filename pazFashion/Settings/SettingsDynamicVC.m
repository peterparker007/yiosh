//
//  SettingsDynamicVC.m
//  ZapFashion
//
//  Created by bhumesh on 8/18/17.
//  Copyright © 2017 bhumesh. All rights reserved.
//

#import "SettingsDynamicVC.h"
#import "DEMOLeftMenuViewController.h"
#import "AppDelegate.h"
#import "Globals.h"
#import "DetailsSettingsVC.h"
#import "ChangePasswordVC.h"
#import "WelcomeVC.h"
#import "NotificationHistoryVC.h"
#import "CheckoutVC.h"
@interface SettingsDynamicVC ()

@end

@implementation SettingsDynamicVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self MenuButttonTapped:_btnmenu];
    
    appDelegateTemp = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    [self GetData];
     [self DisplayBadge];
     [self rightMenuTapped:_btnmenu2];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"Data.plist"];
    _HeaderTitle.text=_strTitle;
    savedValue = [[NSMutableDictionary alloc] initWithContentsOfFile: path];
    [_TopView setBackgroundColor: [self colorWithHexString:[savedValue valueForKey:@"header_color"]]];
    [_HeaderTitle setTextColor:[self colorWithHexString:[savedValue valueForKey:@"header_text_color"]]];
      [_tblvw setBackgroundColor:[self colorWithHexString:[savedValue valueForKey:@"bg_color"]]];
    [self SetConfigForTopView];
    [self.navigationController setNavigationBarHidden:YES];
    if([appDelegateTemp.strMenuType isEqualToString:@"tab"])
    {
        _btnmenu2.hidden=true;
        _btnmenu.hidden=true;
        
    }
    else if([appDelegateTemp.strMenuType isEqualToString:@"Right"])
    {
        _btnmenu2.hidden=false;
        _btnmenu.hidden=true;
    }
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO];
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
    [sender addTarget:self action:@selector(presentLeftMenuViewController:) forControlEvents:UIControlEventTouchUpInside];
}
-(void)GetData
{
    Globals *objMyGlobals;
    objMyGlobals=[Globals sharedManager];
    
    if([appDelegateTemp checkInternetConnection]==true)
    {
        [objMyGlobals showLoaderIn:self.view];
        [objMyGlobals.user GetSettingPages:^(NSString *str, int status)
         {
             
             if(status==1)
             {
                 [objMyGlobals hideLoader:self.view];
                 NSLog(@"%@",appDelegateTemp.ArrMobileCMS);
                 _tblvw.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
                 [_tblvw reloadData];
             }
             else
             {
                 [objMyGlobals Displaymsg:self.view msg:str];
                 [objMyGlobals hideLoader:self.view];
             }
         }];
    }
    else
    {
        [objMyGlobals Displaymsg:self.view msg:@"Please check Your Internet Connection"];
        [objMyGlobals hideLoader:self.view];
    }
}
#pragma mark -Set Order History in Tableview
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return appDelegateTemp.ArrMobileCMS.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"UITableViewCell";
    UITableViewCell *cell = [_tblvw dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
//    NSString *strCMSType=[[appDelegateTemp.ArrMobileCMS objectAtIndex:indexPath.row]valueForKey:@"menu_name"];
//    UIImageView *imageView;
//    
//    if([strCMSType isEqualToString:@"Privacy Policy"]||[strCMSType isEqualToString:@"Change Password"])
//       imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ic_changepass"]];
//    else if([strCMSType isEqualToString:@"Notifications"]||[strCMSType isEqualToString:@"About Us"])
//            imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ic_aboutapp"]];
//    else if ([strCMSType isEqualToString:@"Logout"])
//          imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ic_logout"]];
//    cell.selectionStyle =UITableViewCellSelectionStyleNone;
//    cell.accessoryView = imageView;
  
 /*
    NSURL *url = [NSURL URLWithString:[savedValue valueForKey:@"bag_logo"]];
    
    NSURLSessionTask *task = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (data) {
            UIImage *image = [UIImage imageWithData:data];
            if (image) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    cell.imageView.image = image;
                });
            }
        }
    }];
    [task resume];*/
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell.textLabel  setTextColor: [self colorWithHexString:[savedValue valueForKey:@"drawer_text_col"]]];
    cell.textLabel.text=[[appDelegateTemp.ArrMobileCMS objectAtIndex:indexPath.row] valueForKey:@"menu_name"];
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     NSString *strCMSType=[[appDelegateTemp.ArrMobileCMS objectAtIndex:indexPath.row]valueForKey:@"menu_name"];
    if ([[[appDelegateTemp.ArrMobileCMS objectAtIndex:indexPath.row] valueForKey:@"child"]  isEqualToString:@"1"])
    {   Globals *objMyGlobals;
        objMyGlobals=[Globals sharedManager];
        objMyGlobals.user.Menu_id=[[appDelegateTemp.ArrMenuItems objectAtIndex:indexPath.row] valueForKey:@"id"];
        [self GetData];
    }   
    else if ([strCMSType isEqualToString:@"Logout"])
    {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:
                                    @"Main" bundle:nil];
        WelcomeVC *second=(WelcomeVC *)[storyboard instantiateViewControllerWithIdentifier:@"WelcomeVC"];
        UINavigationController *navVC = [[UINavigationController alloc] initWithRootViewController:second];
        
        appDelegateTemp.window.rootViewController=navVC;
    }
    else
    {
        UIStoryboard *objStoryboard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
        DetailsSettingsVC *newView = (DetailsSettingsVC *)[objStoryboard instantiateViewControllerWithIdentifier:@"DetailsSettingsVC"];
        newView.strTitle=[[appDelegateTemp.ArrMobileCMS objectAtIndex:indexPath.row]valueForKey:@"menu_name"];
        newView.strContents=[[appDelegateTemp.ArrMobileCMS objectAtIndex:indexPath.row]valueForKey:@"content"];
        [self.navigationController pushViewController:newView animated:YES];
    }
   
//    if([strCMSType isEqualToString:@"Privacy Policy"]||[strCMSType isEqualToString:@"About Us"])
//    {
//        UIStoryboard *objStoryboard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
//        DetailsSettingsVC *newView = (DetailsSettingsVC *)[objStoryboard instantiateViewControllerWithIdentifier:@"DetailsSettingsVC"];
//         newView.strTitle=[[appDelegateTemp.ArrMobileCMS objectAtIndex:indexPath.row]valueForKey:@"page_name"];
//        newView.strContents=[[appDelegateTemp.ArrMobileCMS objectAtIndex:indexPath.row]valueForKey:@"content"];
//        [self.navigationController pushViewController:newView animated:YES];
//    }
//    else if ([strCMSType isEqualToString:@"Change Password"])
//    {
//        UIStoryboard *objStoryboard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
//        ChangePasswordVC *newView = (ChangePasswordVC *)[objStoryboard instantiateViewControllerWithIdentifier:@"ChangePasswordVC"];
//      
//        [self.navigationController pushViewController:newView animated:YES];
//    }
    
//    else if ([strCMSType isEqualToString:@"Notifications"])
//    {
//        UIStoryboard *objStoryboard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
//        NotificationHistoryVC *newView = (NotificationHistoryVC *)[objStoryboard instantiateViewControllerWithIdentifier:@"NotificationHistoryVC"];
//        
//        [self.navigationController pushViewController:newView animated:YES];
//    }
    
}
-(void)SetConfigForTopView
{
    Globals *objMyGlobals;
    objMyGlobals=[Globals sharedManager];
    _TopView.frame=[objMyGlobals currentDevicePositions:CGRectMake(0, 0, 381, 50) vwRect:self.view.frame];
    _btnmenu.frame=[objMyGlobals currentDevicePositions:CGRectMake(0, 0, 33, 50) vwRect:self.view.frame];
    
    CGRect frame1=[objMyGlobals getXYPositions:[savedValue valueForKey:@"cart_logo_position"]];
    
    NSURL *fileUrl =[NSURL URLWithString:[savedValue valueForKey:@"bag_logo"]];
    
    NSData *fileData =[NSData dataWithContentsOfURL:fileUrl];
    
    dispatch_async(dispatch_get_main_queue(), ^ {
        
        
        [_btnCart setImage:[UIImage imageWithData:fileData] forState:UIControlStateNormal];
        
    });
    _btnCart.frame=[objMyGlobals currentDevicePositions:CGRectMake(frame1.origin.x, frame1.origin.y, 25, 25) vwRect:self.view.frame];
    _tempBadge.frame=[objMyGlobals currentDevicePositions:CGRectMake( frame1.origin.x+15, frame1.origin.y-7, 30, 30) vwRect:self.view.frame];
    frame1=[objMyGlobals getXYPositions:[savedValue valueForKey:@"page_title_position"]];
    _HeaderTitle.frame=[objMyGlobals currentDevicePositions:CGRectMake(frame1.origin.x, frame1.origin.y, 105, 21) vwRect:self.view.frame];
    frame1=[objMyGlobals getXYPositions:[savedValue valueForKey:@"logo_position"]];
    _Logo.frame=[objMyGlobals currentDevicePositions:CGRectMake(frame1.origin.x, frame1.origin.y, 77, 18) vwRect:self.view.frame];
    
    _btnmenu2.frame=[objMyGlobals currentDevicePositions:CGRectMake(284, 3, 33, 50) vwRect:self.view.frame];
    
    CGRect frame = _tblvw.frame;
    frame.origin.y= _TopView.frame.size.height+1;
    frame.size.width=_TopView.frame.size.width;
    frame.size.height=self.view.frame.size.height-_TopView.frame.size.height;
    _tblvw.frame=frame;
    
    frame= _divder.frame;
    frame.origin.y= _TopView.frame.size.height;
    frame.size.width= _TopView.frame.size.width;
    _divder.frame=frame;
}
- (IBAction)btnCartTapped:(id)sender {
    UIStoryboard *objStoryboard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    CheckoutVC *newView = (CheckoutVC *)[objStoryboard instantiateViewControllerWithIdentifier:@"CheckoutVC"];
    [self.navigationController pushViewController:newView animated:YES];
}
-(void)DisplayBadge
{
    NSString *str=@"0";
    if(![appDelegateTemp.TotalCartItem isEqualToString:str])
    {
        _tempBadge.layer.cornerRadius = _tempBadge.frame.size.width/2;
        _tempBadge.layer.masksToBounds = YES;
        _tempBadge.text=[NSString stringWithFormat:@"%@",appDelegateTemp.TotalCartItem];
        _tempBadge.textColor=[UIColor whiteColor];
        // [self.TopView addSubview:tempBadge];
    }
    else
    {
        _tempBadge.hidden=true;
    }
}
- (IBAction)rightMenuTapped:(id)sender {
    [sender addTarget:self action:@selector(presentRightMenuViewController:) forControlEvents:UIControlEventTouchUpInside];
}

@end
