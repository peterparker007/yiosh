//
//  CategoryTblVC.m
//  ZapFashion
//
//  Created by bhumesh on 6/2/17.
//  Copyright © 2017 bhumesh. All rights reserved.
//

#import "CategoryTblVC.h"
#import "DEMOLeftMenuViewController.h"
#import "CategorytblvwCell.h"
#import "CategoryDetailsVC.h"
#import "CategoryBrandsVC.h"
#import "Globals.h"
#import "CacheController.h"
#import "AppDelegate.h"
#import "CheckoutVC.h"
@interface CategoryTblVC ()
{
    BOOL isTapped;
    UIButton *button;
    NSMutableDictionary *savedValue;
    AppDelegate  *appSharedObj;
}
@end

@implementation CategoryTblVC
- (void)viewDidLoad {
    [super viewDidLoad];
    sectionTitleArray=[[NSMutableArray alloc]init];
    appSharedObj = (AppDelegate *)[[UIApplication sharedApplication]delegate];
     filteredContentList = [[NSMutableArray alloc] init];
     appDelegateTemp = (AppDelegate *)[[UIApplication sharedApplication]delegate];
     [self DisplayBadge];
//Set Searchbar TextField Text Color
    for (UIView *subView in self.searchBar.subviews)
    {
        for (UIView *secondLevelSubview in subView.subviews){
            if ([secondLevelSubview isKindOfClass:[UITextField class]])
            {
                UITextField *searchBarTextField = (UITextField *)secondLevelSubview;
                
                //set font color here
                searchBarTextField.textColor = [UIColor whiteColor];
                
                break;
            }
        }
    }
    
    [self initialization];
}
-(void)viewWillAppear:(BOOL)animated
{
    if([appDelegateTemp.strMenuType isEqualToString:@"tab"])
    {
        _btnMenu2.hidden=true;
        _btnMenu.hidden=true;
        
    }
    else if([appDelegateTemp.strMenuType isEqualToString:@"Right"])
    {
        _btnMenu2.hidden=false;
        _btnMenu.hidden=true;
    }  [self.navigationController setNavigationBarHidden:YES];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"Data.plist"];
  savedValue = [[NSMutableDictionary alloc] initWithContentsOfFile: path];
 [_TopView setBackgroundColor: [self colorWithHexString:[savedValue valueForKey:@"header_color"]]];
    [_HeaderTitle setTextColor:[self colorWithHexString:[savedValue valueForKey:@"header_text_color"]]];
      [_tblvw setBackgroundColor:[self colorWithHexString:[savedValue valueForKey:@"cat_card_bg_col"]]];
     [_tblvw setSeparatorColor:[self colorWithHexString:[savedValue valueForKey:@"cat_border_col"]]];
    [self SetConfigForTopView];
    
}
-(void)SetConfigForTopView
{
    Globals *objMyGlobals;
    objMyGlobals=[Globals sharedManager];
    _TopView.frame=[objMyGlobals currentDevicePositions:CGRectMake(0, 0, 381, 50) vwRect:self.view.frame];
 //   _btnMenu.frame=[objMyGlobals currentDevicePositions:CGRectMake(0, 0, 33, 50) vwRect:self.view.frame];
    
    CGRect frame1=[objMyGlobals getXYPositions:[savedValue valueForKey:@"cart_logo_position"]];
    
    NSURL *fileUrl =[NSURL URLWithString:[savedValue valueForKey:@"bag_logo"]];
    
    NSData *fileData =[NSData dataWithContentsOfURL:fileUrl];
    
    dispatch_async(dispatch_get_main_queue(), ^ {
        
        
        [_btnCart setImage:[UIImage imageWithData:fileData] forState:UIControlStateNormal];
        
    });
    _btnCart.frame=[objMyGlobals currentDevicePositions:CGRectMake(frame1.origin.x, frame1.origin.y, 25, 25) vwRect:self.view.frame];
    _tempBadge.frame=[objMyGlobals currentDevicePositions:CGRectMake( frame1.origin.x+17, frame1.origin.y-7, 30, 30) vwRect:self.view.frame];
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
    
    _btnMenu2.frame=[objMyGlobals currentDevicePositions:CGRectMake(284, 3, 33, 50) vwRect:self.view.frame];
    _searchBar.frame=[objMyGlobals currentDevicePositions:CGRectMake(0, 0, 381, 50) vwRect:self.view.frame];
    
//    CGRect frame = _tblvw.frame;
//    frame.origin.y= _TopView.frame.size.height+1;
//    frame.size.width=_TopView.frame.size.width;
//    frame.size.height=self.view.frame.size.height-_TopView.frame.size.height;
//    _tblvw.frame=frame;
    
   CGRect frame= _divder.frame;
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
-(void)viewDidAppear:(BOOL)animated
{
    [self DisplayBadge];
}
-(void)initialization
{
      [self MenuButttonTapped:_btnMenu];
      [self rightMenuTapped:_btnMenu2];
    arrayForBool=[[NSMutableArray alloc]init];
    child=[[NSMutableArray alloc]init];
    Globals *objMyGlobals;
    objMyGlobals=[Globals sharedManager];
   [objMyGlobals showLoaderIn:self.view];
    if([appDelegateTemp checkInternetConnection]==true)
    {
    [objMyGlobals.user allCategory:^(NSString *str, int status)
     {
         if(status==1)
         {
        
             if(appSharedObj.CategoryData.count>0)
             {
                 // sectionTitleArray=[[NSArray alloc]initWithObjects:
             
             for(int i=0;i<appSharedObj.CategoryData.count;i++)
             {
                 NSMutableDictionary *Parent=[[NSMutableDictionary alloc]initWithDictionary:[appSharedObj.CategoryData objectAtIndex:i]];
                 [sectionTitleArray addObject:[Parent objectForKey:@"category_name"]];
                [ child addObject:[Parent objectForKey:@"child"]];
                 
                 
             }

            for (int i=0; i<[sectionTitleArray count]; i++) {
                     [arrayForBool addObject:[NSNumber numberWithBool:NO]];
                 }
                 _tblvw.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
                 [_tblvw reloadData];
                 
             }
             [objMyGlobals hideLoader:self.view];
             
        }
         
         else
         {
             [objMyGlobals Displaymsg:self.view msg:@"No Data Found"];
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

- (IBAction)MenuButttonTapped:(id)sender
{
   // DEMOLeftMenuViewController *leftMenuViewController = [DEMOLeftMenuViewController shareInstance];
   
    [sender addTarget:self action:@selector(presentLeftMenuViewController:) forControlEvents:UIControlEventTouchUpInside];
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
        _btnMenu2.hidden=true;
    }
    else
    {
        _btnMenu.hidden=true;
    }
    _btnSearch.hidden=true;
    _btnCart.hidden=true;
    _HeaderTitle.hidden=true;
    _tempBadge.hidden=true;
    _Logo.hidden=true;
    _searchBar.layer.zPosition=1;
    _searchBar.hidden=false;
    _searchBar.showsCancelButton = YES;
}
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    if([appDelegateTemp.strMenuType isEqualToString:@"Right"])
    {
        _btnMenu2.hidden=false;
    }
    else if([appDelegateTemp.strMenuType isEqualToString:@"Left"])
    {
        _btnMenu.hidden=false;
    }
    _btnSearch.hidden=false;
    _btnCart.hidden=false;
    _HeaderTitle.hidden=false;
    _tempBadge.hidden=false;
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
        [objMyGlobals showLoaderIn:self.view];
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
                     _btnMenu2.hidden=false;
                 }
                 else if([appDelegateTemp.strMenuType isEqualToString:@"Left"])
                 {
                     _btnMenu.hidden=false;
                 }
                 _btnSearch.hidden=false;
                 _btnCart.hidden=false;
                 _HeaderTitle.hidden=false;
                 _tempBadge.hidden=false;
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
#pragma mark -
#pragma mark TableView DataSource and Delegate Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger count=0;
        NSMutableArray *arr=[child objectAtIndex:section];
        count = arr.count;
    return count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellid=@"CategorytblvwCell";
    CategorytblvwCell *cell=[tableView dequeueReusableCellWithIdentifier:cellid];
    if (cell==nil) {
        cell=[[CategorytblvwCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellid];
    }
    
    
    BOOL manyCells  = [[arrayForBool objectAtIndex:indexPath.section] boolValue];
    
    /********** If the section supposed to be closed *******************/
    if(!manyCells)
    {
        cell.backgroundColor=[UIColor clearColor];
        
        cell.textLabel.text=@"";
    }
    /********** If the section supposed to be Opened *******************/
    else
    {
        
        
        
      //  cell.lblProductName.text=[NSString stringWithFormat:@"%@ %ld",[sectionTitleArray objectAtIndex:indexPath.section],indexPath.row+1];
          NSMutableArray *arr=[child objectAtIndex:indexPath.section];
        NSMutableDictionary *dict=[arr objectAtIndex:indexPath.row];
         [ cell.lblProductName setTextColor: [self colorWithHexString:[savedValue valueForKey:@"cat_text_col"]]];
        cell.lblProductName.text=[NSString stringWithFormat:@"%@",[dict objectForKey:@"category_name"]];
        cell.backgroundColor=[UIColor clearColor];
      //  cell.imageView.image=[UIImage imageNamed:@"point.png"];
        cell.selectionStyle=UITableViewCellSelectionStyleNone ;
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        cell.imgView.layer.cornerRadius = 17;
        cell.imgView.layer.masksToBounds = YES;
        
       // cell.imgView.image=[UIImage imageNamed:@"Tshirt_Img"];
        
        NSString *cacheKey = [NSString stringWithFormat:@"%ld%ld", (long)indexPath.row, (long)indexPath.section];
        
        [cell downloadFile:[NSURL URLWithString:[dict objectForKey:@"category_image"]]
              forIndexPath:indexPath cacheKey:cacheKey];

        
    }
    cell.textLabel.textColor=[self colorWithHexString:[savedValue valueForKey:@"cat_text_col"]];
    
    /********** Add a custom Separator with cell *******************/
    UIView* separatorLineView = [[UIView alloc] initWithFrame:CGRectMake(15, 40, _tblvw.frame.size.width-15, 1)];
    separatorLineView.backgroundColor = [UIColor blackColor];
    [cell.contentView addSubview:separatorLineView];
    
    return cell;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [sectionTitleArray count];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    /*************** Close the section, once the data is selected ***********************************/
    [arrayForBool replaceObjectAtIndex:indexPath.section withObject:[NSNumber numberWithBool:NO]];
    isTapped=false;
    [_tblvw reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationAutomatic];
    
    NSMutableArray *arr=[child objectAtIndex:indexPath.section];
    NSMutableDictionary *dict=[arr objectAtIndex:indexPath.row];
    NSLog(@"%@",[dict objectForKey:@"category_id"]);
    Globals *objMyGlobals;
    objMyGlobals=[Globals sharedManager];
     [appDelegateTemp.ProductData removeAllObjects];
    objMyGlobals.user.CatID=[dict objectForKey:@"category_id"];
    UIStoryboard *objStoryboard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    CategoryDetailsVC *newView = (CategoryDetailsVC *)[objStoryboard instantiateViewControllerWithIdentifier:@"CategoryDetailsVC"];
    [self.navigationController pushViewController:newView animated:YES];
    
   
//    newView.lblTitle=[dict objectForKey:@"category_name"];
 //   newView.CustID=[dict objectForKey:@"category_id"];
  
   
    
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[arrayForBool objectAtIndex:indexPath.section] boolValue]) {
        return 40;
    }
    return 0;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

#pragma mark - Creating View for TableView Section

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    UIView *sectionView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 180,30)];
    sectionView.tag=section;
    
    UILabel *viewLabel=[[UILabel alloc]initWithFrame:CGRectMake(50, 5, _tblvw.frame.size.width-10, 30)];
   
    viewLabel.backgroundColor=[UIColor clearColor];
    viewLabel.textColor=[self colorWithHexString:[savedValue valueForKey:@"cat_text_col"]];
    viewLabel.font=[UIFont systemFontOfSize:15];
    viewLabel.text=[NSString stringWithFormat:@"%@",[sectionTitleArray objectAtIndex:section]];
    [sectionView addSubview:viewLabel];
    UIImageView *imgView1=[[UIImageView alloc]initWithFrame:CGRectMake(viewLabel.frame.origin.x-40, 5, 30,30)];
    imgView1.layer.cornerRadius = 15;
    imgView1.layer.masksToBounds = YES;
    
    NSString *cacheKey = [NSString stringWithFormat:@"%ld", (long)section];
    dispatch_queue_t dispatchQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_async(dispatchQueue, ^ {
       
            NSURL *ImageURL =[NSURL URLWithString:[[appSharedObj.CategoryData objectAtIndex:section] valueForKey:@"category_image"]];
            
            NSData *fileData =[NSData dataWithContentsOfURL:ImageURL];
            [[CacheController sharedInstance] setCache:fileData forKey:cacheKey];
            
            dispatch_async(dispatch_get_main_queue(), ^ {
                imgView1.image=[UIImage imageWithData:fileData];
                
            });
        
        
    });
  
    
     //imgView1.image=[UIImage imageNamed:@"Tshirt_Img"];
    
  
    UIImageView *imgView=[[UIImageView alloc]initWithFrame:CGRectMake(viewLabel.frame.size.width-20, 10, 25,25)];
    if (isTapped)
    {
        imgView.image=[UIImage imageNamed:@"ic_minus"];
    }
    else
    {
        imgView.image=[UIImage imageNamed:@"ic_plus"];
    }
    [sectionView addSubview:imgView1];
    [sectionView addSubview:imgView];
    /********** Add a custom Separator with Section view *******************/
    UIView* separatorLineView = [[UIView alloc] initWithFrame:CGRectMake(15, 40, _tblvw.frame.size.width-15, 0.5)];
   
    [separatorLineView setBackgroundColor:[self colorWithHexString:[savedValue valueForKey:@"cat_border_col"]]];
    [sectionView addSubview:separatorLineView];
    /********** Add UITapGestureRecognizer to SectionView   **************/
    UITapGestureRecognizer  *headerTapped   = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sectionHeaderTapped:)];
    [sectionView addGestureRecognizer:headerTapped];
    return  sectionView;
}

#pragma mark - Table header gesture tapped

- (void)sectionHeaderTapped:(UITapGestureRecognizer *)gestureRecognizer{
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:gestureRecognizer.view.tag];
    if (indexPath.row == 0) {
        BOOL collapsed  = [[arrayForBool objectAtIndex:indexPath.section] boolValue];
        for (int i=0; i<[sectionTitleArray count]; i++) {
            if (indexPath.section==i) {
                [arrayForBool replaceObjectAtIndex:i withObject:[NSNumber numberWithBool:!collapsed]];
                isTapped = !collapsed;

            }
        }
        [_tblvw reloadSections:[NSIndexSet indexSetWithIndex:gestureRecognizer.view.tag] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
#pragma mark -search Methods
//- (void)searchTableList {
//    NSString *searchString = _searchBar.text;
//    
//    for (NSString *tempStr in sectionTitleArray) {
//        NSComparisonResult result = [tempStr compare:searchString options:(NSCaseInsensitiveSearch|NSDiacriticInsensitiveSearch) range:NSMakeRange(0, [searchString length])];
//        if (result == NSOrderedSame) {
//            [filteredContentList addObject:tempStr];
//        }
//    }
//}
//- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
//    isSearching = YES;
//}
//
//- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
//    NSLog(@"Text change - %d",isSearching);
//    
//    //Remove all objects first.
//    [filteredContentList removeAllObjects];
//    
//    if([searchText length] != 0) {
//        isSearching = YES;
//        [self searchTableList];
//    }
//    else {
//        isSearching = NO;
//    }
//    // [self.tblContentList reloadData];
//}
//
//- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
//    NSLog(@"Cancel clicked");
//}
//
//- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
//    NSLog(@"Search Clicked");
//    [self searchTableList];
//}
@end
