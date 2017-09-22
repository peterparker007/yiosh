//
//  ThirdDashboard.m
//  ZapFashion
//
//  Created by bhumesh on 7/20/17.
//  Copyright © 2017 bhumesh. All rights reserved.
//

#import "ThirdDashboard.h"
#import "Globals.h"
#import "CategoryDetailsVC.h"
#import "CheckoutVC.h"
#import "ItemDetailVC.h"
#import "CacheController.h"
@interface ThirdDashboard ()
{
    NSMutableDictionary *savedValue;
}
@end

@implementation ThirdDashboard
- (void)viewDidLoad {
    // Do any additional setup after loading the view.
    [self MenuButttonTapped:_btnMenu];
    [self rightMenuTapped:_btnmenu2];
    appDelegateTemp = (AppDelegate *)[[UIApplication sharedApplication]delegate];
      objMyGlobals=[Globals sharedManager];
    [self DisplayBadge];
    currMinute=0;
    currSeconds=0;
    currHrs=3;
    /*Method For Start Timer*/
    [self start];
    
    //Serchbar TextField Text Color Change.
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
 //  aryItemData=[[NSArray alloc]initWithObjects:@"image2",@"image3",@"image4",@"image5",@"image6",@"image7", nil];
    [self GetData];
    arrBestsellerData=[[NSMutableArray alloc]init];
    arrDiscountedData=[[NSMutableArray alloc]init];
    arrMostviewedData=[[NSMutableArray alloc]init];
    
     [self GetData:@"best_seller"];
    [self GetData:@"most_viewed"];
    [self GetData:@"discounted"];
   
    
    /*array For Upper Slider*/
    arrImageData=[NSArray arrayWithObjects:@"Accessory",@"Bag",@"Jellewery",@"Kids",@"Mens",@"Sport",@"Womens", nil];
    [_collectionvw reloadData];
    [_collectionvw3 reloadData];
     [_collectionvw2 reloadData];
   // [_collItemView reloadData];
    
}
-(void)viewWillAppear:(BOOL)animated
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"Data.plist"];
    savedValue = [[NSMutableDictionary alloc] initWithContentsOfFile: path];
   [_TopView setBackgroundColor: [self colorWithHexString:[savedValue valueForKey:@"header_color"]]];
    [_HeaderTitle setTextColor:[self colorWithHexString:[savedValue valueForKey:@"header_text_color"]]];
      [_scrlsubvw setBackgroundColor:[self colorWithHexString:[savedValue valueForKey:@"bg_color"]]];
    [self DisplayBadge];
    [self SetConfigForTopView];
}
-(void)SetConfigForTopView
{
  
    _TopView.frame=[objMyGlobals currentDevicePositions:CGRectMake(0, 0, 381, 50) vwRect:self.view.frame];
    _btnMenu.frame=[objMyGlobals currentDevicePositions:CGRectMake(0, 0, 33, 50) vwRect:self.view.frame];
    
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
    fileUrl =[NSURL URLWithString:[savedValue valueForKey:@"search_logo"]];
    
    fileData =[NSData dataWithContentsOfURL:fileUrl];
    
    dispatch_async(dispatch_get_main_queue(), ^ {
        
        [_btnSearch setImage:[UIImage imageWithData:fileData] forState:UIControlStateNormal];
        
    });
    frame1=[objMyGlobals getXYPositions:[savedValue valueForKey:@"search_logo_position"]];
    _btnSearch.frame=[objMyGlobals currentDevicePositions:CGRectMake(frame1.origin.x, frame1.origin.y, 25, 25) vwRect:self.view.frame];
    
    _btnmenu2.frame=[objMyGlobals currentDevicePositions:CGRectMake(284, 3, 33, 50) vwRect:self.view.frame];
    _searchBar.frame=[objMyGlobals currentDevicePositions:CGRectMake(0, 0, 381, 50) vwRect:self.view.frame];
    
    
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
-(void)GetData
{
 
    objMyGlobals=[Globals sharedManager];
    objMyGlobals.user.template_no=[@"3" mutableCopy];
    if([appDelegateTemp checkInternetConnection]==true)
    {
        [objMyGlobals showLoaderIn:self.view];
        [objMyGlobals.user GetMobileBanner:^(NSString *str, int status)
         {
             
             if(status==1)
             {
                 [objMyGlobals hideLoader:self.view];
                 aryItemData=appDelegateTemp.ArrImageBanner;
                    _pageControl.numberOfPages=aryItemData.count;
                 [_collItemView reloadData];
                 
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
   if(![objMyGlobals.spinner isDescendantOfView:self.view])
   {
       [objMyGlobals showLoaderIn:self.view];
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
            if([type isEqualToString:@"most_viewed"])
            {
                arrMostviewedData=appDelegateTemp.AdvanceProductData;
                [self.collectionvw2 reloadData];
            }
            else if ([type isEqualToString:@"discounted"])
            {
                 arrDiscountedData=appDelegateTemp.AdvanceProductData;
                 [self.collectionvw3 reloadData];
            }
            else if([type isEqualToString:@"best_seller"])
            {
                 arrBestsellerData=appDelegateTemp.AdvanceProductData;
                 [self.collectionvw reloadData];
            }
            
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
//Timer Start
-(void)start
{
    timer=[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerFired) userInfo:nil repeats:YES];
    
}
-(void)timerFired
{
    if((currHrs>0||currMinute>0 || currSeconds>=0) && currMinute>=0)
    {
        if(currMinute==0 && currSeconds==0 && currHrs>0)
        {
            currHrs-=1;
            currMinute=59;
            currSeconds=59;
        }
        else if(currSeconds==0)
        {
            currMinute-=1;
            currSeconds=59;
        }
        else if(currSeconds>0)
        {
            currSeconds-=1;
        }
        if(currMinute>-1)
            [_lblTimer setText:[NSString stringWithFormat:@"%@%d%@%d%@%02d",@"Time : ",currHrs,@":",currMinute,@":",currSeconds]];
    }
    else
    {
        [timer invalidate];
    }
}
-(void)viewDidAppear:(BOOL)animated
{
    [self DisplayBadge];
}
- (IBAction)MenuButttonTapped:(id)sender
{
    // DEMOLeftMenuViewController *leftMenuViewController = [DEMOLeftMenuViewController shareInstance];
    
    [sender addTarget:self action:@selector(presentLeftMenuViewController:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
// Set Data in Collection View.
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (collectionView.tag == 100)
    {
        return aryItemData.count;
    }
    else if(collectionView==_collectionvw)
    {
        return arrBestsellerData.count;
    }
    else if(collectionView==_collectionvw3)
    {
        return arrDiscountedData.count;
    }
    else if(collectionView==_collectionvw2)
    {
        return arrMostviewedData.count;
    }
    return 0;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    //    CGFloat cellSize1 = self.categoryCollView.frame.size.height - padding;
    if (collectionView.tag == 100)
    {
        return CGSizeMake(_collItemView.frame.size.width, _collItemView.frame.size.height);
    }
    else if (collectionView.tag == 200)
    {
    
        CGFloat padding = 10;
        CGFloat cellSize = self.collectionvw.frame.size.width - padding;
        return CGSizeMake(cellSize / 2 , (self.collectionvw.frame.size.height-padding));
        
    }
    else if (collectionView.tag == 300)
    {
        CGFloat padding = 10;
        CGFloat cellSize = self.collectionvw.frame.size.width - padding;
        return CGSizeMake(cellSize / 2 , (self.collectionvw.frame.size.height-padding));
    }
    else
    {
        CGFloat padding = 10;
        CGFloat cellSize = self.collectionvw.frame.size.width - padding;
        return CGSizeMake(cellSize / 2 , (self.collectionvw.frame.size.height-padding));
    }
    
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (collectionView.tag==100)
    {
        static NSString *identifier = @"ItemCell";
        ItemCollCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
        
     
        
        NSString *cacheKey = [NSString stringWithFormat:@"%ld%ld", (long)indexPath.row, (long)indexPath.section];       
            
            [cell downloadFile:[NSURL URLWithString:[[aryItemData objectAtIndex:indexPath.row] valueForKey:@"image"]]
                  forIndexPath:indexPath cacheKey:cacheKey];
        return cell;
    }
    else if(collectionView.tag==200)
    {
         static NSString *identifier1 = @"daily";
        NSMutableDictionary *dict=[arrMostviewedData objectAtIndex:indexPath.row];
       
        CategoryDetailCollCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier1 forIndexPath:indexPath];
//        [cell.imgItemView sd_setImageWithURL:[dict objectForKey:@"thumbnail_imageurl"]
//                        placeholderImage:[UIImage imageNamed:@"avatar-placeholder.png"]
//                                 options:SDWebImageRefreshCached];
        
        NSString *cacheKey = [NSString stringWithFormat:@"%@%ld%ld",[dict objectForKey:@"name"], (long)indexPath.row, (long)indexPath.section];
        NSData *cachedObject = [[CacheController sharedInstance] getCacheForKey:cacheKey];
        
        if (cachedObject != nil) {
            UIImage *img=[UIImage imageWithData:cachedObject];
            [cell.imgItemView setImage:img];
            // [[cell textLabel] setText:@"Got object from cache!"];
        }
        
        else {
            
            [cell downloadFile:[NSURL URLWithString:[dict objectForKey:@"thumbnail_imageurl"]]
                  forIndexPath:indexPath cacheKey:cacheKey];
            
        }
     
        cell.lblItemName.text=[dict objectForKey:@"name"];
         return cell;
    }
    else if(collectionView.tag==300)
    {
        static NSString *identifier1 = @"shop";
        NSMutableDictionary *dict=[arrDiscountedData objectAtIndex:indexPath.row];
        
        CategoryDetailCollCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier1 forIndexPath:indexPath];
//        [cell.imgItemView sd_setImageWithURL:[dict objectForKey:@"image_url"]
//                            placeholderImage:[UIImage imageNamed:@"avatar-placeholder.png"]
//                                     options:SDWebImageRefreshCached];
        
        NSString *cacheKey = [NSString stringWithFormat:@"%@%ld%ld",[dict objectForKey:@"name"], (long)indexPath.row, (long)indexPath.section];
        NSData *cachedObject = [[CacheController sharedInstance] getCacheForKey:cacheKey];
        
        if (cachedObject != nil) {
            UIImage *img=[UIImage imageWithData:cachedObject];
            [cell.imgItemView setImage:img];
            // [[cell textLabel] setText:@"Got object from cache!"];
        }
        
        else {
            
            [cell downloadFile:[NSURL URLWithString:[dict objectForKey:@"thumbnail_imageurl"]]
                  forIndexPath:indexPath cacheKey:cacheKey];
            
        }
        cell.lblItemName.text=[dict objectForKey:@"name"];
        return cell;

    }
    else 
    {
        static NSString *identifier1 = @"Feature";
        NSMutableDictionary *dict=[arrBestsellerData objectAtIndex:indexPath.row];
        
        CategoryDetailCollCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier1 forIndexPath:indexPath];
//        [cell.imgItemView sd_setImageWithURL:[dict objectForKey:@"thumbnail_imageurl"]
//                            placeholderImage:[UIImage imageNamed:@"avatar-placeholder.png"]
//                                     options:SDWebImageRefreshCached];
        NSString *cacheKey = [NSString stringWithFormat:@"%@%ld%ld",[dict objectForKey:@"name"], (long)indexPath.row, (long)indexPath.section];
        NSData *cachedObject = [[CacheController sharedInstance] getCacheForKey:cacheKey];
        
        if (cachedObject != nil) {
            UIImage *img=[UIImage imageWithData:cachedObject];
            [cell.imgItemView setImage:img];
            // [[cell textLabel] setText:@"Got object from cache!"];
        }
        
        else {            
            [cell downloadFile:[NSURL URLWithString:[dict objectForKey:@"thumbnail_imageurl"]]
                  forIndexPath:indexPath cacheKey:cacheKey];
        }
        
        cell.lblItemName.text=[dict objectForKey:@"name"];
        return cell;
        
    }
}
//Collection view item Did Select
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
 /*   if (collectionView.tag != 100)
    {
        //Globals *objMyGlobals;
        objMyGlobals=[Globals sharedManager];
        objMyGlobals.user.CatID=[tempMoveData objectAtIndex:indexPath.row];
        UIStoryboard *objStoryboard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
        [appDelegateTemp.ProductData removeAllObjects];
        CategoryDetailsVC *newView = (CategoryDetailsVC *)[objStoryboard instantiateViewControllerWithIdentifier:@"CategoryDetailsVC"];
        [self.navigationController pushViewController:newView animated:YES];
        
        
        
    }*/
     UIStoryboard *objStoryboard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
     ItemDetailVC *newView = (ItemDetailVC *)[objStoryboard instantiateViewControllerWithIdentifier:@"ItemDetailVC"];
    if(collectionView==_collectionvw)
    {
         newView.DataDic=[arrBestsellerData objectAtIndex:indexPath.row];
        objMyGlobals.user.prod_id=[[arrBestsellerData objectAtIndex:indexPath.row] valueForKey:@"prod_id"];
   
    }
    else if(collectionView==_collectionvw3)
    {
         newView.DataDic=[arrDiscountedData objectAtIndex:indexPath.row];
        objMyGlobals.user.prod_id=[[arrDiscountedData objectAtIndex:indexPath.row] valueForKey:@"prod_id"];
   
    }
    else if(collectionView==_collectionvw2)
    {
         newView.DataDic=[arrMostviewedData objectAtIndex:indexPath.row];
        objMyGlobals.user.prod_id=[[arrMostviewedData objectAtIndex:indexPath.row] valueForKey:@"prod_id"];
       
    }
    [self.navigationController pushViewController:newView animated:YES];
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat pageWidth = _collItemView.frame.size.width;
    float currentPage = _collItemView.contentOffset.x / pageWidth;
    
    if (0.0f != fmodf(currentPage, 1.0f))
    {
        _pageControl.currentPage = currentPage + 1;
    }
    else
    {
        _pageControl.currentPage = currentPage;
    }
}
//Display Badge Value
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
    _btnmenu2.hidden=true;
    _btnSearch.hidden=true;
    _btnCart.hidden=true;
    _HeaderTitle.hidden=true;
    _tempBadge.hidden=true;
    _Logo.hidden=true;
    _btnMenu.hidden=true;
    _searchBar.layer.zPosition=1;
    _searchBar.hidden=false;
    _searchBar.showsCancelButton = YES;
}
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    _btnmenu2.hidden=false;
    _btnSearch.hidden=false;
    _btnCart.hidden=false;
    _HeaderTitle.hidden=false;
    _tempBadge.hidden=false;
    _Logo.hidden=false;
    _btnMenu.hidden=false;
    [searchBar resignFirstResponder];
    [searchBar setShowsCancelButton:NO animated:YES];
    [searchBar setHidden:true];
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    
    [self.view endEditing:YES];
  
    
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
                 _btnmenu2.hidden=false;
                 _btnSearch.hidden=false;
                 _btnCart.hidden=false;
                 _HeaderTitle.hidden=false;
                 _tempBadge.hidden=false;
                 _Logo.hidden=false;
                 _btnMenu.hidden=false;
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
//Cart Button Tapped
- (IBAction)btnCartTapped:(id)sender {
    UIStoryboard *objStoryboard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    CheckoutVC *newView = (CheckoutVC *)[objStoryboard instantiateViewControllerWithIdentifier:@"CheckoutVC"];
    [self.navigationController pushViewController:newView animated:YES];
}
//Display All Data.
- (IBAction)ViewAllData:(id)sender {
    UIButton *btn=sender;
      UIStoryboard *objStoryboard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
      CategoryDetailsVC *newView = (CategoryDetailsVC *)[objStoryboard instantiateViewControllerWithIdentifier:@"CategoryDetailsVC"];
    if(btn.tag==1)
    {
           [self GetData:@"best_seller"];
        newView.strType=@"best_seller";
         appDelegateTemp.ProductData=arrBestsellerData;
    }else if(btn.tag==2)
    {    [self GetData:@"most_viewed"];
          newView.strType=@"most_viewed";
         appDelegateTemp.ProductData=arrMostviewedData;
    }else if(btn.tag==3)
    {
         [self GetData:@"discounted"];
         newView.strType=@"discounted";
         appDelegateTemp.ProductData=arrDiscountedData;
    }
  
    
  
    [self.navigationController pushViewController:newView animated:YES];
}
- (IBAction)rightMenuTapped:(id)sender {
    [sender addTarget:self action:@selector(presentRightMenuViewController:) forControlEvents:UIControlEventTouchUpInside];
}
@end
