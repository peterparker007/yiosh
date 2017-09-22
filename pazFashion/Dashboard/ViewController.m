//
//  ViewController.m
//  ZapFashion
//
//  Created by bhumesh on 6/1/17.
//  Copyright © 2017 bhumesh. All rights reserved.
//

#import "ViewController.h"
#import "DEMOLeftMenuViewController.h"
#import "SideMenu.h"
#import "AppDelegate.h"
#import "ViewControllerTblCell.h"
#import "CheckoutVC.h"
#import "Globals.h"
#import "CategoryDetailsVC.h"
#import "CacheController.h"
#import "ItemDetailVC.h"
#import "UIBarButtonItem+Badge.h"
@interface ViewController ()
{
    NSMutableDictionary *savedValue;
}
@end

@implementation ViewController
@synthesize tblvw,tempBadge;
- (void)viewDidLoad {
    [super viewDidLoad];
  appDelegateTemp = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    NSLog(@"%@",self.navigationController.viewControllers);
   
    [self.navigationController setNavigationBarHidden:YES];
    
 /* self.navigationController.navigationItem.title=@"Dashboard";   
  self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
//    [self.navigationController.navigationBar setTitleTextAttributes:
//     @{NSForegroundColorAttributeName:[UIColor yellowColor]}];
//    self.navigationController.navigationBar.topItem.title  = @"Dashboard";
//    self.title = @"Dashboard";
//    self.navigationItem.title = @"Dashboard";
    

    self.navigationController.navigationBar.translucent = NO;
    UIToolbar *tools = [[UIToolbar alloc]
                        initWithFrame:CGRectMake(0.0f, 0.0f, 70.0, 44.01f)]; // 44.01 shifts it up 1p.01x for some reason
    tools.clearsContextBeforeDrawing = NO;
    tools.clipsToBounds = NO;
    tools.tintColor = [UIColor colorWithWhite:0.205f alpha:0.0f]; // closest I could get by eye to black, translucent style.
    // anyone know how to get it perfect?
    tools.barStyle = -1; // clear background
    NSMutableArray *buttons = [[NSMutableArray alloc] init];
    
   _btnCart.frame = CGRectMake(100,100,25,25);
    _btnSearch.frame= CGRectMake(200,100,25,25);
   
    UIBarButtonItem *navLeftButton = [[UIBarButtonItem alloc] initWithCustomView:_btnCart];
    navLeftButton.badgeValue=[NSString stringWithFormat:@"%@",appDelegateTemp.TotalCartItem];
    UIBarButtonItem *navLeftButton1 = [[UIBarButtonItem alloc] initWithCustomView:_btnSearch];
        [buttons addObject:navLeftButton];
    [buttons addObject:navLeftButton1];
    
    [tools setItems:buttons animated:NO];
    UIBarButtonItem *twoButtons = [[UIBarButtonItem alloc] initWithCustomView:tools];
    self.navigationItem.rightBarButtonItem = twoButtons;
    
    
    
    
    UIToolbar *tools1 = [[UIToolbar alloc]
                        initWithFrame:CGRectMake(0.0f, 0.0f, 100.0, 44.01f)]; // 44.01 shifts it up 1p.01x for some reason
    tools1.clearsContextBeforeDrawing = NO;
    tools1.clipsToBounds = NO;
    tools1.tintColor = [UIColor colorWithWhite:0.205f alpha:0.0f]; // closest I could get by eye to black, translucent style.
    // anyone know how to get it perfect?
    tools1.barStyle = -1; // clear background
    NSMutableArray *buttons1 = [[NSMutableArray alloc] init];
    
    _btnmenu2.frame = CGRectMake(10,10,50,50);
    _Logo.frame= CGRectMake(300,200,_Logo.frame.size.width,_Logo.frame.size.height);
     _HeaderTitle.frame= CGRectMake(100,200,_HeaderTitle.frame.size.width,_HeaderTitle.frame.size.width);
    UIBarButtonItem *navRightButton = [[UIBarButtonItem alloc] initWithCustomView:_Logo];
    UIBarButtonItem *navRightButton1 = [[UIBarButtonItem alloc] initWithCustomView:_btnmenu2];
    UIBarButtonItem *navRightButton2 = [[UIBarButtonItem alloc] initWithCustomView:_HeaderTitle];
    
 

    
    [buttons1 addObject:navRightButton];
    [buttons1 addObject:navRightButton1];
 //      [buttons1 addObject:navRightButton2];
    [tools1 setItems:buttons1 animated:NO];
    UIBarButtonItem *twoButtons1 = [[UIBarButtonItem alloc] initWithCustomView:tools1];
    self.navigationItem.leftBarButtonItem = twoButtons1;*/
 
      // self.navigationItem.rightBarButtonItem = navLeftButton1;
   // self.navigationItem.leftBarButtonItem.badgeValue = @"1";
    /**************** For Serach bar Text color  ****************/
   
   
    
  //  tableData=[[NSMutableArray alloc]initWithObjects:@"image2",@"image3",@"image4",@"image5",@"image6",@"image7", nil];
    tempMoveData=[[NSMutableArray alloc]initWithObjects:@"11",@"13",@"27",@"14",@"26",@"16", nil];
    [self GetData];
  //  [tblvw reloadData];
    [_btnmenu setTintColor:[UIColor redColor]];
    [self MenuButttonTapped:_btnmenu];
    [self rightMenuTapped:_btnmenu2];
    [self DisplayBadge];
    // Do any additional setup after loading the view, typically from a nib.
}
-(void)viewWillDisappear:(BOOL)animated
{
    self.navigationItem.title=@"";
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
}

-(void)GetData
{
    Globals *objMyGlobals;
    objMyGlobals=[Globals sharedManager];
    objMyGlobals.user.template_no=[@"1" mutableCopy];
    if([appDelegateTemp checkInternetConnection]==true)
    {
     //   [objMyGlobals showLoaderIn:self.view];
        [objMyGlobals.user GetMobileBanner:^(NSString *str, int status)
         {
             
             if(status==1)
             {
                 [objMyGlobals hideLoader:self.view];
                 tableData=appDelegateTemp.ArrImageBanner;
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
-(void)viewWillAppear:(BOOL)animated
{
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
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"Data.plist"];
    savedValue = [[NSMutableDictionary alloc] initWithContentsOfFile: path];
    [_TopView setBackgroundColor: [self colorWithHexString:[savedValue valueForKey:@"header_color"]]];
    [_HeaderTitle setTextColor:[self colorWithHexString:[savedValue valueForKey:@"header_text_color"]]];
    [self SetConfigForTopView];
    [self.navigationController setNavigationBarHidden:YES];
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
    tempBadge.frame=[objMyGlobals currentDevicePositions:CGRectMake( frame1.origin.x+15, frame1.origin.y-7, 30, 30) vwRect:self.view.frame];
    frame1=[objMyGlobals getXYPositions:[savedValue valueForKey:@"page_title_position"]];
    _HeaderTitle.frame=[objMyGlobals currentDevicePositions:CGRectMake(frame1.origin.x, frame1.origin.y, 105, 21) vwRect:self.view.frame];
    frame1=[objMyGlobals getXYPositions:[savedValue valueForKey:@"logo_position"]];
    _Logo.frame=[objMyGlobals currentDevicePositions:CGRectMake(frame1.origin.x, frame1.origin.y, 77, 18) vwRect:self.view.frame];
    fileUrl =[NSURL URLWithString:[savedValue valueForKey:@"search_logo"]];
    
    fileData =[NSData dataWithContentsOfURL:fileUrl];
    
    dispatch_async(dispatch_get_main_queue(), ^ {
        
        
        [_btnSearch setImage:[UIImage imageWithData:fileData] forState:UIControlStateNormal];
        
    });
    frame1=[objMyGlobals getXYPositions:[savedValue valueForKey:@"search_logo_position"]];
    _btnSearch.frame=[objMyGlobals currentDevicePositions:CGRectMake(frame1.origin.x, frame1.origin.y, 25, 25) vwRect:self.view.frame];
    
    _btnmenu2.frame=[objMyGlobals currentDevicePositions:CGRectMake(284, 3, 33, 50) vwRect:self.view.frame];
    _searchBar.frame=[objMyGlobals currentDevicePositions:CGRectMake(0, 0, 381, 50) vwRect:self.view.frame];
    
//    CGRect frame = tblvw.frame;
//    frame.origin.y= _TopView.frame.size.height+1;
//    frame.size.width=_TopView.frame.size.width;
//    frame.size.height=self.view.frame.size.height-_TopView.frame.size.height;
//    tblvw.frame=frame;
    
    CGRect frame= _divder.frame;
    frame.origin.y= _TopView.frame.size.height;
    frame.size.width= _TopView.frame.size.width;
    _divder.frame=frame;
}

-(void)viewDidAppear:(BOOL)animated
{
    
    [self DisplayBadge]; 
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
    
   // DEMOLeftMenuViewController *leftMenuViewController = [DEMOLeftMenuViewController shareInstance];
   // [leftMenuViewController MessageCount];
    
    [sender addTarget:self action:@selector(presentLeftMenuViewController:) forControlEvents:UIControlEventTouchUpInside];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"Dashboard";
    
    ViewControllerTblCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[ViewControllerTblCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    NSString *cacheKey = [NSString stringWithFormat:@"%ld%ld", (long)indexPath.row, (long)indexPath.section];
//    NSData *cachedObject = [[CacheController sharedInstance] getCacheForKey:cacheKey];
//    
//    if (cachedObject != nil) {
//        UIImage *img=[UIImage imageWithData:cachedObject];
//        [cell.imgView setImage:img];
//        // [[cell textLabel] setText:@"Got object from cache!"];
//    }
//    
//    else {
    
        [cell downloadFile:[NSURL URLWithString:[tableData [indexPath.row]valueForKey:@"image"]]
              forIndexPath:indexPath cacheKey:cacheKey];
        
   // }
    
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    float height=[[tableData [indexPath.row]valueForKey:@"height"]floatValue];
    height=height*(self.view.frame.size.height/675);
    return height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Globals *objMyGlobals;
    objMyGlobals=[Globals sharedManager];
    UIStoryboard *objStoryboard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    if([[tableData [indexPath.row]valueForKey:@"enum"]isEqualToString: @"category" ])
    {
    objMyGlobals.user.CatID=[tableData [indexPath.row]valueForKey:@"value"];
    
    [appDelegateTemp.ProductData removeAllObjects];
    CategoryDetailsVC *newView = (CategoryDetailsVC *)[objStoryboard instantiateViewControllerWithIdentifier:@"CategoryDetailsVC"];
    [self.navigationController pushViewController:newView animated:YES];
    }
    else if([[tableData [indexPath.row]valueForKey:@"enum"]isEqualToString: @"product"])
    {
        ItemDetailVC *newView = (ItemDetailVC *)[objStoryboard instantiateViewControllerWithIdentifier:@"ItemDetailVC"];
        objMyGlobals.user.prod_id=[tableData [indexPath.row] valueForKey:@"value"];
         [self.navigationController pushViewController:newView animated:YES];
    }
    else if ([[tableData [indexPath.row]valueForKey:@"enum"]isEqualToString: @"advanced_product"])
    {
        [self GetData:[tableData [indexPath.row]valueForKey:@"value"]];
    }

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
        tempBadge.layer.cornerRadius = tempBadge.frame.size.width/2;
        tempBadge.layer.masksToBounds = YES;
        tempBadge.text=[NSString stringWithFormat:@"%@",appDelegateTemp.TotalCartItem];
        tempBadge.textColor=[UIColor whiteColor];
       // [self.TopView addSubview:tempBadge];
    }
    else
    {
        tempBadge.hidden=true;
    }
}
- (IBAction)SearchTapped:(id)sender {
    [_searchBar setBackgroundColor:[UIColor clearColor]];
    [_searchBar setBarTintColor:[UIColor clearColor]];
    [self.searchBar setSearchFieldBackgroundImage:[UIImage imageNamed:@"Transperentvw"] forState:UIControlStateNormal];
    for (UIView *subView in self.searchBar.subviews)
    {
        for (UIView *secondLevelSubview in subView.subviews){
            if ([secondLevelSubview isKindOfClass:[UITextField class]])
            {
                UITextField *searchBarTextField = (UITextField *)secondLevelSubview;
                //set font color here
               
                searchBarTextField.textColor = [self colorWithHexString:[savedValue valueForKey:@"header_text_color"]];
                
                break;
            }
        }
    }
    if([appDelegateTemp.strMenuType isEqualToString:@"Right"])
    {
        _btnmenu2.hidden=true;
    }
    else
    {
        _btnmenu.hidden=true;
    }
    _btnSearch.hidden=true;
    _btnCart.hidden=true;
    _HeaderTitle.hidden=true;
    tempBadge.hidden=true;
      _Logo.hidden=true;
    _searchBar.layer.zPosition=1;
    _searchBar.hidden=false;
    _searchBar.showsCancelButton = YES;
}
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    if([appDelegateTemp.strMenuType isEqualToString:@"Right"])
    {
        _btnmenu2.hidden=false;
    }
    else if([appDelegateTemp.strMenuType isEqualToString:@"Left"])
    {
        _btnmenu.hidden=false;
    }
    _btnSearch.hidden=false;
    _btnCart.hidden=false;
    _HeaderTitle.hidden=false;
    tempBadge.hidden=false;
    _Logo.hidden=false;
 
    [searchBar resignFirstResponder];
    [searchBar setShowsCancelButton:NO animated:YES];
    [searchBar setHidden:true];
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    
    [self.view endEditing:YES];
     Globals *objMyGlobals;
     objMyGlobals=[Globals sharedManager];
    
    objMyGlobals.user.searchKey=[searchBar.text mutableCopy];
    if([appDelegateTemp checkInternetConnection]==true)
    {
      // [objMyGlobals showLoaderIn:self.view];
        [objMyGlobals.user SearchData:^(NSString *str, int status)
         {
            
             if(status==1)
             {
                 [searchBar resignFirstResponder];
                 searchBar.text=@"";
                 [searchBar setShowsCancelButton:NO animated:YES];
                 [searchBar setHidden:true];
                 if([appDelegateTemp.strMenuType isEqualToString:@"Right"])
                 {
                     _btnmenu2.hidden=false;
                 }
                 else if([appDelegateTemp.strMenuType isEqualToString:@"Left"])
                 {
                     _btnmenu.hidden=false;
                 }
                 _btnSearch.hidden=false;
                 _btnCart.hidden=false;
                 _HeaderTitle.hidden=false;
                 tempBadge.hidden=false;
                 _Logo.hidden=false;
              
                  objMyGlobals.isSearched=true;
               [objMyGlobals hideLoader:self.view];
        UIStoryboard *objStoryboard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
        CategoryDetailsVC *newView = (CategoryDetailsVC *)[objStoryboard instantiateViewControllerWithIdentifier:@"CategoryDetailsVC"];
        [self.navigationController pushViewController:newView animated:YES];
                 
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
/*Get Data From Server For Advanvance Products*/
-(void)GetData:(NSString*)type
{
    Globals *objMyGlobals;
    objMyGlobals=[Globals sharedManager];
    if(![objMyGlobals.spinner isDescendantOfView:self.view])
    {
   //     [objMyGlobals showLoaderIn:self.view];
    }
    //  objMyGlobals.user.userid=[appDelegateTemp.localDataDic objectForKey:@"userid"];
    objMyGlobals.user.type=[type mutableCopy];
    if([appDelegateTemp checkInternetConnection]==true)
    {[objMyGlobals.user GetAdvanceProduct:^(NSString *str, int status){
        if(status==1)
        {
            [objMyGlobals Displaymsg:self.view msg:str];
            [objMyGlobals hideLoader:self.view];
            //  [tblvw reloadData];
            UIStoryboard *objStoryboard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
              objMyGlobals.isSearched=true;
            CategoryDetailsVC *newView = (CategoryDetailsVC *)[objStoryboard instantiateViewControllerWithIdentifier:@"CategoryDetailsVC"];
            newView.strType=type;
            appDelegateTemp.ProductData=appDelegateTemp.AdvanceProductData;
             [self.navigationController pushViewController:newView animated:YES];
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

- (IBAction)rightMenuTapped:(id)sender {
      [sender addTarget:self action:@selector(presentRightMenuViewController:) forControlEvents:UIControlEventTouchUpInside];
}

@end
