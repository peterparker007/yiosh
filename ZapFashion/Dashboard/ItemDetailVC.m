//
//  ItemDetailVC.m
//  ZapFashion
//
//  Created by dharmesh  on 6/7/17.
//  Copyright © 2017 bhumesh. All rights reserved.
//

#import "ItemDetailVC.h"
#import "ItemCollCell.h"
#import "CheckoutVC.h"
#import "FilterColorCollCell.h"
#import "ProductDetailsImageVC.h"
#import "CacheController.h"

#import "CategoryDetailsVC.h"
#import "ItemTblvwCell.h"
@interface ItemDetailVC ()

@end

@implementation ItemDetailVC
{
      BOOL isLike;
    NSMutableDictionary *savedValue;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    objMyGlobals=[Globals sharedManager];
     isLike=false;
      appDelegateTemp = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    AttributesName=[NSMutableArray new];
    Arr_Options=[[NSMutableArray alloc]init];
    Dict_Option=[NSMutableDictionary new];
    AttributesValue=[NSMutableArray new];
    count=0;
    aryImageData=[[NSMutableArray alloc] init];
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
   
     [self DisplayBadge];
    [self GetData];
}
-(void)GetData
{

  [objMyGlobals showLoaderIn:self.view];
 
    if([appDelegateTemp checkInternetConnection]==true)
    {[objMyGlobals.user GetProductDetails:^(NSString *str, int status){
        if(status==1)
        {
               [objMyGlobals Displaymsg:self.view msg:str];
            _DataDic=[appDelegateTemp.ProductDetailsData objectAtIndex:0];
            aryImageData=  [_DataDic valueForKey:@"multiple_images"];
            NSMutableArray *temp=[appDelegateTemp.AttributeData objectAtIndex:0];
            for(int i=0;i<temp.count;i++)
            {
                NSMutableDictionary *Parent=[[NSMutableDictionary alloc]initWithDictionary:[temp objectAtIndex:i]];
                [AttributesName addObject:[Parent objectForKey:@"attributeCode"]];
                
                [ AttributesValue addObject:[Parent objectForKey:@"attributeValues"]];
            }
            for (int i=0; i<[temp count]; i++) {
                [Arr_Options addObject:@"0"];
            }
            ItemTblvwCell *cell = [self.tblvw dequeueReusableCellWithIdentifier:@"ItemTblvwCell"];
            _heightTblVw.constant=cell.frame.size.height*AttributesName.count;
            _pageControl.numberOfPages = aryImageData.count;
            if([_DataDic objectForKey:@"discount_price"]==[_DataDic objectForKey:@"price"]){
                _lblActualPrice.hidden=true;
            }
            else{
                NSString *tempstr1=[NSString stringWithFormat:@"%@",[_DataDic objectForKey:@"price"]];
                NSMutableAttributedString *myString1= [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"₹%@ ",tempstr1]];
                [myString1 addAttribute:NSStrikethroughStyleAttributeName
                                  value:@2
                                  range:NSMakeRange(0, [myString1 length])];
                _lblActualPrice.attributedText = myString1;
            }
            _lblItemName.text=[_DataDic valueForKey:@"name"];
            _lblDiscountPrice.text=[NSString stringWithFormat:@"%@",[_DataDic objectForKey:@"discount_price"]];
            _lblDescription.text=[_DataDic valueForKey:@"description"];
            [_btnLikeObj addTarget:self
                       action:@selector(likeButtonClicked:)
             forControlEvents:UIControlEventTouchUpInside];
            NSString *str=[NSString stringWithFormat:@"%@",[_DataDic objectForKey:@"wishlist"]];
            in_stock=[[_DataDic objectForKey:@"stock_qty"] intValue];
            _lblStock.text=[NSString stringWithFormat:@"Stock : %d",in_stock];
            if ([str isEqualToString:@"1"])// Is selected?
            {
                isLike=true;
                [ _btnLikeObj setImage:[UIImage imageNamed:@"ic_like"] forState:UIControlStateNormal];
            }
            
         
            [objMyGlobals hideLoader:self.view];
            [_collItemView reloadData];
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
#pragma mark -UITableview Delegate Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return AttributesName.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"ItemTblvwCell";
    
    ItemTblvwCell *cell = [self.tblvw dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[ItemTblvwCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    cell.lblAttrName.text=[AttributesName objectAtIndex:indexPath.row];
  
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
}
#pragma mark method for Like
-(void)likeButtonClicked:(UIButton*)sender
{
    
    if (!isLike)
    {
        NSString *prdid=[_DataDic objectForKey:@"prod_id"];
        [self addItemWishList:prdid];
        [_btnLikeObj setImage:[UIImage imageNamed:@"ic_like"] forState:UIControlStateNormal];
        isLike=true;
       
    }else
    {
        NSString *prdid=[_DataDic objectForKey:@"prod_id"];
        [self RemoveItemWishList:prdid];
        [_btnLikeObj setImage:[UIImage imageNamed:@"ic_unlike"] forState:UIControlStateNormal];
         isLike=false;
    }
}
-(void)addItemWishList:(NSString*)prdctid
{
    objMyGlobals.user.qty=@"1".mutableCopy;
    objMyGlobals.user.apikey=[@"ICXE1wOphgKgcyMoHr0hVHbbJ" mutableCopy];
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
                 [objMyGlobals Displaymsg:self.view msg:str];
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
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"Data.plist"];
    savedValue = [[NSMutableDictionary alloc] initWithContentsOfFile: path];
 [_TopView setBackgroundColor: [self colorWithHexString:[savedValue valueForKey:@"header_color"]]];
    [_btnAddToBag setBackgroundColor:[self colorWithHexString:[savedValue valueForKey:@"prod_add_bag_btn_col"]]];
    [_btnBuyNow setBackgroundColor:[self colorWithHexString:[savedValue valueForKey:@"prod_buy_now_btn_col"]]];
     [_btnAddToBag setTitleColor:[self colorWithHexString:[savedValue valueForKey:@"prod_add_bag_txt_col"]] forState:UIControlStateNormal];
     [_btnBuyNow setTitleColor:[self colorWithHexString:[savedValue valueForKey:@"prod_buy_now_txt_col"]] forState:UIControlStateNormal];
    if(appDelegateTemp.CartData.count>0)
    {
        [self DisplayBadge];
    }
    else
    {
       button.frame = CGRectMake(self.view.frame.size.width-25,-50,15,15);
//        self.navigationItem.leftBarButtonItems = nil;
//        [button removeFromSuperview];
    }
    [_scrollView setContentSize:CGSizeMake(self.view.frame.size.width, 500)];
      [_scrlsubvw setBackgroundColor:[self colorWithHexString:[savedValue valueForKey:@"prod_card_bg_col"]]];
    [_lblDescription setTextColor:[self colorWithHexString:[savedValue valueForKey:@"prod_text_col"]] ];
    [_lblItemName setTextColor:[self colorWithHexString:[savedValue valueForKey:@"prod_name_col"]] ];
    [_lblActualPrice setTextColor:[self colorWithHexString:[savedValue valueForKey:@"prod_old_price_col"]] ];
    [_lblDiscountPrice setTextColor:[self colorWithHexString:[savedValue valueForKey:@"prod_price_col"]] ];
    [_lblQTYTitle setTextColor:[self colorWithHexString:[savedValue valueForKey:@"prod_attr_tit_col"]] ];
    [_lblDescriptionTitle setTextColor:[self colorWithHexString:[savedValue valueForKey:@"prod_attr_tit_col"]] ];
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
//    frame1=[objMyGlobals getXYPositions:[savedValue valueForKey:@"page_title_position"]];
//    _HeaderTitle.frame=[objMyGlobals currentDevicePositions:CGRectMake(frame1.origin.x, frame1.origin.y, 105, 21) vwRect:self.view.frame];
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
-(void)viewDidAppear:(BOOL)animated
{
   
}
- (UIColor *)randomColor
{
    NSInteger aRedValue = arc4random()%255;
    NSInteger aGreenValue = arc4random()%255;
    NSInteger aBlueValue = arc4random()%255;
    return  [UIColor colorWithRed:aRedValue/255.0f green:aGreenValue/255.0f blue:aBlueValue/255.0f alpha:1.0f];
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (collectionView.tag == 100)
    {
    return aryImageData.count;
    }
    else
    {
   
        NSArray *arr=[AttributesValue objectAtIndex:count];
        count=count+1;
        return arr.count;
     
    }
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (collectionView.tag==100)
    {
        static NSString *identifier = @"ItemCell";
        ItemCollCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
        NSDictionary *dic=[aryImageData objectAtIndex:indexPath.row];
        //cell.backgroundView.backgroundColor = ;
        [cell setBackgroundColor:[self colorWithHexString:[savedValue valueForKey:@"cat_card_bg_col"]]];
//        [cell.imgItemView sd_setImageWithURL:[dic objectForKey:@"multiple"]
//                            placeholderImage:[UIImage imageNamed:@"avatar-placeholder.png"]
//                                     options:SDWebImageRefreshCached];
        NSString *cacheKey = [NSString stringWithFormat:@"%@_%ld%ld",[_DataDic objectForKey:@"prod_id"],(long)indexPath.row, (long)indexPath.section];
        NSData *cachedObject = [[CacheController sharedInstance] getCacheForKey:cacheKey];
        
        if (cachedObject != nil) {
            UIImage *img=[UIImage imageWithData:cachedObject];
            [cell.imgItemView setImage:img];
            // [[cell textLabel] setText:@"Got object from cache!"];
        }
        
        else {
            
            [cell downloadFile:[NSURL URLWithString:[dic objectForKey:@"multiple"]]
                  forIndexPath:indexPath cacheKey:cacheKey];
            
        }
        return cell;
    }
    else if(collectionView.tag==200){
        static NSString *identifier = @"ColorCell";
        
        FilterColorCollCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
        cell.tag=count-1;
         if([[AttributesName objectAtIndex:count-1]isEqualToString:@"color" ])
          cell.viewColor.backgroundColor = [self randomColor];
        else
        {
             NSArray *arr=[AttributesValue objectAtIndex:count-1];
            cell.lblSize.text=[[arr objectAtIndex:indexPath.row] valueForKey:@"optionLabel"];
        }
        cell.viewColor.layer.cornerRadius = 1.0f;
          cell.viewColor.layer.borderColor = [UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:1.0].CGColor;
        return cell;
    }
    else 
    {
        static NSString *identifier = @"SizeCell";
        
        FilterColorCollCell *cell = [_collSizeView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
        
        cell.viewColor.backgroundColor = [UIColor blackColor];
        return cell;
    }
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    //    CGFloat cellSize1 = self.categoryCollView.frame.size.height - padding;
    if (collectionView.tag == 100)
    {
        return CGSizeMake(_collItemView.frame.size.width, _collItemView.frame.size.height);
    }
    else
    {
        return CGSizeMake(40,40);
    }
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if(collectionView.tag==100){
        UIStoryboard *objStoryboard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
       ProductDetailsImageVC  *newView = (ProductDetailsImageVC *)[objStoryboard instantiateViewControllerWithIdentifier:@"ProductDetailsImageVC"];
        newView.TitleString=[_lblItemName.text mutableCopy];
        newView.SelectedIndex=(int)indexPath.row;
        newView.arrImageData=aryImageData;
        [self.navigationController pushViewController:newView animated:YES];
        
    }
    
    else if(collectionView.tag==200){
    FilterColorCollCell *cell = (FilterColorCollCell*)[collectionView cellForItemAtIndexPath:indexPath];
    NSMutableArray *temp=[appDelegateTemp.AttributeData objectAtIndex:0];
    NSLog(@"%@",[temp objectAtIndex:cell.tag]);
    NSArray *arr=[AttributesValue objectAtIndex:cell.tag];
    NSLog(@"%@",[[arr objectAtIndex:indexPath.row]valueForKey:@"optionId"]);
   
    [Dict_Option setObject:[[temp objectAtIndex:cell.tag]valueForKey:@"attributeId"] forKey:@"attribute_id"];
     [Dict_Option setObject:[[arr objectAtIndex:indexPath.row]valueForKey:@"optionId"] forKey:@"attribute_val"];
    [Arr_Options replaceObjectAtIndex:cell.tag withObject:[Dict_Option copy]];
    cell.viewColor.layer.borderWidth=1.0f;
    cell.viewColor.layer.borderColor=[UIColor darkGrayColor].CGColor;
    self.selectedIndexPath = indexPath;
    }
}
-(void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
  
    FilterColorCollCell *cell = (FilterColorCollCell*)[collectionView cellForItemAtIndexPath:indexPath];
    cell.viewColor.layer.cornerRadius = 1.0f;
    cell.viewColor.layer.borderColor = [UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:1.0].CGColor;
    self.selectedIndexPath = nil;
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
- (IBAction)btnFavouriteClicked:(id)sender {
}

- (IBAction)btnBackClicked:(id)sender {
    [self.navigationController popViewControllerAnimated:true];

}
-(void)buttonChangeSizeBorderColor
{
    _btnXSSize.layer.borderColor = [UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:1.0].CGColor;
    _btnSSize.layer.borderColor = [UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:1.0].CGColor;
    _btnMSize.layer.borderColor = [UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:1.0].CGColor;
    _btnLSize.layer.borderColor = [UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:1.0].CGColor;
    _btnXLSize.layer.borderColor = [UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:1.0].CGColor;
    _btnXXLSize.layer.borderColor = [UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:1.0].CGColor;
}
-(void)buttonChangeColorBorderColor
{
    _btnBlackColor.layer.borderColor = [UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:1.0].CGColor;
    _btnRedColor.layer.borderColor = [UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:1.0].CGColor;
    _btnBlueColor.layer.borderColor = [UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:1.0].CGColor;
    _btnSkyBlueColor.layer.borderColor = [UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:1.0].CGColor;
    _btnYellowColor.layer.borderColor = [UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:1.0].CGColor;
    _btnGreenColor.layer.borderColor = [UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:1.0].CGColor;
}
- (IBAction)btnSizeClicked:(id)sender {
    [self buttonChangeSizeBorderColor];
    UIButton *btn = (UIButton *)sender;
    btn.layer.borderColor = [UIColor darkGrayColor].CGColor;

    if (btn.tag == 10)
    {
        
    }
    else if (btn.tag == 11)
    {
    }
    else if (btn.tag == 12)
    {
    }
    else if (btn.tag == 13)
    {
    }
    else if (btn.tag == 14)
    {
    }
    else if (btn.tag == 15)
    {
    }
}

- (IBAction)btnColorClicked:(id)sender {
    [self buttonChangeColorBorderColor];
    UIButton *btn = (UIButton *)sender;
    btn.layer.borderColor = [UIColor darkGrayColor].CGColor;
    if (btn.tag == 20)
    {
        
    }
    else if (btn.tag == 21)
    {
        
    }
    else if (btn.tag == 22)
    {
        
    }
    else if (btn.tag == 23)
    {
        
    }
    else if (btn.tag == 24)
    {
        
    }
    else if (btn.tag == 25)
    {
        
    }
}

- (IBAction)btnQuantityClicked:(id)sender {
    UIButton *btn = (UIButton *)sender;
    int current = [_lblQuantity.text intValue];
    if (btn.tag == 30)
    {
        if(current>1)
            current = current - 1;
        _lblQuantity.text = [NSString stringWithFormat:@"%d", current];
    }
    else if (btn.tag == 31)
    {
        if(current<in_stock)
            current = current + 1;
        _lblQuantity.text = [NSString stringWithFormat:@"%d", current];
    }
}

- (IBAction)btnBuyNow:(id)sender {
}

- (IBAction)btnAddtoBag:(id)sender {
      [self addtocart];
}
- (IBAction)btnCheckoutTapped:(id)sender {
    UIStoryboard *objStoryboard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    CheckoutVC *newView = (CheckoutVC *)[objStoryboard instantiateViewControllerWithIdentifier:@"CheckoutVC"];
    newView.arrCart=_DataDic;
    [self.navigationController pushViewController:newView animated:YES];
}
-(void)addtocart
{
    objMyGlobals.user.userid=[appDelegateTemp.localDataDic objectForKey:@"userid"];
    objMyGlobals.user.apikey=[@"ICXE1wOphgKgcyMoHr0hVHbbJ" mutableCopy];
    objMyGlobals.user.prod_id=[_DataDic objectForKey:@"prod_id"];
    objMyGlobals.user.qty=[[NSString stringWithFormat:@"%@",_lblQuantity.text] mutableCopy];
    objMyGlobals.user.EditPincode=[@"380054" mutableCopy];
    objMyGlobals.user.ArrJasonData=Arr_Options;
    // [sharedManager showLoaderIn:self.view];
  [objMyGlobals showLoaderIn:self.view];
    if([appDelegateTemp checkInternetConnection]==true)
    {
    [objMyGlobals.user AddToCart:^(NSString *str, int status){
        if(status==1)
        {
            [self DisplayBadge];
            [objMyGlobals Displaymsg:self.view msg:str];
            [objMyGlobals hideLoader:self.view];
        }
        else
        {
            [objMyGlobals Displaymsg:self.view msg:str];
            [objMyGlobals hideLoader:self.view];
        }
    }];
    }
    else{
        [objMyGlobals Displaymsg:self.view msg:@"Please check Your Internet Connection"];
         [objMyGlobals hideLoader:self.view];
        
    }

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
    _btnBack.hidden=true;
    _tempBadge.hidden=true;
    _Logo.hidden=true;
 
    _searchBar.layer.zPosition=1;
    _searchBar.hidden=false;
    _searchBar.showsCancelButton = YES;
}
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
  
    _btnSearch.hidden=false;
    _btnCart.hidden=false;
   _btnBack.hidden=false;
    _tempBadge.hidden=false;
    _Logo.hidden=false;
  
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
                _btnBack.hidden=false;
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

@end
