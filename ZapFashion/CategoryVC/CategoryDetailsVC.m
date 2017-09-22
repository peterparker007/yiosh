//
//  CategoryDetailsVC.m
//  ZapFashion
//
//  Created by disha on 6/6/17.
//  Copyright © 2017 bhumesh. All rights reserved.
//

#import "CategoryDetailsVC.h"
#import "CategoryDetailCollCell.h"
#import "TableViewCell.h"
#import "ItemDetailVC.h"
#import "FilterColorCollCell.h"
#import "CheckoutVC.h"
#import "TableViewCell.h"
#import "CategoryDetailsTblVWCell.h"
#import "ThirdDashboard.h"
#import "AppDelegate.h"

#import "ViewController.h"
#import "CacheController.h"



@interface CategoryDetailsVC ()<UICollectionViewDelegate,UICollectionViewDataSource,UIPickerViewDelegate,UIPickerViewDataSource,UITableViewDelegate,UITableViewDataSource>
{
    BOOL isLike,isApplyFilter,isTapped;
    UIPickerView *pickerView;
    NSArray *items;
    UIView *viewContent,*viewPicker, *mainFilterView;
    NSMutableArray  *tableData_Brands;
    NSMutableArray  *tableData_Febric;
    NSMutableArray  *tableData_Details;
    NSMutableArray  *SelectedIndexs;
    NSMutableArray  *SelectedFavorite;
    AppDelegate *appDelegateTemp;
    NSMutableArray *filteredData;
    NSMutableDictionary *dictData;
    NSMutableDictionary *dictForPrice;
      UIButton *button;
    NSMutableDictionary *savedValue;
    
    // [se setAllowsMultipleSelection:YES];
    
    
}
@end
@implementation CategoryDetailsVC
- (void)viewDidLoad {
    [super viewDidLoad];
    [super awakeFromNib];
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
   dictData=[NSMutableDictionary new];
    pagenum=1;
    SortedIndex=-1;
    self.tblvwDetails.delegate=self;
    self.tblvwDetails.dataSource=self;
    dictForPrice=[NSMutableDictionary new];
    sectionTitleArray=[[NSMutableArray alloc]init];
     arrayForBool=[[NSMutableArray alloc]init];
      child=[[NSMutableArray alloc]init];
    filterDone=false;
    objMyGlobals=[Globals sharedManager];
    isApplyFilter=false;
    arrWishList=[[NSMutableArray alloc]init];
    FilterData=[[NSMutableDictionary alloc]init];
    filteredData=[[NSMutableArray alloc]init];
    arrPrice=[[NSMutableArray alloc]init];
    SelectedIndexs=[[NSMutableArray alloc]init];
    appDelegateTemp = (AppDelegate *)[[UIApplication sharedApplication]delegate];
   
    //WithObjects:@"1999",@"9999",@"3999",@"4999", nil];
    arrDiscountPrice=[[NSMutableArray alloc]init];
    arrProductImage=[[NSMutableArray alloc]init];
    
    SelectedFavorite=[[NSMutableArray  alloc]init];
    //  [self.categoryCollView setAllowsMultipleSelection:YES];
    refreshControl = [[UIRefreshControl alloc]init];
    [_categoryCollView addSubview:refreshControl];
    [_tblvwDetails addSubview:refreshControl];
    [refreshControl addTarget:self action:@selector(resetTblData) forControlEvents:UIControlEventValueChanged];
    [self initializeBottomRefreshControl];
    ThirdDashboard *obj=[[ThirdDashboard alloc]init];
   
  
    if([[self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count-2]isKindOfClass:obj.class]||objMyGlobals.isSearched)
    {
        _btnFilter.enabled=false;
        _vwWithNoFilter.hidden=false;
        [self.categoryCollView reloadData];
        [_categoryCollView addSubview:indicatorFooter];
        [_tblvwDetails addSubview:indicatorFooter];
    }
    else
    {
    [self initView];
    }
      [self configureSetValueSlider];
    [self DisplayBadge];

}
-(void)viewWillAppear:(BOOL)animated
{
    
    [self.navigationController setNavigationBarHidden:YES];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"Data.plist"];
    savedValue = [[NSMutableDictionary alloc] initWithContentsOfFile: path];
 [_TopView setBackgroundColor: [self colorWithHexString:[savedValue valueForKey:@"header_color"]]];
    [_btnApplyFilter setBackgroundColor:[self colorWithHexString:[savedValue valueForKey:@"login_btn_col"]]];
    [_btnClearFilter setBackgroundColor:[self colorWithHexString:[savedValue valueForKey:@"signup_btn_col"]]];
    [_categoryCollView setBackgroundColor:[self colorWithHexString:[savedValue valueForKey:@"bg_color"]]];
    [self DisplayBadge];
    [self SetConfigForTopView];
}
-(void)SetConfigForTopView
{
   
    _TopView.frame=[objMyGlobals currentDevicePositions:CGRectMake(0, 0, 381, 50) vwRect:self.view.frame];
 
    
    CGRect frame1=[objMyGlobals getXYPositions:[savedValue valueForKey:@"cart_logo_position"]];
    
    NSURL *fileUrl =[NSURL URLWithString:[savedValue valueForKey:@"bag_logo"]];
    
    NSData *fileData =[NSData dataWithContentsOfURL:fileUrl];
    
    dispatch_async(dispatch_get_main_queue(), ^ {        
        
        [_btnCart setImage:[UIImage imageWithData:fileData] forState:UIControlStateNormal];
        
    });
    _btnCart.frame=[objMyGlobals currentDevicePositions:CGRectMake(frame1.origin.x, frame1.origin.y, 30, 30) vwRect:self.view.frame];
    _tempBadge.frame=[objMyGlobals currentDevicePositions:CGRectMake( frame1.origin.x+20, frame1.origin.y-7, 30, 30) vwRect:self.view.frame];
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
    _btnSearch.frame=[objMyGlobals currentDevicePositions:CGRectMake(frame1.origin.x, frame1.origin.y, 27, 27) vwRect:self.view.frame];
    CGRect  frame= _divder.frame;
    frame.origin.y= _TopView.frame.size.height;
    frame.size.width= _TopView.frame.size.width;
    _divder.frame=frame;
}
-(void)viewDidDisappear:(BOOL)animated
{
    objMyGlobals.isSearched=false;
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
-(void)initializeBottomRefreshControl
{
    indicatorFooter = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(_categoryCollView.frame), 44)];
    [indicatorFooter setColor:[UIColor blackColor]];
}


-(void)initView
{
    
    
    objMyGlobals.user.DataForJason=nil;
    objMyGlobals.user.apikey=[@"ICXE1wOphgKgcyMoHr0hVHbbJ" mutableCopy];
    objMyGlobals.user.pageno=[[NSString stringWithFormat:@"%d",pagenum] mutableCopy];
    //objMyGlobals.user.CustID=_CustID;
    [objMyGlobals showLoaderIn:self.view];
    if([appDelegateTemp checkInternetConnection]==true)
    {
    [objMyGlobals.user GetProductData:^(NSString *str, int status)
     {
         if(status==1)
         {
             
             NSMutableArray*temp= [[appDelegateTemp.FilterData objectAtIndex:0]valueForKey:@"attributes"];
             dictForPrice=[NSMutableDictionary new];
            
            dictForPrice=[[appDelegateTemp.FilterData objectAtIndex:0]valueForKey:@"priceRange"];
             NSLog(@"%@",[dictForPrice objectForKey:@"maxPrice"]);
             sectionTitleArray=[NSMutableArray new];
             child=[NSMutableArray new];
             SelectedIndexs=[[NSMutableArray alloc]init];
             for(int i=0;i<temp.count;i++)
             {
                 NSMutableDictionary *Parent=[[NSMutableDictionary alloc]initWithDictionary:[temp objectAtIndex:i]];
                 [sectionTitleArray addObject:[Parent objectForKey:@"attributeLabel"]];
                 
                 [ child addObject:[Parent objectForKey:@"attributeValues"]];
                 
                 
             }
             
             for (int i=0; i<[sectionTitleArray count]; i++) {
                 [arrayForBool addObject:[NSNumber numberWithBool:NO]];
             }
             _tblvw.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
             [_tblvw reloadData];
               [self updateSetValuesSlider];
         
         
             [self.categoryCollView reloadData];
             [objMyGlobals hideLoader:self.view];
             [_categoryCollView addSubview:indicatorFooter];
             [_tblvwDetails addSubview:indicatorFooter];
             [_tblvwDetails reloadData];
             
             
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
-(void)viewDidAppear:(BOOL)animated
{
   // pagenum=1;
  //  [self initView];
    if(appDelegateTemp.ProductData.count>0)
    {
        [self.categoryCollView reloadData];
        [_tblvwDetails reloadData];
    }
 //   [self DisplayBadge];
    [self updateSetValuesSlider];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
#pragma mark  function_for_slider
- (void) configureSetValueSlider
{
    [self configureMetalThemeForSlider:self.SliderForPrice];
    self.SliderForPrice.minimumRange = 0;
    self.SliderForPrice.maximumValue =10000;
    self.SliderForPrice.stepValue=5.0;
    
}
- (void) configureMetalThemeForSlider:(PriceSlider*) slider
{
    UIImage* image = nil;
    
    image = [UIImage imageNamed:@"slider-metal-trackBackground"];
    image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(0.0, 5.0, 0.0, 5.0)];
    slider.trackBackgroundImage = image;
    
    image = [UIImage imageNamed:@"slider-metal-track"];
    image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(0.0, 7.0, 0.0, 7.0)];
    slider.trackImage = image;
    
    image = [UIImage imageNamed:@"slider-metal-handle"];
    image = [image imageWithAlignmentRectInsets:UIEdgeInsetsMake(-1, 2, 1, 2)];
    slider.lowerHandleImageNormal = image;
    slider.upperHandleImageNormal = image;
    
    image = [UIImage imageNamed:@"slider-metal-handle-highlighted"];
    image = [image imageWithAlignmentRectInsets:UIEdgeInsetsMake(-1, 2, 1, 2)];
    slider.lowerHandleImageHighlighted = image;
    slider.upperHandleImageHighlighted = image;
}
- (void) updateSetValuesSlider
{
    //    float value1 = (float)random()/RAND_MAX;
    //    float value2 = (float)random()/RAND_MAX;
    int min=[[dictForPrice objectForKey:@"minPrice"] intValue];
     int max=[[dictForPrice objectForKey:@"maxPrice"] intValue];
    if(min>0 && max>0)
    {
        if(min==max)
        {
            max=max+1;
            [self sliderValueChange:self.SliderForPrice];
        }
      
    [self.SliderForPrice setLowerValue:MIN(min, min) upperValue:MAX(max, max) animated:YES];
    [self.SliderForPrice setLowerValue:min];
    self.SliderForPrice.minimumValue = min;
    self.SliderForPrice.maximumValue =max;
    _lblValueFilter.text=[NSString stringWithFormat:@"₹ %d",(int)_SliderForPrice.upperValue];
    _lblMinValue.text=[NSString stringWithFormat:@"₹ %d",(int)_SliderForPrice.lowerValue];
          [self sliderValueChange:self.SliderForPrice];
    }
    // OR set them individually
    //[self.setValuesSlider setLowerValue:MIN(value1, value2) animated:YES];
    //[self.setValuesSlider setUpperValue:MAX(value1, value2) animated:YES];
}
- (IBAction)sliderValueChange:(id)sender {
    _lblValueFilter.text=[NSString stringWithFormat:@"₹ %d",(int)_SliderForPrice.upperValue];
    _lblMinValue.text=[NSString stringWithFormat:@"₹ %d",(int)_SliderForPrice.lowerValue];
}

#pragma mark Random color Genrator
- (UIColor *)randomColor
{
    NSInteger aRedValue = arc4random()%255;
    NSInteger aGreenValue = arc4random()%255;
    NSInteger aBlueValue = arc4random()%255;
    return  [UIColor colorWithRed:aRedValue/255.0f green:aGreenValue/255.0f blue:aBlueValue/255.0f alpha:1.0f];
}
#pragma mark -uicollctionview
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if(isApplyFilter)
    {
        return filteredData.count;
    }
    else
        return appDelegateTemp.ProductData.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (collectionView.tag == 1000){
        CGFloat padding = 8;
        CGFloat cellSize = self.categoryCollView.frame.size.width - padding;
        return CGSizeMake((cellSize / 2), cellSize*0.65);
    }
    else
    {
        return CGSizeMake(25,25);
    }
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (collectionView == _categoryCollView)
    {   
        static NSString *identifier = @"CategoryCell";
        CategoryDetailCollCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
        [cell.imgCartView setBackgroundColor:[self colorWithHexString:[savedValue valueForKey:@"cat_card_bg_col"]]];
        if(appDelegateTemp.ProductData.count>0)
        {
            NSMutableDictionary *dict=[appDelegateTemp.ProductData objectAtIndex:indexPath.row];
            if(isApplyFilter)
            {
                NSMutableDictionary  *dict1=[filteredData objectAtIndex:indexPath.row];
                if(dict1.count>0)
                {
                    
                    NSString *cacheKey = [NSString stringWithFormat:@"%@%ld%ld",[dict1 objectForKey:@"name"], (long)indexPath.row, (long)indexPath.section];
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
                    
                    
                    
                    
                  /*  [cell.imgItemView sd_setImageWithURL:[dict1 objectForKey:@"thumbnail_imageurl"]
                                        placeholderImage:[UIImage imageNamed:@"avatar-placeholder.png"]
                                                 options:SDWebImageRefreshCached];*/
                    
                    // Async Image
//                    cell.imgItemView.imageURL = [NSURL URLWithString:[dict1 objectForKey:@"thumbnail_imageurl"]];
//                    cell.imgItemView.showActivityIndicator=true;
//                    
//                    [[AsyncImageLoader sharedLoader] cancelLoadingImagesForTarget:cell.imgItemView.imageURL];
                    
                    
                   
                    cell.lblItemName.text=[NSString stringWithFormat:@"%@",[dict1 objectForKey:@"name"]];
                    
                    cell.btnLike.tag = indexPath.row;
                    [cell.btnLike addTarget:self action:@selector(likeButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
                    NSString *tempstr=[NSString stringWithFormat:@"%@",[dict1 objectForKey:@"discount_price"]];
                    NSMutableAttributedString *myString1= [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@ ",tempstr]];
                    cell.lblDiscountPrice.attributedText=myString1;
                    
                    
                    
                    NSString *tempstr1=[NSString stringWithFormat:@"%@",[dict1 objectForKey:@"price"]];
                    NSMutableAttributedString *myString2= [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"₹%@ ",tempstr1]];
                    
                    
                    
                    [myString2 addAttribute:NSStrikethroughStyleAttributeName
                                      value:@2
                                      range:NSMakeRange(0, [myString2 length])];
                    
                    
                    cell.lblActualPrice.textColor=[UIColor lightGrayColor];
                    cell.lblActualPrice.attributedText = myString2;
                    NSString *str=[NSString stringWithFormat:@"%@",[dict objectForKey:@"wishlist"]];
                    if ([str isEqualToString:@"1"]||[objMyGlobals.arrWishList containsObject:[dict1 objectForKey:@"prod_id"]])// Is selected?
                    {
                        
                        
                        isLike=false;
                        // [cell.btnSelection setImage:nil];
                        [cell.btnLike setImage:[UIImage imageNamed:@"ic_like"] forState:UIControlStateNormal];
                    }
                    else{
                        
                        
                        isLike=true;
                        // [cell.btnSelection setImage:nil];
                        [cell.btnLike setImage:[UIImage imageNamed:@"ic_unlike"] forState:UIControlStateNormal];
                        
                    }
                }
            }
            else
            {
                
                NSString *cacheKey = [NSString stringWithFormat:@"%@%ld%ld",[dict objectForKey:@"name"], (long)indexPath.row, (long)indexPath.section];
//                NSData *cachedObject = [[CacheController sharedInstance] getCacheForKey:cacheKey];
//                
//                if (cachedObject != nil) {
//                   // UIImage *img=[UIImage imageWithData:cachedObject];
//                   // [cell.imgItemView setImage:img];
//                    cell.imgItemView.image=[UIImage imageWithData:cachedObject];
//                   
//                    // [[cell textLabel] setText:@"Got object from cache!"];
//                }
//                
//                else {
                
                    [cell downloadFile:[NSURL URLWithString:[dict objectForKey:@"thumbnail_imageurl"]]
                          forIndexPath:indexPath cacheKey:cacheKey];
                    
              //  }
                
                /*[cell.imgItemView sd_setImageWithURL:[dict objectForKey:@"thumbnail_imageurl"]
                                    placeholderImage:[UIImage imageNamed:@"avatar-placeholder.png"]
                                             options:SDWebImageRefreshCached];*/
                
                
//                cell.imgItemView.imageURL =  [NSURL URLWithString:[dict objectForKey:@"thumbnail_imageurl"]];
//                cell.imgItemView.showActivityIndicator=true;
//                
//                [[AsyncImageLoader sharedLoader] cancelLoadingImagesForTarget:cell.imgItemView.imageURL];
                cell.lblItemName.text=[NSString stringWithFormat:@"%@",[dict objectForKey:@"name"]];
                
                cell.btnLike.tag = indexPath.row;
                [cell.btnLike addTarget:self action:@selector(likeButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
                NSString *tempstr=[NSString stringWithFormat:@"%@",[dict objectForKey:@"discount_price"]];
                NSMutableAttributedString *myString1= [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@ ",tempstr]];
                cell.lblDiscountPrice.attributedText=myString1;
                
                if([dict objectForKey:@"discount_price"]==[dict objectForKey:@"price"])
                {
                      cell.lblActualPrice.hidden=true;
                }
                else
                {
                
                NSString *tempstr1=[NSString stringWithFormat:@"%@",[dict objectForKey:@"price"]];
                NSMutableAttributedString *myString2= [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"₹%@ ",tempstr1]];
                
                
                
                [myString2 addAttribute:NSStrikethroughStyleAttributeName
                                  value:@2
                                  range:NSMakeRange(0, [myString2 length])];
                
                
                cell.lblActualPrice.textColor=[UIColor lightGrayColor];
                cell.lblActualPrice.attributedText = myString2;
                }
                
             //   NSString  *strIndex =[NSString stringWithFormat:@"%ld",(long)indexPath.row];
//                 NSString *prdid=[NSString stringWithFormat:@"%@",[dict objectForKey:@"prod_id"]];
                NSString *str=[NSString stringWithFormat:@"%@",[dict objectForKey:@"wishlist"]];
                if ([str isEqualToString:@"1"]||[objMyGlobals.arrWishList containsObject:[dict objectForKey:@"prod_id"]])// Is selected?
                {
                    
                    
                    isLike=false;
                    // [cell.btnSelection setImage:nil];
                    [cell.btnLike setImage:[UIImage imageNamed:@"ic_like"] forState:UIControlStateNormal];
                }
                else{
                    
                    
                    isLike=true;
                    // [cell.btnSelection setImage:nil];
                    [cell.btnLike setImage:[UIImage imageNamed:@"ic_unlike"] forState:UIControlStateNormal];
                    
                }
            }
            
            
        }
        return cell;
    }
    else{
        static NSString *identifier = @"ColorCell";
        [collectionView setAllowsMultipleSelection:YES];
        FilterColorCollCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
        cell.viewColor.backgroundColor = [self randomColor];
        cell.viewColor.layer.borderColor = [UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:1.0].CGColor;
        return cell;
    }
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView.tag == 1000)
    {
        UIStoryboard *objStoryboard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
        
        ItemDetailVC *newView = (ItemDetailVC *)[objStoryboard instantiateViewControllerWithIdentifier:@"ItemDetailVC"];
   
        if(filterDone)
        {
           //  newView.DataDic=[filteredData objectAtIndex:indexPath.row];
            objMyGlobals.user.prod_id=[[filteredData objectAtIndex:indexPath.row] valueForKey:@"prod_id"];
        }
        else
        {
          //  newView.DataDic=[appDelegateTemp.ProductData objectAtIndex:indexPath.row];
            objMyGlobals.user.prod_id=[[appDelegateTemp.ProductData objectAtIndex:indexPath.row] valueForKey:@"prod_id"];
        }
        [self.navigationController pushViewController:newView animated:YES];
        
    }
    else{
        FilterColorCollCell *cell = (FilterColorCollCell*)[collectionView cellForItemAtIndexPath:indexPath];
        cell.viewColor.layer.borderWidth=1.0f;
        cell.viewColor.layer.borderColor=[UIColor darkGrayColor].CGColor;;
        self.selectedIndexPath = indexPath;
    }
    
}
-(void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
   if([scrollView isKindOfClass: _categoryCollView.class])
    {
    if(self.categoryCollView.contentOffset.y<0){
        //it means table view is pulled down like refresh
        return;
    }
    else if(self.categoryCollView.contentOffset.y >= (self.categoryCollView.contentSize.height - self.categoryCollView.bounds.size.height)) {
        NSLog(@"bottom!");
        [indicatorFooter stopAnimating];
        [self resetTblData];
         [indicatorFooter removeFromSuperview];
        
    }
    }
    else
    {
        if(self.tblvwDetails.contentOffset.y<0){
            //it means table view is pulled down like refresh
            return;
        }
        else if(self.tblvwDetails.contentOffset.y >= (self.tblvwDetails.contentSize.height - self.tblvwDetails.bounds.size.height)) {
            NSLog(@"bottom!");
            [indicatorFooter stopAnimating];
            [self resetTblData];
            [indicatorFooter removeFromSuperview];
            
        }

    }
    
}
-(void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (collectionView.tag != 1000)
    {
        FilterColorCollCell *cell = (FilterColorCollCell*)[collectionView cellForItemAtIndexPath:indexPath];
        cell.viewColor.layer.cornerRadius = 1.0f;
        cell.viewColor.layer.borderColor = [UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:1.0].CGColor;
        self.selectedIndexPath = nil;
    }
}
- (void)resetTblData {
    //TODO: refresh your data
     ThirdDashboard *obj=[[ThirdDashboard alloc]init];
    if([[self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count-2]isKindOfClass:obj.class])
    {
        
        if([appDelegateTemp.TotalPage integerValue]>pagenum)
        {
            pagenum=pagenum+1;
            [self GetData:_strType];
        }
        [refreshControl endRefreshing];
        [self.categoryCollView reloadData];
        [self.tblvwDetails reloadData];
    }
    else
    {
    
    
    if([appDelegateTemp.TotalPage integerValue]>pagenum)
    {
        pagenum=pagenum+1;
        [self initView];
    }
    [refreshControl endRefreshing];
    [self.categoryCollView reloadData];
    [self.tblvwDetails reloadData];
    }
    
}
-(void)GetData:(NSString*)type
{
    [objMyGlobals showLoaderIn:self.view];
    //  objMyGlobals.user.userid=[appDelegateTemp.localDataDic objectForKey:@"userid"];
    objMyGlobals.user.type=[type mutableCopy];
    if([appDelegateTemp checkInternetConnection]==true)
    {[objMyGlobals.user GetAdvanceProductForPagination:^(NSString *str, int status){
        if(status==1)
        {
            [objMyGlobals Displaymsg:self.view msg:str];
            appDelegateTemp.ProductData=appDelegateTemp.AdvanceProductData;
            [objMyGlobals hideLoader:self.view];
            //  [tblvw reloadData];
           
            
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
//- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
//{
//    
//    NSInteger page = scrollView.contentOffset.y / scrollView.bounds.size.height;
//    
//    
//    
//    float endScrolling = (scrollView.contentOffset.y + scrollView.frame.size.height);
//    if (endScrolling >= scrollView.contentSize.height)
//    {
//        //Manage Pagination
////        from_Post = from_Data + Page_Number; //Like 10, 20 as you define
////        to_Post = to_Data + Page_Number; //Like 10, 20 as you define
////        
////        //Called Function for You Performing action
////        [self GetDataFrom:from_Post To:to_Post];
//    }
//}
#pragma mark method for Like
-(void)likeButtonClicked:(UIButton*)sender
{
    UIButton *senderButton = (UIButton *)sender;
    if (isLike) {
        [SelectedFavorite addObject:[NSString stringWithFormat:@"%ld",(long)senderButton.tag]];
        NSMutableDictionary *dict=[appDelegateTemp.ProductData objectAtIndex:senderButton.tag];
        NSString *prdid=[dict objectForKey:@"prod_id"];
        [self addItemWishList:prdid];
        [objMyGlobals.arrWishList addObject: [dict objectForKey:@"prod_id"]];
        
        [senderButton setImage:[UIImage imageNamed:@"ic_like"] forState:UIControlStateNormal];
        isLike = NO;
    }else
    {
         NSMutableDictionary *dict=[appDelegateTemp.ProductData objectAtIndex:senderButton.tag];
        [objMyGlobals.arrWishList removeObject: [dict objectForKey:@"prod_id"]];
                NSString *prdid=[dict objectForKey:@"prod_id"];
               [self RemoveItemWishList:prdid];
        [SelectedFavorite removeObject:[NSString stringWithFormat:@"%ld",(long)senderButton.tag]];
        [senderButton setImage:[UIImage imageNamed:@"ic_unlike"] forState:UIControlStateNormal];
        isLike = YES;
    }
}
#pragma mark -UITableview Methods
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if(tableView==self.tblvwDetails)
        
    {
        
    }
    else
    {
        if(tableView==_tblvw)
        {
            TableViewCell *cell;
            NSString *stroptionId;
            NSString *strOptionHeader;
           
           
            NSArray *temp=[child objectAtIndex:indexPath.section];
         cell = (TableViewCell *)[_tblvw cellForRowAtIndexPath:indexPath];
            stroptionId =[NSString stringWithFormat:@"%@",[[temp objectAtIndex:indexPath.row]objectForKey:@"optionId"]];
            strOptionHeader=[NSString stringWithFormat:@"%@",[[temp objectAtIndex:indexPath.row]objectForKey:@"parentLabel"]];
        if ([SelectedIndexs containsObject:stroptionId])// Is selected?
        {
           
            if ([[dictData allKeys] containsObject:strOptionHeader]) {
                NSString *str1=[dictData objectForKey:strOptionHeader];
                if(!([str1 rangeOfString:@","].location == NSNotFound))
                {
                stroptionId =[NSString stringWithFormat:@",%@",stroptionId];
               NSString *str=[str1 stringByReplacingOccurrencesOfString:stroptionId withString:@""];
                    if(str.length>0)
                        [dictData setObject:str forKey:strOptionHeader];
                    else
                        [dictData removeObjectForKey:strOptionHeader];
                }
                else
                {
                    stroptionId =[NSString stringWithFormat:@"%@",str1];
                    str1=[str1 stringByReplacingOccurrencesOfString:stroptionId withString:@""];
                    if(str1.length>0)
                        [dictData setObject:str1 forKey:strOptionHeader];
                    else
                        [dictData removeObjectForKey:strOptionHeader];
                }
            }

            [SelectedIndexs removeObject:stroptionId];
            
            cell.isSelected=false;
            // [cell.btnSelection setImage:nil];
            [cell.btnSelection setImage:[UIImage imageNamed:@"ic_uncheck"] forState:UIControlStateNormal];
        }
        
        
        
        else{
          
            if ([[dictData allKeys] containsObject:strOptionHeader]) {
                NSString *str=[dictData objectForKey:strOptionHeader];
                str=[str stringByAppendingString:[NSString stringWithFormat:@",%@",stroptionId]];
                [dictData setObject:str forKey:strOptionHeader];
            }
            else
            {
                [dictData setObject:stroptionId forKey:strOptionHeader];
            }
            [SelectedIndexs addObject:stroptionId];
            
            cell.isSelected=true;
            // [cell.btnSelection setImage:nil];
            [cell.btnSelection setImage:[UIImage imageNamed:@"ic_check"] forState:UIControlStateNormal];
        }
        }
    }
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    if(tableView == self.tblvwBrands)
//    {
//        return tableData_Brands.count;
//    }
//    else if(tableView == self.tblvwFebric)
//    {
//        return tableData_Febric.count;
//    }
     if(tableView==self.tblvwDetails)
    {
        if(isApplyFilter)
        {
            return filteredData.count;
        }
        else
        return appDelegateTemp.ProductData.count;
      
    }
    else
    {
        NSInteger count=0;
        NSMutableArray *arr=[child objectAtIndex:section];
        count = arr.count;
        return count;
    }
   
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableDictionary *dict;
    if(tableView==self.tblvwDetails)
    {
        static NSString *simpleTableIdentifier = @"CategoryDetailsTblVWCell";
        
        CategoryDetailsTblVWCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
        
        if (cell == nil) {
            cell = [[CategoryDetailsTblVWCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
        }
        
        if(appDelegateTemp.ProductData.count>0)
        {
            dict=[appDelegateTemp.ProductData objectAtIndex:indexPath.row];
            if(isApplyFilter)
            {
             NSMutableDictionary  *dict1=[filteredData objectAtIndex:indexPath.row];
                if(dict1.count>0)
                {
                    
                    NSString *cacheKey = [NSString stringWithFormat:@"%@%ld%ld",[dict1 objectForKey:@"name"], (long)indexPath.row, (long)indexPath.section];
                    NSData *cachedObject = [[CacheController sharedInstance] getCacheForKey:cacheKey];
                    
                    if (cachedObject != nil) {
                        UIImage *img=[UIImage imageWithData:cachedObject];
                        [cell.imgView setImage:img];
                        // [[cell textLabel] setText:@"Got object from cache!"];
                    }
                    
                    else {

                            [cell downloadFile:[NSURL URLWithString:[dict1 objectForKey:@"thumbnail_imageurl"]]
                                  forIndexPath:indexPath];
                      
                    }
                    
                    
//            [ cell.imgView sd_setImageWithURL:[dict1 objectForKey:@"thumbnail_imageurl"]
//                             placeholderImage:[UIImage imageNamed:@"avatar-placeholder.png"]
//                                      options:SDWebImageRefreshCached];
                    
            
            cell.btnLike.tag = indexPath.row;
            [cell.btnLike addTarget:self action:@selector(likeButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
            cell.itemName.text=[NSString stringWithFormat:@"%@",[dict1 objectForKey:@"name"]];
            cell.NewPrices.textColor=[UIColor redColor];
            cell.NewPrices.text = [NSString stringWithFormat:@"₹ %@",[dict1 objectForKey:@"discount_price"]];
            
            
            NSMutableAttributedString *myString1= [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"₹ %@",[dict1 objectForKey:@"price"]]];
            [myString1 addAttribute:NSStrikethroughStyleAttributeName
                              value:@2
                              range:NSMakeRange(0, [myString1 length])];
            
            
            cell.oldPrice.textColor=[UIColor lightGrayColor];
            cell.oldPrice.attributedText = myString1;
            
        }
        cell.btnLike.tag = indexPath.row;
        [cell.btnLike addTarget:self action:@selector(likeButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        NSString *str=[NSString stringWithFormat:@"%@",[dict objectForKey:@"wishlist"]];
                if ([str isEqualToString:@"1"]||[objMyGlobals.arrWishList containsObject:[dict1 objectForKey:@"prod_id"]])// Is selected?
        {
            isLike=false;
            // [cell.btnSelection setImage:nil];
            [cell.btnLike setImage:[UIImage imageNamed:@"ic_like"] forState:UIControlStateNormal];
        }
        else{
            
            
            isLike=true;
            // [cell.btnSelection setImage:nil];
            [cell.btnLike setImage:[UIImage imageNamed:@"ic_unlike"] forState:UIControlStateNormal];
            
        }
        
       
            }
            else
            {
//                [ cell.imgView sd_setImageWithURL:[dict objectForKey:@"thumbnail_imageurl"]
//                                 placeholderImage:[UIImage imageNamed:@"avatar-placeholder.png"]
//                                          options:SDWebImageRefreshCached];
                NSString *cacheKey = [NSString stringWithFormat:@"%@%ld%ld",[dict objectForKey:@"name"], (long)indexPath.row, (long)indexPath.section];
                NSData *cachedObject = [[CacheController sharedInstance] getCacheForKey:cacheKey];
                
                if (cachedObject != nil) {
                    UIImage *img=[UIImage imageWithData:cachedObject];
                    [cell.imgView setImage:img];
                    
                    // [[cell textLabel] setText:@"Got object from cache!"];
                }
                
                else {
                    
                    [cell downloadFile:[NSURL URLWithString:[dict objectForKey:@"thumbnail_imageurl"]]
                          forIndexPath:indexPath];
                    
                }
                cell.btnLike.tag = indexPath.row;
                [cell.btnLike addTarget:self action:@selector(likeButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
                cell.itemName.text=[NSString stringWithFormat:@"%@",[dict objectForKey:@"name"]];
                cell.NewPrices.textColor=[UIColor redColor];
                cell.NewPrices.text = [NSString stringWithFormat:@"₹ %@",[dict objectForKey:@"discount_price"]];
                
                
                NSMutableAttributedString *myString1= [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"₹ %@",[dict objectForKey:@"price"]]];
                [myString1 addAttribute:NSStrikethroughStyleAttributeName
                                  value:@2
                                  range:NSMakeRange(0, [myString1 length])];
                
                
                cell.oldPrice.textColor=[UIColor lightGrayColor];
                cell.oldPrice.attributedText = myString1;
                
            }
            cell.btnLike.tag = indexPath.row;
            [cell.btnLike addTarget:self action:@selector(likeButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
         
            NSString *str=[NSString stringWithFormat:@"%@",[dict objectForKey:@"wishlist"]];
            if ([str isEqualToString:@"1"]||[objMyGlobals.arrWishList containsObject:[dict objectForKey:@"prod_id"]])// Is selected?
            {
                isLike=false;
                // [cell.btnSelection setImage:nil];
                [cell.btnLike setImage:[UIImage imageNamed:@"ic_like"] forState:UIControlStateNormal];
            }
            else{
                
                
                isLike=true;
                // [cell.btnSelection setImage:nil];
                [cell.btnLike setImage:[UIImage imageNamed:@"ic_unlike"] forState:UIControlStateNormal];
                
            }
            
            
                
                
                
            
            }
        return cell;
    }
    else 
    {
        static NSString *cellid=@"TableViewCell";
        TableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellid];
        if (cell==nil) {
            cell=[[TableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellid];
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
            NSMutableArray *arr=[child objectAtIndex:indexPath.section];
            NSMutableDictionary *dict=[arr objectAtIndex:indexPath.row];
            cell.name.text=[NSString stringWithFormat:@"%@",[dict objectForKey:@"optionLabel"]];
            cell.backgroundColor=[UIColor whiteColor];
             cell.selectionStyle=UITableViewCellSelectionStyleNone ;
            
            NSString *stroptionId,*strSelected;
            NSArray *temp=[child objectAtIndex:indexPath.section];
            stroptionId =[NSString stringWithFormat:@"%@",[[temp objectAtIndex:indexPath.row]objectForKey:@"optionId"]];
            strSelected=[NSString stringWithFormat:@"%@",[[temp objectAtIndex:indexPath.row]objectForKey:@"selected"]];
            if ([SelectedIndexs containsObject:stroptionId]||[strSelected isEqualToString:@"1"])// Is selected?
            {
                if (![SelectedIndexs containsObject:stroptionId])// Is selected?
                {
                    [SelectedIndexs addObject:stroptionId];
                }
                cell.isSelected=true;
                [cell.btnSelection setImage:[UIImage imageNamed:@"ic_check"] forState:UIControlStateNormal];
            }
            else{
                cell.isSelected=false;
                // [cell.btnSelection setImage:nil];
                [cell.btnSelection setImage:[UIImage imageNamed:@"ic_uncheck"] forState:UIControlStateNormal];
            }
            
            
        }
        cell.textLabel.textColor=[UIColor blackColor];
        
        /********** Add a custom Separator with cell *******************/
        UIView* separatorLineView = [[UIView alloc] initWithFrame:CGRectMake(15, 40, _tblvw.frame.size.width-15, 1)];
        separatorLineView.backgroundColor = [UIColor blackColor];
        [cell.contentView addSubview:separatorLineView];
        
        return cell;

}
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if(tableView==_tblvw)
        return [sectionTitleArray count];
    else
        return 1;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView==self.tblvwDetails)
    {
        return 92;
    }
  
   else if(tableView==_tblvw)
    {
        if ([[arrayForBool objectAtIndex:indexPath.section] boolValue]) {
            return 40;
        }
        return 0;
    }
    else
    {
        return 0;
    }
   
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(tableView==_tblvw)
    {
    return 40;
    }
    return 0;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    UIView *sectionView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 180,30)];
    sectionView.tag=section;
    UILabel *viewLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 10, _tblvw.frame.size.width-10, 30)];
    viewLabel.backgroundColor=[UIColor whiteColor];
    viewLabel.textColor=[UIColor blackColor];
    viewLabel.font=[UIFont systemFontOfSize:15];
    viewLabel.text=[NSString stringWithFormat:@"%@",[sectionTitleArray objectAtIndex:section]];
    [sectionView addSubview:viewLabel];
    UIImageView *imgView=[[UIImageView alloc]initWithFrame:CGRectMake(viewLabel.frame.size.width-20, 10, 25,25)];
//    if (isTapped)
//    {
//        imgView.image=[UIImage imageNamed:@"ic_minus"];
//    }
//    else
//    {
//        imgView.image=[UIImage imageNamed:@"ic_plus"];
//    }
    
    [sectionView addSubview:imgView];
    /********** Add a custom Separator with Section view *******************/
    UIView* separatorLineView = [[UIView alloc] initWithFrame:CGRectMake(15, 40, _tblvw.frame.size.width-15, 0.5)];
    separatorLineView.backgroundColor = [UIColor blackColor];
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

#pragma mark Pickerview
-(void)setPickerview
{
    viewPicker = [[UIView alloc] initWithFrame:self.view.frame];
    viewPicker.backgroundColor = [UIColor blackColor];
    viewPicker.alpha = 0;
    [self.view addSubview:viewPicker];
    viewContent = [[UIView alloc] initWithFrame:CGRectMake(self.view.frame.origin.x,self.view.frame.size.height ,self.view.frame.size.width,165)];
    UILabel *lbl = [[UILabel alloc]initWithFrame:CGRectMake(0,0,self.view.frame.size.width,35)];
    lbl.text = @"↑ ↓ Sort By";
    lbl.textColor = [UIColor grayColor];
    lbl.textAlignment = NSTextAlignmentCenter;
    lbl.backgroundColor = [UIColor colorWithRed:230.0/255 green:230.0/255 blue:230.0/255 alpha:1.0];
    items =[[NSArray alloc]initWithObjects:@"Select",@"Price - High to Low",@"Price - Low to High",@"Popularity",@"Discount",@"What's New",nil];
    pickerView=[[UIPickerView alloc] initWithFrame:CGRectMake(0,35,self.view.frame.size.width,130)];
    pickerView.delegate = self;
    pickerView.dataSource = self;
    pickerView.showsSelectionIndicator = YES;
    pickerView.backgroundColor = [UIColor whiteColor];
    [pickerView selectRow:0 inComponent:0 animated:YES];
    [viewContent addSubview:lbl];
    [viewContent addSubview:pickerView];
    [self.view addSubview:viewContent];
    [UIView animateWithDuration:0.35 animations:^{
        viewPicker.alpha = 0.65;
        [viewContent setFrame:CGRectMake(self.view.frame.origin.x,self.view.frame.size.height-165 ,self.view.frame.size.width,165)];
    }];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissView)];
    [viewPicker addGestureRecognizer:tap];
}
- (void) dismissView {
    [viewPicker removeFromSuperview];
    [viewContent removeFromSuperview];
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView;
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component;
{
    return [items count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return[items objectAtIndex:row];
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
    if(row==1)
    {
        SortedIndex=(int)row;
        //---Sort dic
        if(!isApplyFilter)
        {
          
            NSArray *sortedArray = [appDelegateTemp.ProductData sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
                return [obj1 valueForKey:@"discount_price"] <= [obj2 valueForKey:@"discount_price"];
            }];
            NSLog(@"%@",sortedArray);
            appDelegateTemp.ProductData=[sortedArray mutableCopy] ;
        }
        else
        {
            NSArray *sortedArray = [filteredData sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
                return [obj1 valueForKey:@"discount_price"] <= [obj2 valueForKey:@"discount_price"];
            }];
            NSLog(@"%@",sortedArray);
            filteredData=[sortedArray mutableCopy] ;
        }
        
    }
    else if(row==2)
    {
        SortedIndex=(int)row;
        if(!isApplyFilter)
        {
            NSArray *sortedArray = [appDelegateTemp.ProductData sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
                return [obj1 valueForKey:@"discount_price"] >= [obj2 valueForKey:@"discount_price"];
            }];
            
            NSLog(@"%@",sortedArray);
            appDelegateTemp.ProductData=[sortedArray mutableCopy] ;
        }
        else
        {
            NSArray *sortedArray = [filteredData sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
                return [obj1 valueForKey:@"discount_price"] >= [obj2 valueForKey:@"discount_price"];
            }];
            
            NSLog(@"%@",sortedArray);
            filteredData=[sortedArray mutableCopy] ;
        }
        
        
    }
    [_categoryCollView reloadData];
    [self.tblvwDetails reloadData];
    [viewContent removeFromSuperview];
    [viewPicker removeFromSuperview];
    
}
-(NSArray *)descriptorWithArray:(NSArray *)data andKey:(NSString *)key

{
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:key ascending:NO];
    
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:&sortDescriptor count:1];
    
    [(NSMutableArray*)data sortUsingDescriptors:sortDescriptors];
    
    return data;
    
    
    
}
#pragma mark other Methods
- (IBAction)btnBackClicked:(id)sender {
    [self.navigationController popViewControllerAnimated:true];
}

- (IBAction)btnSoryBtClicked:(id)sender {
    [self setPickerview];
}

- (IBAction)btnGridToListTapped:(id)sender {
    if(self.tblvwDetails.hidden)
    {
        self.tblvwDetails.hidden=false;
        [ _btnList_Grid setImage:[UIImage imageNamed:@"ic_Grid"] forState:UIControlStateNormal];
        tableData_Details=[[NSMutableArray alloc]initWithObjects:@"Jack&Jones Men's T-shirt",@"Jack&Jones Men's T-shirt",@"Jack&Jones Men's T-shirt",@"Jack&Jones Men's T-shirt",@"Jack&Jones Men's T-shirt",@"Jack&Jones Men's T-shirt", nil];
        [self.tblvwDetails reloadData];
    }
    else
    {
        [ _btnList_Grid setImage:[UIImage imageNamed:@"ic_moreinfo"] forState:UIControlStateNormal];
        [self.categoryCollView reloadData];
        self.tblvwDetails.hidden=true;
    }
    
}

- (IBAction)btnFilterClicked:(id)sender {
    
    mainFilterView = [[UIView alloc]initWithFrame:self.view.frame];
    mainFilterView.backgroundColor = [UIColor blackColor];
    mainFilterView.alpha = 0;
    [self.view addSubview:mainFilterView];
    _viewTrailingConstraints.constant = _viewFilter.frame.size.width - 160;
    [self.view bringSubviewToFront:_viewFilter];
    [UIView animateWithDuration:0.5 animations:^{
        [self.view layoutIfNeeded];
        mainFilterView.alpha = 0.65;
    }];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissView1)];
    [mainFilterView addGestureRecognizer:tap];
    tableData_Brands=[[NSMutableArray alloc]initWithObjects:@"Jack & Johns",@"ven Heusen",@"Levis",@"Addidas",@"Peter England",@"Denim", nil];
    tableData_Febric=[[NSMutableArray alloc]initWithObjects:@"Cotton",@"Silk",@"Raw Silck",@"Polyester", nil];
    SelectedIndexs=[NSMutableArray new];
    [_tblvw reloadData];
    
    //   [_categoryCollView reloadData];
    [_collViewColor reloadData];
    
}
- (void) dismissView1 {
    [mainFilterView removeFromSuperview];
    _viewTrailingConstraints.constant = -160;
    [UIView animateWithDuration:0.5 animations:^{
        [self.view layoutIfNeeded];
        mainFilterView.alpha = 0;
    }];
}
- (IBAction)btnDetailFilterClicked:(id)sender {
}
- (IBAction)sliderValueChanged:(UISlider *)sender {
    _lblValueFilter.text = [NSString stringWithFormat:@"₹ %d",(int)sender.value];
}
- (IBAction)btnCheckoutTapped:(id)sender {
    UIStoryboard *objStoryboard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    CheckoutVC *newView = (CheckoutVC *)[objStoryboard instantiateViewControllerWithIdentifier:@"CheckoutVC"];
    [self.navigationController pushViewController:newView animated:YES];
    
    
}




- (void)checkButtonTapped:(id)sender event:(id)event
{
   /* NSSet *touches = [event allTouches];
    UITouch *touch = [touches anyObject];
    CGPoint currentTouchPosition = [touch locationInView:_tblvwBrands];
    NSIndexPath *indexPath = [_tblvwBrands indexPathForRowAtPoint: currentTouchPosition];
    UIButton *btn=(UIButton *)sender;
    
    NSLog(@"%ld", (long)btn.tag);
    if(![SelectedIndexs containsObject:[NSString stringWithFormat:@"%ld",(long)btn.tag]])
    {
        [SelectedIndexs addObject:[NSString stringWithFormat:@"%ld",(long)btn.tag]];
    }
    else
    {
        [SelectedIndexs addObject:[NSString stringWithFormat:@"%ld",(long)btn.tag]];
    }
    
    btn.selected=!btn.selected;
    */
    
    
}
-(void)buttonChangeSizeBorderColor
{
    
  /*
    _btnXSSize.selected=false;
    _btnSSize.selected=false;
    _btnMSize.selected=false;
    _btnLSize.selected=false;
    _btnXLSize.selected=false;
    _btnXXLSize.selected=false;
    
    _btnXSSize.layer.borderColor = [UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:1.0].CGColor;
    _btnSSize.layer.borderColor = [UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:1.0].CGColor;
    _btnMSize.layer.borderColor = [UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:1.0].CGColor;
    _btnLSize.layer.borderColor = [UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:1.0].CGColor;
    _btnXLSize.layer.borderColor = [UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:1.0].CGColor;
    _btnXXLSize.layer.borderColor = [UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:1.0].CGColor;*/
}


- (IBAction)btnApplyFilterTapped:(id)sender {
    NSLog(@"%@",dictData);
    NSString *str=[NSString stringWithFormat:@"%d-%d",(int)_SliderForPrice.lowerValue,(int)_SliderForPrice.upperValue];
    [dictData setObject:str forKey:@"price"];
    objMyGlobals.user.DataForJason=dictData;
    objMyGlobals.user.IsAppliedCoupon=true;
    
    
    objMyGlobals.user.apikey=[@"ICXE1wOphgKgcyMoHr0hVHbbJ" mutableCopy];
    objMyGlobals.user.pageno=[[NSString stringWithFormat:@"%d",pagenum] mutableCopy];
    //objMyGlobals.user.CustID=_CustID;
    [objMyGlobals showLoaderIn:self.view];
    if([appDelegateTemp checkInternetConnection]==true)
    {
        [objMyGlobals.user GetProductData:^(NSString *str, int status)
         {
             if(status==1)
             {
                 dictForPrice=[NSMutableDictionary new];
                 NSMutableArray*temp= [[appDelegateTemp.FilterData objectAtIndex:0]valueForKey:@"attributes"];
                 
                 dictForPrice=[[appDelegateTemp.FilterData objectAtIndex:0]valueForKey:@"priceRange"];
                 NSLog(@"%@",[dictForPrice objectForKey:@"maxPrice"]);
                 sectionTitleArray=[NSMutableArray new];
                 SelectedIndexs=[[NSMutableArray alloc]init];
                 child=[NSMutableArray new];
               //  dictData=[NSMutableDictionary new];
                 for(int i=0;i<temp.count;i++)
                 {
                     NSMutableDictionary *Parent=[[NSMutableDictionary alloc]initWithDictionary:[temp objectAtIndex:i]];
                     [sectionTitleArray addObject:[Parent objectForKey:@"attributeLabel"]];
                     
                     [ child addObject:[Parent objectForKey:@"attributeValues"]];
                     
                     
                 }
                 
                 for (int i=0; i<[sectionTitleArray count]; i++) {
                     [arrayForBool addObject:[NSNumber numberWithBool:NO]];
                 }
                 _tblvw.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
                 if(SortedIndex>=0)
                 {
                     [self pickerView:pickerView didSelectRow:SortedIndex inComponent:0];
                 }
                 [_tblvw reloadData];
                 [self.categoryCollView reloadData];
                 [objMyGlobals hideLoader:self.view];
                 [_categoryCollView addSubview:indicatorFooter];
                 [_tblvwDetails addSubview:indicatorFooter];
                 [_tblvwDetails reloadData];          
                 
             }
             
             else
             {
                 
                dictForPrice=[NSMutableDictionary new];
                 sectionTitleArray=[NSMutableArray new];
                 child=[NSMutableArray new];
               //  dictData=[NSMutableDictionary new];
                 appDelegateTemp.ProductData=nil;
                 
                 NSMutableArray*temp= [[appDelegateTemp.FilterData objectAtIndex:0]valueForKey:@"attributes"];
                 dictForPrice=[[appDelegateTemp.FilterData objectAtIndex:0]valueForKey:@"priceRange"];
                 NSLog(@"%@",[dictForPrice objectForKey:@"maxPrice"]);
                 
                 for(int i=0;i<temp.count;i++)
                 {
                     NSMutableDictionary *Parent=[[NSMutableDictionary alloc]initWithDictionary:[temp objectAtIndex:i]];
                     [sectionTitleArray addObject:[Parent objectForKey:@"attributeLabel"]];
                     
                     [ child addObject:[Parent objectForKey:@"attributeValues"]];
                 }
                 
                 for (int i=0; i<[sectionTitleArray count]; i++) {
                     [arrayForBool addObject:[NSNumber numberWithBool:NO]];
                 }
                 _tblvw.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
                 [_tblvw reloadData];
                 [self.categoryCollView reloadData];
                 [_tblvwDetails reloadData];
                 [objMyGlobals Displaymsg:self.view msg:str];
                 [objMyGlobals hideLoader:self.view];
                 //  txtPassword.text=@"";
                 //  return;
                
                 //  [Globals ShowAlertWithTitle:@"Error" Message:str ];
             }
         }];
    }
    else
    {
        [objMyGlobals Displaymsg:self.view msg:@"Please check Your Internet Connection"];
        [objMyGlobals hideLoader:self.view];
    }
    
    
  //  filters":{"color":"20,27","price":"4500-5000","shoe_size":"101,102"}}]
  /*  [objMyGlobals showLoaderIn:self.view];
    dispatch_async(dispatch_get_main_queue(), ^{
        
        isApplyFilter=true;
        filterDone=false;
        filteredData=[[NSMutableArray alloc]init];
        int max=(int)_SliderForPrice.upperValue;
        int min=(int)_SliderForPrice.lowerValue;
        
        
        for(int i=0;i<appDelegateTemp.ProductData.count;i++)
        {
            NSMutableDictionary *dict=[appDelegateTemp.ProductData objectAtIndex:i];
            if(isApplyFilter)
            {
                int discPrice=[[dict objectForKey:@"discount_price"] intValue];
                
                if(discPrice>min && discPrice<max)
                {
                    [filteredData addObject:dict];
                    
                    
                }
            }
            if(i==appDelegateTemp.ProductData.count-1)
            {
                filterDone=true;
            }
        }
        //    if(filteredData.count>0){
        //      //  appDelegateTemp.ProductData=filteredData;
        //        [_categoryCollView reloadData];
        //        [self.tblvwDetails reloadData];
        //         [objMyGlobals hideLoader:self.view];
        //    }
        
        
        if(filterDone)
        {
            [objMyGlobals hideLoader:self.view];
            [_categoryCollView reloadData];
            [self.tblvwDetails reloadData];
            
        }
        
        
        
        //    [viewPicker removeFromSuperview];
        //    [viewContent removeFromSuperview];
        //   
        
        
    });
    // appDelegateTemp.ProductData=filteredData;*/
    [self dismissView1];
}
-(void)addItemWishList:(NSString*)prdctid
{
    // NSMutableDictionary *dict=;
  //  objMyGlobals.user.userid=[appDelegateTemp.localDataDic objectForKey:@"userid"];
    objMyGlobals.user.qty=@"1".mutableCopy;
    objMyGlobals.user.apikey=[@"ICXE1wOphgKgcyMoHr0hVHbbJ" mutableCopy];
//    objMyGlobals.user.prod_id=[objMyGlobals.arrWishList objectAtIndex:0];
    objMyGlobals.user.prod_id= prdctid.mutableCopy;
    [objMyGlobals showLoaderIn:self.view];
   
    if([appDelegateTemp checkInternetConnection]==true)
    {
    [objMyGlobals.user addWishList:^(NSString *str, int status)
     {
         if(status==1)
         {
             NSLog(@"WishListAdded Succesfully");
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
-(void)RemoveItemWishList:(NSString*)prdctid
{
       objMyGlobals.user.apikey=[@"ICXE1wOphgKgcyMoHr0hVHbbJ" mutableCopy];
    
    objMyGlobals.user.prod_id= prdctid.mutableCopy;
    [objMyGlobals showLoaderIn:self.view];
    if([appDelegateTemp checkInternetConnection]==true)
    {
        [objMyGlobals.user RemoveFromWishList:^(NSString *str, int status)
         {
             if(status==1)
             {
                 NSLog(@"WishListAdded Succesfully");
                 [objMyGlobals hideLoader:self.view];
                 
             }
             
             else
             {
                 //  [objMyGlobals Displaymsg:self.view msg:@"Invalid Email ID and Password"];
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
- (IBAction)btnClearFilterTapped:(id)sender {
    
   // [self buttonChangeSizeBorderColor];
    [self updateSetValuesSlider];
    SelectedIndexs=[[NSMutableArray alloc]init];
    pagenum=1;
    dictData=[NSMutableDictionary new];
    [self initView];
  //  [_tblvwBrands reloadData];
  //  [_tblvwFebric reloadData];
    [_tblvw reloadData];
    [_categoryCollView reloadData];
    [_collViewColor reloadData];
     [self dismissView1];
}

-(void)DisplayBadge
{
    
    NSString *str=@"0";
    if(![appDelegateTemp.TotalCartItem isEqualToString:str])
    {
        _tempBadge.layer.cornerRadius = _tempBadge.frame.size.width/2;;
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
  
    _btnSearch.hidden=true;
    _btnCart.hidden=true;
    _HeaderTitle.hidden=true;
  _tempBadge.hidden=true;
    _Logo.hidden=true;
    _btnBack.hidden=true;
    _searchBar.layer.zPosition=1;
    _searchBar.hidden=false;
    _searchBar.showsCancelButton = YES;
}
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    
    _btnSearch.hidden=false;
    _btnCart.hidden=false;
    _HeaderTitle.hidden=false;
    _tempBadge.hidden=false;
    _Logo.hidden=false;
     _btnBack.hidden=false;
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
                 
                 _btnSearch.hidden=false;
                 _btnCart.hidden=false;
                 _HeaderTitle.hidden=false;
                _tempBadge.hidden=false;
                 _Logo.hidden=false;
                 _btnBack.hidden=false;
                 objMyGlobals.isSearched=true;
                 [objMyGlobals hideLoader:self.view];
                 [self viewDidLoad];
//                 UIStoryboard *objStoryboard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
//                 CategoryDetailsVC *newView = (CategoryDetailsVC *)[objStoryboard instantiateViewControllerWithIdentifier:@"CategoryDetailsVC"];
//                 [self.navigationController pushViewController:newView animated:YES];
                 
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

@end
