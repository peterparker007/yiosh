//
//  DEMORightMenuViewController.m
//  ZapFashion
//
//  Created by bhumesh on 9/8/17.
//  Copyright © 2017 bhumesh. All rights reserved.

#import "DEMOLeftMenuViewController.h"
#import "CategoryTblVC.h"
#import "ViewController.h"
#import "OrderHistoryVC.h"
#import "AppDelegate.h"
#import "WishListVC.h"
#import "SettingsVC.h"
#import "NotificationHistoryVC.h"
#import "MyAccountVC.h"
#import "NewDashboard.h"
#import "AppDelegate.h"
#import "ThirdDashboard.h"
#import "SettingsDynamicVC.h"
#import "DetailsSettingsVC.h"


@interface DEMOLeftMenuViewController ()
{
    NSMutableArray *arrTitles;
    NSMutableArray *arrImages;
    BOOL isProfileImageSet;
    AppDelegate *appSharedObj;
    NSArray *paths;
    NSString *documentsDirectory;
    NSString *path;
    NSMutableDictionary *savedValue;
}

@property (strong, readwrite, nonatomic) UITableView *tableView;

@end

@implementation DEMOLeftMenuViewController

+(DEMOLeftMenuViewController *)shareInstance {
    static DEMOLeftMenuViewController *objLeftMenu = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        objLeftMenu = [[self alloc] init];
        // Do any other initialisation stuff here
    });
    return objLeftMenu;
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    isProfileImageSet=false;
    appSharedObj = (AppDelegate *)[[UIApplication sharedApplication]delegate];
   paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
  documentsDirectory = [paths objectAtIndex:0];
    path = [documentsDirectory stringByAppendingPathComponent:@"Data.plist"];
    savedValue = [[NSMutableDictionary alloc] initWithContentsOfFile: path];
    arrTitles=[[NSMutableArray alloc]init];
//    arrTitles = @[@"Home", @"Category                     >",@"My Account" ,@"Order History",@"Wishlist",@"Notification History", @"Contact Us",@"Settings                     >",@"NewDashboard",@"ThirdDashboard"];
//    arrImages = @[@"home", @"category",@"ic_user", @"order_history", @"wishlist",@"notification",  @"contact_us",
//                  @"setting",@"home",@"home"];
 
    self.tableView = ({
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0 ,320.0 ,self.view.frame.size.height) style:UITableViewStylePlain];
        tableView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleWidth;
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.opaque = NO;
       //  [_btnSignUp setBackgroundColor:[self colorWithHexString:[savedValue valueForKey:@"signup_btn_col"]]];
        tableView.backgroundColor = [self colorWithHexString:[savedValue valueForKey:@"drawer_bg_col"]];
        [tableView setSeparatorColor:[self colorWithHexString:[savedValue valueForKey:@"mb_drw_border_col"]]];
        tableView.backgroundView = nil;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.bounces = NO;
        tableView;
    });
   
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
-(void)viewWillAppear:(BOOL)animated
{
     [self GetMenuData];
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(20, 10, 172, 150)];
    UIImageView *imageView=[[UIImageView alloc]init];
    UILabel *lblName=[[UILabel alloc]init];
    UIView *whiteDivider =[[UIView alloc]init];
    
    //    AsyncImageView *imageView=[[AsyncImageView alloc]init];
//    if(IS_IPAD)
//    {
//        imageView = [[UIImageView alloc] initWithFrame:CGRectMake(110, 20, 90 , 90)];
//        whiteDivider = [[UIImageView alloc] initWithFrame:CGRectMake(110, 40, 90 , 90)];
//    }
//    else
//    {
    NSLog(@"%@",self);
    imageView = [[UIImageView alloc] initWithFrame:CGRectMake((60*self.view.frame.size.width)/320, 30, (60*self.view.frame.size.width)/320, (60*self.view.frame.size.height)/568)];
    [imageView setBackgroundColor:[UIColor whiteColor]];
    lblName=[[UILabel alloc]initWithFrame:CGRectMake(imageView.frame.origin.x/2, 95, (120*self.view.frame.size.width)/320, 60)];
    lblName.numberOfLines = 0;
    
    whiteDivider = [[UIView alloc] initWithFrame:CGRectMake(0, 150, self.tableView.frame.size.width, 1)];
    //whiteDivider.backgroundColor = [UIColor whiteColor];
   [whiteDivider setBackgroundColor:[self colorWithHexString:[savedValue valueForKey:@"mb_drw_border_col"]]];
    lblName.textColor=[UIColor whiteColor];
    lblName.backgroundColor=[UIColor clearColor];
    lblName.text=[NSString stringWithFormat:@"%@ %@", [appSharedObj.localDataDic objectForKey:@"firstname"], [appSharedObj.localDataDic objectForKey:@"lastname"]];
    lblName.textAlignment=NSTextAlignmentCenter;
    
    NSString *string1=[[appSharedObj.localDataDic objectForKey:@"firstname"] substringToIndex:1];
    NSString *string2=[[appSharedObj.localDataDic objectForKey:@"lastname"] substringToIndex:1];
    NSString *string = [string1 stringByAppendingString: string2];
    
    
    UIImage *img=[self imageFromString:string font:[UIFont systemFontOfSize:20] size:CGSizeMake(50, 50)];
     imageView.image=img;
    imageView.layer.cornerRadius = imageView.frame.size.height/2;
    imageView.layer.masksToBounds = YES;
    [imageView.layer setBorderColor: [[UIColor blackColor] CGColor]];
    [imageView.layer setBorderWidth: 2.0];
    headerView.backgroundColor = [UIColor lightGrayColor];
    // whiteDivider.backgroundColor = [UIColor whiteColor];
    [headerView addSubview:lblName];
    [headerView addSubview:whiteDivider];
    [headerView addSubview:imageView];
    // [headerView addSubview:lblName];
    
    self.tableView.tableHeaderView = headerView;
    // ---Screen of menu name and dp in footer View-----
    
    
//    UIView *FotterView = [[UIView alloc] initWithFrame:CGRectMake(40, 10, 172, 150)];
//    UIButton *btnlogout=[[UIButton alloc]init];
//    UILabel *lbllogout=[[UILabel alloc]init];
    
    
    
    //    AsyncImageView *imageView=[[AsyncImageView alloc]init];
//    if(IS_IPAD)
//    {
//        btnlogout = [[UIButton alloc] initWithFrame:CGRectMake(110, 20, 90 , 90)];
//        
//    }
//    else
//    {
  //      btnlogout = [[UIButton alloc] initWithFrame:CGRectMake(30, 20, 40, 40)];
 //       lbllogout=[[UILabel alloc]initWithFrame:CGRectMake(24, 50, 140, 40)];
   // }
    
//    UIImage *buttonImage=[UIImage imageNamed:@"logout"];
//    [btnlogout setBackgroundImage:buttonImage forState:UIControlStateNormal];
//    [btnlogout addTarget:self action:@selector(btnlogouttapped:) forControlEvents:UIControlEventTouchUpInside];
//    lbllogout.text=@"Logout";
//    lbllogout.textColor=[UIColor blackColor];
//    
//    FotterView.backgroundColor = [UIColor clearColor];
//    // whiteDivider.backgroundColor = [UIColor whiteColor];
//    
//    [FotterView addSubview:btnlogout];
//    [FotterView addSubview:lbllogout];
//    self.tableView.tableFooterView = FotterView;
    
    
    [self.view addSubview:self.tableView];
}
-(void)GetMenuData
{
    Globals *objMyGlobals;
    objMyGlobals=[Globals sharedManager];
     arrTitles=[[NSMutableArray alloc]init];
    arrImages=[[NSMutableArray alloc]init];
    if([appSharedObj checkInternetConnection]==true)
    {
      //  [objMyGlobals showLoaderIn:self.view];
        [objMyGlobals.user GetMenuData:^(NSString *str, int status)
         {
             if(status==1)
             {               //  [objMyGlobals hideLoader:self.view];               
                
                 for(int i=0;i<appSharedObj.ArrMenuItems.count;i++)
                 {
                     NSMutableDictionary *Parent=[[NSMutableDictionary alloc]initWithDictionary:[appSharedObj.ArrMenuItems objectAtIndex:i]];
                     [arrTitles addObject:[Parent objectForKey:@"menu_name"]];
                     [arrImages addObject:[Parent objectForKey:@"icon"]];
                     
                 }
                 [self.tableView reloadData];
                 
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
- (UIImage *)imageFromString:(NSString *)string font:(UIFont *)font size:(CGSize)size
    {
        UIGraphicsBeginImageContextWithOptions(size, NO, 0);
        NSInteger *x;
        
        
#ifdef __IPHONE_7_0
        
        [string drawInRect:CGRectMake(size.width/2-11, size.height/2-11, 100, 100) withAttributes: @{NSFontAttributeName: font}];
#else
        [string drawInRect:renderingRect withFont:font lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentCenter];
#endif
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        return image;
    }

#pragma mark -
#pragma mark UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self setLeftmenuItems:indexPath.row];
}

-(void) setLeftmenuItems:(NSInteger)tag
{ UIStoryboard *storyboard = [UIStoryboard storyboardWithName: @"Main" bundle:nil];
    if(self.sideMenuViewController==nil)
    {
        return;
    }
    else if ([[[appSharedObj.ArrMenuItems objectAtIndex:tag] valueForKey:@"is_cms"] isEqualToString:@"1"])
    {
        UIStoryboard *objStoryboard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
        DetailsSettingsVC *newView = (DetailsSettingsVC *)[objStoryboard instantiateViewControllerWithIdentifier:@"DetailsSettingsVC"];
        newView.strTitle=[[appSharedObj.ArrMenuItems objectAtIndex:tag]valueForKey:@"menu_name"];
        newView.strContents=[[appSharedObj.ArrMenuItems objectAtIndex:tag]valueForKey:@"content"];
         UINavigationController *mainNavigation = (UINavigationController *) [self.sideMenuViewController contentViewController];
        [mainNavigation pushViewController:newView animated:YES];
        [self.sideMenuViewController hideMenuViewController];
       
    }
    else if ([[[appSharedObj.ArrMenuItems objectAtIndex:tag] valueForKey:@"child"]  isEqualToString:@"1"])
    {
        Globals *objMyGlobals;
        objMyGlobals=[Globals sharedManager];
        objMyGlobals.user.Menu_id=[[appSharedObj.ArrMenuItems objectAtIndex:tag] valueForKey:@"id"];
        SettingsDynamicVC *ObjSettingsVC = (SettingsDynamicVC *)[storyboard instantiateViewControllerWithIdentifier:@"SettingsDynamicVC"];
        ObjSettingsVC.strTitle=[[appSharedObj.ArrMenuItems objectAtIndex:tag]valueForKey:@"menu_name"];
     
        UINavigationController *mainNavigation = (UINavigationController *) [self.sideMenuViewController contentViewController];
        [mainNavigation pushViewController:ObjSettingsVC animated:YES];
        [self.sideMenuViewController hideMenuViewController];
    }
    else
    {
   
    NSString *itemname=[arrTitles objectAtIndex:tag];
 
    NSArray *items =  @[@"Home", @"Category",@"My Account" ,@"Order History",@"WishList",@"Notification History", @"Contact Us",@"Settings",@"NewDashboard",@"ThirdDashboard"];
    int item = (int)[items indexOfObject:itemname];
    switch (item) {
        case 0: {
            
            ViewController *ObjViewController = (ViewController *)[storyboard instantiateViewControllerWithIdentifier:@"ViewController"];
            
            UINavigationController *mainNavigation = (UINavigationController *) [self.sideMenuViewController contentViewController];
            
            [mainNavigation pushViewController:ObjViewController animated:YES];
            [self.sideMenuViewController hideMenuViewController];
            
           
        }
            break;
        case 1: {
            CategoryTblVC *ObjCategoryTblVC = (CategoryTblVC *)[storyboard instantiateViewControllerWithIdentifier:@"CategoryTblVC"];
            
            
            UINavigationController *mainNavigation = (UINavigationController *) [self.sideMenuViewController contentViewController];
            
            [mainNavigation pushViewController:ObjCategoryTblVC animated:YES];
            [self.sideMenuViewController hideMenuViewController];
            
        }
            break;
        case 2: {
            MyAccountVC *ObjAccountVC = (MyAccountVC *)[storyboard instantiateViewControllerWithIdentifier:@"MyAccountVC"];
            
            
            UINavigationController *mainNavigation = (UINavigationController *) [self.sideMenuViewController contentViewController];
            
            [mainNavigation pushViewController:ObjAccountVC animated:YES];
            [self.sideMenuViewController hideMenuViewController];
            
        }
            break;
        case 3: {
            OrderHistoryVC *ObjCategoryTblVC = (OrderHistoryVC *)[storyboard instantiateViewControllerWithIdentifier:@"OrderHistoryVC"];
            
            
            UINavigationController *mainNavigation = (UINavigationController *) [self.sideMenuViewController contentViewController];
            
            [mainNavigation pushViewController:ObjCategoryTblVC animated:YES];
            [self.sideMenuViewController hideMenuViewController];
            
        }
            break;
      
        case 4: {
            WishListVC *ObjCategoryTblVC = (WishListVC *)[storyboard instantiateViewControllerWithIdentifier:@"WishListVC"];
            
            
            UINavigationController *mainNavigation = (UINavigationController *) [self.sideMenuViewController contentViewController];
            
            [mainNavigation pushViewController:ObjCategoryTblVC animated:YES];
            [self.sideMenuViewController hideMenuViewController];
           
        }
            break;
        case 5: {
         
            NotificationHistoryVC *ObjNotificationHistoryVC = (NotificationHistoryVC *)[storyboard instantiateViewControllerWithIdentifier:@"NotificationHistoryVC"];
            
            
            UINavigationController *mainNavigation = (UINavigationController *) [self.sideMenuViewController contentViewController];
            
            [mainNavigation pushViewController:ObjNotificationHistoryVC animated:YES];
            [self.sideMenuViewController hideMenuViewController];
          
        }
            break;
        case 6:
        {
            
        }
            break;
        case 7:{
           
            
        }
            break;
        case 8:{
            NewDashboard *ObjSettingsVC = (NewDashboard *)[storyboard instantiateViewControllerWithIdentifier:@"NewDashboard"];
            
            
            UINavigationController *mainNavigation = (UINavigationController *) [self.sideMenuViewController contentViewController];
            
            [mainNavigation pushViewController:ObjSettingsVC animated:YES];
            [self.sideMenuViewController hideMenuViewController];
            
        }
            break;
        case 9:{
            ThirdDashboard *ObjSettingsVC = (ThirdDashboard *)[storyboard instantiateViewControllerWithIdentifier:@"ThirdDashboard"];
            
            
            UINavigationController *mainNavigation = (UINavigationController *) [self.sideMenuViewController contentViewController];
            
            [mainNavigation pushViewController:ObjSettingsVC animated:YES];
            [self.sideMenuViewController hideMenuViewController];
            
        }
            break;
            
        default:
            break;
    }
    }
}



#pragma mark -
#pragma mark UITableView Datasource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
        return 40;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    return arrTitles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.backgroundColor = [UIColor clearColor];
        
        cell.textLabel.textColor = [self colorWithHexString:[savedValue valueForKey:@"drawer_text_col"]];
        cell.textLabel.highlightedTextColor = [UIColor lightGrayColor];
        cell.selectedBackgroundView = [[UIView alloc] init];
    }
    UIFont *myFont = [ UIFont fontWithName: @"Arial" size: 16.0 ];
    cell.textLabel.font  = myFont;
    cell.textLabel.text = arrTitles[indexPath.row];
  
//    NSURL *url = [NSURL URLWithString:[savedValue valueForKey:@"search_logo"]];
//    NSData *data = [NSData dataWithContentsOfURL : url];
//    cell.imageView.image = [UIImage imageWithData:data];
  
    
    NSURL *url = [NSURL URLWithString:[arrImages objectAtIndex:indexPath.row]];
    
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
    [task resume];
  //  cell.imageView.image = [UIImage imageNamed:arrImages[indexPath.row]];
   
    if(indexPath.row>0)
    {
        
        UIView *whiteDivider = [[UIView alloc] initWithFrame:CGRectMake(0, 1, cell.bounds.size.width, 1)];
        [whiteDivider setBackgroundColor:[self colorWithHexString:[savedValue valueForKey:@"mb_drw_border_col"]]];
      //  whiteDivider.backgroundColor = [UIColor blackColor];
        whiteDivider.alpha=0.5;
        [cell.contentView addSubview:whiteDivider];
    }
    if (indexPath.row==arrImages.count-1) {
        UIView *whiteDivider;      
        [whiteDivider setBackgroundColor:[self colorWithHexString:[savedValue valueForKey:@"mb_drw_border_col"]]];
        whiteDivider.alpha=0.5;
        [cell.contentView addSubview:whiteDivider];
        
    }
    
    //    UIView *whiteDivider = [[UIView alloc] initWithFrame:CGRectMake(0, 5, cell.bounds.size.width, 1)];
    //    whiteDivider.backgroundColor = [UIColor whiteColor];
    //    [cell.contentView addSubview:whiteDivider];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}


//- (UIView *)tableView : (UITableView *)tableView viewForHeaderInSection : (NSInteger) section {
//    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
//    imgView.image = [UIImage imageNamed:@"sponsor"];
//
//    return imgView;
//}
@end
