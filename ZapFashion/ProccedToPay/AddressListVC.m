//
//  AddressListVC.m
//  ZapFashion
//
//  Created by bhumesh on 7/28/17.
//  Copyright © 2017 bhumesh. All rights reserved.
//

#import "AddressListVC.h"
#import "AdreessListTblVWCell.h"
#import "AddNewAddressVC.h"
#import "PaymentViewController.h"
@interface AddressListVC ()
{
    NSMutableDictionary *savedValue;
}
@end

@implementation AddressListVC
@synthesize tblvw;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    appDelegateTemp = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    objMyGlobals=[Globals sharedManager];
    tableData=[[NSMutableArray alloc]initWithObjects:@"image2",@"image3",@"image4",@"image5",@"image6",@"image7", nil];
    tblvw.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [tblvw reloadData];
    [self GetAddress];
  [self.navigationController setNavigationBarHidden:YES];
 //   [self DisplayBadge];
   // [self MenuButttonTapped:_btnmenu];
    // Do any additional setup after loading the view, typically from a nib.
}
-(void)viewWillAppear:(BOOL)animated
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"Data.plist"];
    savedValue  = [[NSMutableDictionary alloc] initWithContentsOfFile: path];
    [_TopView setBackgroundColor: [self colorWithHexString:[savedValue valueForKey:@"header_color"]]];
    [_HeaderTitle setTextColor:[self colorWithHexString:[savedValue valueForKey:@"header_text_color"]]];
    [_btnAddNewAddress setBackgroundColor: [self colorWithHexString:[savedValue valueForKey:@"signup_btn_col"]]];
       [_btnMakePayement setBackgroundColor: [self colorWithHexString:[savedValue valueForKey:@"login_btn_col"]]];
      [self.view setBackgroundColor:[self colorWithHexString:[savedValue valueForKey:@"bg_color"]]];
     [self SetConfigForTopView];
}
-(void)SetConfigForTopView
{
   
   CGRect frame1=[objMyGlobals getXYPositions:[savedValue valueForKey:@"page_title_position"]];
    _HeaderTitle.frame=[objMyGlobals currentDevicePositions:CGRectMake(frame1.origin.x, frame1.origin.y, 140, 21) vwRect:self.view.frame];
    frame1=[objMyGlobals getXYPositions:[savedValue valueForKey:@"logo_position"]];
    _Logo.frame=[objMyGlobals currentDevicePositions:CGRectMake(frame1.origin.x, frame1.origin.y, 77, 18) vwRect:self.view.frame];
    
    CGRect frame = tblvw.frame;
    frame.origin.y= _TopView.frame.size.height+1;
    frame.size.width=_TopView.frame.size.width;
    frame.size.height=self.view.frame.size.height-_TopView.frame.size.height;
    tblvw.frame=frame;
    
    frame= _divider.frame;
    frame.origin.y= _TopView.frame.size.height;
    frame.size.width= _TopView.frame.size.width;
    _divider.frame=frame;
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
-(void)GetAddress
{
    objMyGlobals.user.apikey=[@"ICXE1wOphgKgcyMoHr0hVHbbJ" mutableCopy];
    //objMyGlobals.user.CustID=_CustID;
    objMyGlobals.user.userid=[@"141" mutableCopy];
  [objMyGlobals showLoaderIn:self.view];
    if([appDelegateTemp checkInternetConnection]==true)
    {
        [objMyGlobals.user GetAddressData:^(NSString *str, int status)
         {
             if(status==1){
                 [self.tblvw reloadData];
                 [objMyGlobals hideLoader:self.view];
             }
             else{
                 [self.tblvw reloadData];
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
-(void)viewDidAppear:(BOOL)animated
{
    [self GetAddress];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return appDelegateTemp.AddressData.count;
}
- (IBAction)MenuButttonTapped:(id)sender
{
    
    // DEMOLeftMenuViewController *leftMenuViewController = [DEMOLeftMenuViewController shareInstance];
    // [leftMenuViewController MessageCount];
    [sender addTarget:self action:@selector(presentLeftMenuViewController:) forControlEvents:UIControlEventTouchUpInside];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"AdreessListTblVWCell";
    
    AdreessListTblVWCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[AdreessListTblVWCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    NSMutableDictionary *temp=[[NSMutableDictionary alloc]initWithDictionary:[appDelegateTemp.AddressData objectAtIndex:indexPath.row]];

    cell.txtVW.text=[NSString stringWithFormat:@"%@ %@,\n%@,\n%@,\n%@,\n%@,\n%@",[temp objectForKey:@"firstname"],[temp objectForKey:@"lastname"],[[temp objectForKey:@"street"] componentsJoinedByString:@",\n"],[temp objectForKey:@"city"],[temp objectForKey:@"region"],[temp objectForKey:@"postcode"],[temp objectForKey:@"mobile"]];
    NSString *string =  cell.txtVW.text;
    
    NSCharacterSet *trim = [NSCharacterSet characterSetWithCharactersInString:@"() "];
    NSString *result = [[string componentsSeparatedByCharactersInSet:trim] componentsJoinedByString:@""];
    cell.txtVW.text=result;
    cell.btnEdit.tag=indexPath.row;
    cell.btnDelete.tag=indexPath.row+1000;
    [cell.btnEdit addTarget:self action:@selector(EditAdress:) forControlEvents:UIControlEventTouchUpInside];
    [cell.btnDelete addTarget:self action:@selector(DeleteAddress:) forControlEvents:UIControlEventTouchUpInside];
    [cell.txtVW scrollRangeToVisible:NSMakeRange(0, 1)];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
       NSString *strIndex =[NSString stringWithFormat:@"%ld",(long)indexPath.row];
  if([selectedIndex isEqualToString:strIndex])
    {
        [cell.btnSelection setImage:[UIImage imageNamed:@"ic_check"] forState:UIControlStateNormal];
        
        // set image of selected
    }
    else{
        [cell.btnSelection setImage:[UIImage imageNamed:@"ic_uncheck"] forState:UIControlStateNormal];
    }
    return cell;
}
-(void)EditAdress:(id)sender
{
    UIButton *btn=sender;
    NSIndexPath* indexpath = [NSIndexPath indexPathForRow:btn.tag inSection:0];
    UIStoryboard *objStoryboard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    AddNewAddressVC *newView = (AddNewAddressVC *)[objStoryboard instantiateViewControllerWithIdentifier:@"AddNewAddressVC"];
    newView.indexpath=indexpath;
    newView.isEdit=true;
    //  newView.AddressDataDic=[appDelegateTemp.AddressData objectAtIndex:indexpath.row];
    [self.navigationController pushViewController:newView animated:YES];
}
-(void)DeleteAddress:(id)sender
{
    UIButton *btn=sender;
    NSIndexPath* indexpath = [NSIndexPath indexPathForRow:btn.tag inSection:0];
    NSMutableDictionary *temp=[[NSMutableDictionary alloc]initWithDictionary:[appDelegateTemp.AddressData objectAtIndex:indexpath.row-1000]];
    objMyGlobals.user.apikey=[@"ICXE1wOphgKgcyMoHr0hVHbbJ" mutableCopy];
    objMyGlobals.user.EditAddressId=[temp objectForKey:@"address_id"];
  [objMyGlobals showLoaderIn:self.view];
    if([appDelegateTemp checkInternetConnection]==true)
    {
        [objMyGlobals.user DeleteAddressData:^(NSString *str, int status)
         {
             if(status==1){
                 [self GetAddress];
                 //[self.collectionVW reloadData];
                 [objMyGlobals hideLoader:self.view];
             }
             else{
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AdreessListTblVWCell *cell;
    NSMutableDictionary *temp=[[NSMutableDictionary alloc]initWithDictionary:[appDelegateTemp.AddressData objectAtIndex:indexPath.row]];
    objMyGlobals.user.EditAddressId=[temp objectForKey:@"address_id"];
    cell = (AdreessListTblVWCell *)[self.tblvw cellForRowAtIndexPath:indexPath];
   
    // [cell.btnSelection setImage:nil];
    if([selectedIndex isEqualToString:[NSString stringWithFormat:@"%ld",(long)indexPath.row]])
    {
        cell.isSelected=false;
        [cell.btnSelection setImage:[UIImage imageNamed:@"ic_uncheck"] forState:UIControlStateNormal];
        selectedIndex=@"";
    }
    else
    {
        cell.isSelected=true;
        [cell.btnSelection setImage:[UIImage imageNamed:@"ic_check"] forState:UIControlStateNormal];
        selectedIndex=[NSString stringWithFormat:@"%ld",(long)indexPath.row];
    }
    [tblvw reloadData];
}

- (IBAction)btnMakePaymentTapped:(id)sender {
  if(selectedIndex.length!=0)
  {
    UIStoryboard *objStoryboard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    PaymentViewController *newView = (PaymentViewController *)[objStoryboard instantiateViewControllerWithIdentifier:@"PaymentViewController"];
    [self.navigationController pushViewController:newView animated:YES];
  }
    else
    {
        [objMyGlobals Displaymsg:self.view msg:@"Please select address from addresslist."];
    }

}

- (IBAction)AddNewAddress:(id)sender {
    UIStoryboard *objStoryboard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    AddNewAddressVC *newView = (AddNewAddressVC *)[objStoryboard instantiateViewControllerWithIdentifier:@"AddNewAddressVC"];
    [self.navigationController pushViewController:newView animated:YES];
}
//PaymentViewController
- (IBAction)btnBackTapped:(id)sender {
     [self.navigationController popViewControllerAnimated:YES];
}
@end
