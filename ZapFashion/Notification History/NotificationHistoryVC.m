//
//  NotificationHistoryVC.m
//  ZapFashion
//
//  Created by bhumesh on 6/6/17.
//  Copyright © 2017 bhumesh. All rights reserved.
//

#import "NotificationHistoryVC.h"
#import "DEMOLeftMenuViewController.h"
#import "NotificationHistorytblvwCell.h"
#import "CheckoutVC.h"

@interface NotificationHistoryVC ()

@end

@implementation NotificationHistoryVC
@synthesize tblvw;
- (void)viewDidLoad {
    [super viewDidLoad];
     appDelegateTemp = (AppDelegate *)[[UIApplication sharedApplication]delegate];
        [self DisplayBadge];
//    tableData=[[NSMutableArray alloc]initWithObjects:@"image2",@"image3",@"image4",@"image5",@"image6",@"image7", nil];
//    [tblvw reloadData];
    [self GetData];
  [self.navigationController setNavigationBarHidden:YES];
    [self MenuButttonTapped:_btnmenu];
      [self rightMenuTapped:_btnmenu2];
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"Data.plist"];
  savedValue = [[NSMutableDictionary alloc] initWithContentsOfFile: path];
      [_TopView setBackgroundColor: [self colorWithHexString:[savedValue valueForKey:@"header_color"]]];
    [_HeaderTitle setTextColor:[self colorWithHexString:[savedValue valueForKey:@"header_text_color"]]];
    [self SetConfigForTopView];
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
    [self.navigationController setNavigationBarHidden:YES];
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO];
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
    _HeaderTitle.frame=[objMyGlobals currentDevicePositions:CGRectMake(frame1.origin.x, frame1.origin.y, 160, 21) vwRect:self.view.frame];
    frame1=[objMyGlobals getXYPositions:[savedValue valueForKey:@"logo_position"]];
    _Logo.frame=[objMyGlobals currentDevicePositions:CGRectMake(frame1.origin.x, frame1.origin.y, 77, 18) vwRect:self.view.frame];    
    _btnmenu2.frame=[objMyGlobals currentDevicePositions:CGRectMake(284, 3, 33, 50) vwRect:self.view.frame];
    CGRect frame = tblvw.frame;
    frame.origin.y= _TopView.frame.size.height+1;
    frame.size.width=_TopView.frame.size.width;
    frame.size.height=self.view.frame.size.height-_TopView.frame.size.height;
    tblvw.frame=frame;
    
    frame= _divder.frame;
    frame.origin.y= _TopView.frame.size.height;
    frame.size.width= _TopView.frame.size.width;
    _divder.frame=frame;
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
-(void)GetData
{
    Globals *objMyGlobals;
    objMyGlobals=[Globals sharedManager];
  
    if([appDelegateTemp checkInternetConnection]==true)
    {
        [objMyGlobals showLoaderIn:self.view];
        [objMyGlobals.user GetNotificationHistory:^(NSString *str, int status)
         {
             
             if(status==1)
             {
                 [objMyGlobals hideLoader:self.view];
                 tableData=appDelegateTemp.ArrNotifications;
                 [tblvw reloadData];
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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return tableData.count;
}
- (IBAction)MenuButttonTapped:(id)sender
{
    [sender addTarget:self action:@selector(presentLeftMenuViewController:) forControlEvents:UIControlEventTouchUpInside];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"NotificationHistorytblvwCell";
    NotificationHistorytblvwCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil) {
        cell = [[NotificationHistorytblvwCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
     [cell setBackgroundColor:[self colorWithHexString:[savedValue valueForKey:@"bg_color"]]];
    cell.imgView.layer.cornerRadius = cell.imgView.frame.size.height/2;
    cell.imgView.layer.masksToBounds = YES;
    cell.imgView.layer.cornerRadius = 24;
    cell.imgView.layer.masksToBounds = YES;
    cell.imgView.image=[UIImage imageNamed:@"ic_percent"];
    cell.lblDetails.text=[[tableData objectAtIndex:indexPath.row] valueForKey:@"name"];
    cell.lblDate.textColor=[UIColor lightGrayColor];
    cell.lblDate.text=[[tableData objectAtIndex:indexPath.row] valueForKey:@"from_date"];
    return cell;
}
- (IBAction)btnCartTapped:(id)sender {
    UIStoryboard *objStoryboard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    CheckoutVC *newView = (CheckoutVC *)[objStoryboard instantiateViewControllerWithIdentifier:@"CheckoutVC"];
    [self.navigationController pushViewController:newView animated:YES];
}
-(void)DisplayBadge
{       NSString *str=@"0";
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
