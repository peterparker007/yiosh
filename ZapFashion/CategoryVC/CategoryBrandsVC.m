//
//  CategoryBrandsVC.m
//  ZapFashion
//
//  Created by bhumesh on 6/14/17.
//  Copyright © 2017 bhumesh. All rights reserved.
//

#import "CategoryBrandsVC.h"
#import "CategoryBrandsCell.h"
#import "CategoryDetailsVC.h"
#import "CheckoutVC.h"
#import "Globals.h"
#import "AppDelegate.h"
#import "CacheController.h"

@interface CategoryBrandsVC ()

@end

@implementation CategoryBrandsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    appDelegateTemp = (AppDelegate *)[[UIApplication sharedApplication]delegate];
      [self initView];
    
    _TitleLabel.text=_lblTitle;
    arrSize=[NSMutableArray arrayWithObjects:@"160",@"80",@"80",@"80",@"80",@"160",@"160",@"80",@"80",@"80",@"80",@"160",@"160",@"80",@"80", nil];
    arrImages=[[NSMutableArray alloc]init];
    arrProductImage=[[NSMutableArray alloc]init];
  
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"Data.plist"];
    NSMutableDictionary *savedValue = [[NSMutableDictionary alloc] initWithContentsOfFile: path];
 [_TopView setBackgroundColor: [self colorWithHexString:[savedValue valueForKey:@"header_color"]]];
    
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
-(void)initView
{
    Globals *objMyGlobals;
    objMyGlobals=[Globals sharedManager];
    
    objMyGlobals.user.apikey=[@"ICXE1wOphgKgcyMoHr0hVHbbJ" mutableCopy];
    objMyGlobals.user.CatID=_CatID;
  [objMyGlobals showLoaderIn:self.view];
    if([appDelegateTemp checkInternetConnection]==true)
    {
    [objMyGlobals.user GetProductData:^(NSString *str, int status)
     {
         if(status==1)
         {
              [objMyGlobals hideLoader:self.view];
         
             for(int i=0;i<appDelegateTemp.ProductData.count;i++)
             {
                 NSMutableDictionary *dict=[appDelegateTemp.ProductData objectAtIndex:i];
                 [arrProductImage addObject:[dict objectForKey:@"image_url"]];
             }
             // appDelegateTemp.ProductData
               [self.collectionVW reloadData];
               [objMyGlobals hideLoader:self.view];
           
            
         }
         
         else
         {
             [objMyGlobals Displaymsg:self.view msg:@"Invalid Email ID and Password"];
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
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return arrProductImage.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
   if(collectionView.tag==1000)
   {
        CGFloat padding = 10;
        CGFloat cellSize = self.collectionVW.frame.size.width - padding;
        return CGSizeMake(cellSize / 2 , (self.collectionVW.frame.size.height-padding)/2);
      
   }
   else
    {
        if([[NSString stringWithFormat:@"%@",arrSize[indexPath.row]]  isEqualToString:  @"80"])
        {
        CGFloat padding = 10;
        CGFloat cellSize = self.collectionVW.frame.size.width - padding;
                [arrImages addObject:@"JeansAd"];
        return CGSizeMake(cellSize / 4.3 , (self.collectionVW.frame.size.height-padding)/3);
         
            
        }
        else
        {
            CGFloat padding = 10;
            CGFloat cellSize = self.collectionVW.frame.size.width - padding;
            [arrImages addObject:@"TshirtAd"];
            return CGSizeMake(cellSize / 2 , (self.collectionVW.frame.size.height-padding)/3);
            
        }
    }
  //  return CGSizeMake(100.0, 100.0);
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
   
   
    if(collectionView.tag==1000)
    {
        
        static NSString *identifier1 = @"CategoryBrandsCell";
        
        CategoryBrandsCell *cell1 = [collectionView dequeueReusableCellWithReuseIdentifier:identifier1 forIndexPath:indexPath];
            cell1.lblTag.text=@"TOP WEAR";
     //   cell1.imgVW.image
//        [cell1.imgVW sd_setImageWithURL:[arrProductImage objectAtIndex:indexPath.row]
//                       placeholderImage:[UIImage imageNamed:@"avatar-placeholder.png"]
//                                options:SDWebImageRefreshCached];
        NSString *cacheKey = [NSString stringWithFormat:@"%ld%ld",(long)indexPath.row, (long)indexPath.section];
        NSData *cachedObject = [[CacheController sharedInstance] getCacheForKey:cacheKey];
        
        if (cachedObject != nil) {
            UIImage *img=[UIImage imageWithData:cachedObject];
            [cell1.imgVW setImage:img];
            // [[cell textLabel] setText:@"Got object from cache!"];
        }
        
        else {
            
            [cell1 downloadFile:[NSURL URLWithString:[arrProductImage objectAtIndex:indexPath.row]]
                  forIndexPath:indexPath cacheKey:cacheKey];
            
        }
      
       return cell1;
    
        
    }
    
   
   else
    { static NSString *identifier2 = @"CategoryBrandsCell1";
        
        CategoryBrandsCell *cell2 = [collectionView dequeueReusableCellWithReuseIdentifier:identifier2 forIndexPath:indexPath];
       
        cell2.ImgVW2.image=[UIImage imageNamed:arrImages[indexPath.row]];
         return cell2;
    }
    
    
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if(collectionView.tag==1000)
    {
        
            UIStoryboard *objStoryboard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
           [appDelegateTemp.ProductData removeAllObjects];
            CategoryDetailsVC *newView = (CategoryDetailsVC *)[objStoryboard instantiateViewControllerWithIdentifier:@"CategoryDetailsVC"];
            [self.navigationController pushViewController:newView animated:YES];
        
    }
    
}
- (IBAction)btnBackTapped:(id)sender {
    [self.navigationController popViewControllerAnimated:true];
}

- (IBAction)btnCartTapped:(id)sender {
    UIStoryboard *objStoryboard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    CheckoutVC *newView = (CheckoutVC *)[objStoryboard instantiateViewControllerWithIdentifier:@"CheckoutVC"];
    [self.navigationController pushViewController:newView animated:YES];
}
@end
