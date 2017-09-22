//
//  WishListVC.m
//  ZapFashion
//
//  Created by bhumesh on 6/5/17.
//  Copyright © 2017 bhumesh. All rights reserved.
//

#import "WishListVC.h"
#import "DEMOLeftMenuViewController.h"
#import "WishListtblvwCell.h"
#import "CheckoutVC.h"
#import "CacheController.h"
@interface WishListVC ()
{
    NSMutableDictionary *savedValue;
}
@end
@implementation WishListVC
@synthesize tblvw;
- (void)viewDidLoad {
    [super viewDidLoad];
    objMyGlobals=[Globals sharedManager];
      appDelegateTemp = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    [self DisplayBadge];
     [self getWishList];
    //[tblvw reloadData];
    tblvw.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
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
      [tblvw setBackgroundColor:[self colorWithHexString:[savedValue valueForKey:@"bg_color"]]];
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
-(void)SetConfigForTopView
{
  
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
#pragma mark -Get Wish List Data
-(void)getWishList
{
    objMyGlobals.user.userid=[appDelegateTemp.localDataDic objectForKey:@"userid"];
    objMyGlobals.user.apikey=[@"ICXE1wOphgKgcyMoHr0hVHbbJ" mutableCopy];
  [objMyGlobals showLoaderIn:self.view];
   
    if([appDelegateTemp checkInternetConnection]==true)
    {
    [objMyGlobals.user getWishList:^(NSString *str, int status)
     {
         if(status==1)     {
             NSLog(@"%@",appDelegateTemp.WishListData);
             [self.tblvw reloadData];
              [objMyGlobals hideLoader:self.view];
         }
         else
         {
             [self.tblvw reloadData];
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
//Clear Wish List
-(void)ClearWishList
{
    objMyGlobals.user.userid=[appDelegateTemp.localDataDic objectForKey:@"userid"];
    objMyGlobals.user.apikey=[@"ICXE1wOphgKgcyMoHr0hVHbbJ" mutableCopy];
  [objMyGlobals showLoaderIn:self.view];
    __weak typeof(self) weakSelf = self;
    if([appDelegateTemp checkInternetConnection]==true)
    {
        [objMyGlobals.user clearWishList:^(NSString *str, int status)
         {
             if(status==1)
             {
                 NSLog(@"%@",appDelegateTemp.WishListData);
                 [self.tblvw reloadData];
                 [objMyGlobals hideLoader:self.view];
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
    return appDelegateTemp.WishListData.count;
}
- (IBAction)MenuButttonTapped:(id)sender
{
    [sender addTarget:self action:@selector(presentLeftMenuViewController:) forControlEvents:UIControlEventTouchUpInside];
}
//Set Wish List Data
#pragma mark -Set Data In TableView
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"WishListtblvwCell";
    NSMutableDictionary *dict=[appDelegateTemp.WishListData objectAtIndex:indexPath.row];
    WishListtblvwCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil) {
        cell = [[WishListtblvwCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }  
    cell.imgView.layer.cornerRadius = 30;
    cell.imgView.layer.masksToBounds = YES;
//    [cell.imgView sd_setImageWithURL:[dict objectForKey:@"image"]
//                        placeholderImage:[UIImage imageNamed:@"avatar-placeholder.png"]
//                                 options:SDWebImageRefreshCached];
    
    NSString *cacheKey = [NSString stringWithFormat:@"%@%ld%ld",[dict objectForKey:@"name"], (long)indexPath.row, (long)indexPath.section];
    NSData *cachedObject = [[CacheController sharedInstance] getCacheForKey:cacheKey];
    
    if (cachedObject != nil) {
        UIImage *img=[UIImage imageWithData:cachedObject];
        [cell.imgView setImage:img];
        // [[cell textLabel] setText:@"Got object from cache!"];
    }
    
    else {
        [cell downloadFile:[NSURL URLWithString:[dict objectForKey:@"image"]]
              forIndexPath:indexPath cacheKey:cacheKey];
    }
    
    cell.itemName.text=[dict objectForKey:@"name"];
    cell.NewPrices.textColor=[UIColor redColor];
    cell.NewPrices.text = [NSString stringWithFormat:@"₹ %@",[dict objectForKey:@"discount_price"]];
    cell.btnDelete.tag=indexPath.row;
    [cell.btnDelete addTarget:self action:@selector(DeleteData:) forControlEvents:UIControlEventTouchUpInside];
    if([dict objectForKey:@"discount_price"]==[dict objectForKey:@"price"])
    {
        cell.oldPrice.hidden=true;
    }
    else
    {
    NSString *tempstr1=[NSString stringWithFormat:@"%@",[dict objectForKey:@"price"]];
    NSMutableAttributedString *myString1= [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"₹%@ ",tempstr1]];
    [myString1 addAttribute:NSStrikethroughStyleAttributeName
                      value:@2
                      range:NSMakeRange(0, [myString1 length])];
    cell.oldPrice.textColor=[UIColor lightGrayColor];
    cell.oldPrice.attributedText = myString1;
    }
      return cell;
}
//Remove Data
-(void)DeleteData:(id)sender
{
    UIButton *btn=sender;
     NSIndexPath* indexpath = [NSIndexPath indexPathForRow:btn.tag inSection:0];
     NSMutableDictionary *dict=[appDelegateTemp.WishListData objectAtIndex:indexpath.row];
    [self RemoveItemWishList:[NSString stringWithFormat:@"%@",[dict objectForKey:@"id"]]];
}
//Method For Remove Data
-(void)RemoveItemWishList:(NSString*)prdctid
{
    objMyGlobals.user.apikey=[@"ICXE1wOphgKgcyMoHr0hVHbbJ" mutableCopy];
    objMyGlobals.user.prod_id= prdctid.mutableCopy;
  [objMyGlobals showLoaderIn:self.view];
    if([appDelegateTemp checkInternetConnection]==true)
    {
        [objMyGlobals.user RemoveFromWishList:^(NSString *str, int status)
         {
            if(status==1){
                 NSLog(@"WishList Remove Succesfully");
                  [objMyGlobals hideLoader:self.view];
                  [self getWishList];
                 [objMyGlobals hideLoader:self.view];
            }
            else
             {
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
//For Display Cart Data.
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
//Clear All Wish List Data.
- (IBAction)ClearWishListData:(id)sender {
    [self ClearWishList];
}
- (IBAction)rightMenuTapped:(id)sender {
    [sender addTarget:self action:@selector(presentRightMenuViewController:) forControlEvents:UIControlEventTouchUpInside];
}
@end
