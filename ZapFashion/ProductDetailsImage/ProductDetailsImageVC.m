//
//  ProductDetailsImageVC.m
//  ZapFashion
//
//  Created by bhumesh on 9/1/17.
//  Copyright © 2017 bhumesh. All rights reserved.
//

#import "ProductDetailsImageVC.h"
#import "AppDelegate.h"
#import "ItemCollCell.h"
#import "CategoryDetailCollCell.h"
#import "CacheController.h"
@interface ProductDetailsImageVC ()

@end

@implementation ProductDetailsImageVC
@synthesize arrImageData;
- (void)viewDidLoad {
    // Do any additional setup after loading the view.
    Prev=-1;
    first=1;
    appDelegateTemp = (AppDelegate *)[[UIApplication sharedApplication]delegate];
      _pageControl.numberOfPages=arrImageData.count;
    _HeaderTitle.text=_TitleString;
    [_collectionvw reloadData];
     [_collItemView reloadData];
   // [_collectionvw addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionOld context:NULL];
    
    
}
//- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary  *)change context:(void *)context
//{
//   
//   [self collectionView:_collectionvw didSelectItemAtIndexPath:[NSIndexPath indexPathForItem:(int)_SelectedIndex inSection:0]];
//    [self scrollViewDidEndDecelerating:_collectionvw];
//    
//}
//
//- (void)dealloc
//{
//    [_collectionvw removeObserver:self forKeyPath:@"contentSize" context:NULL];
//}
-(void)viewWillAppear:(BOOL)animated
{
     first=1;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"Data.plist"];
    NSMutableDictionary *savedValue = [[NSMutableDictionary alloc] initWithContentsOfFile: path];
    [_TopView setBackgroundColor: [self colorWithHexString:[savedValue valueForKey:@"header_color"]]];
    [_HeaderTitle setTextColor:[self colorWithHexString:[savedValue valueForKey:@"header_text_color"]]];
     
   
   
}
- (IBAction)btnBackClicked:(id)sender {
    [self.navigationController popViewControllerAnimated:true];
    
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
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
// Set Data in Collection View.
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
   return arrImageData.count;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    //    CGFloat cellSize1 = self.categoryCollView.frame.size.height - padding;
    
    if (collectionView.tag == 100)
    {
        return CGSizeMake(_collItemView.frame.size.width, _collItemView.frame.size.height);
    }
    else
    {
        
        CGFloat padding = 10;
        CGFloat cellSize = self.collectionvw.frame.size.width - padding;
        return CGSizeMake(cellSize / 5 , (self.collectionvw.frame.size.height));
        
    }
}
- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    if(indexPath.row==arrImageData.count-1 && first)
    {
        
         [_collectionvw scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
         [self collectionView:_collectionvw didSelectItemAtIndexPath:[NSIndexPath indexPathForItem:_SelectedIndex inSection:0]];
    }
    
        
    
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (collectionView.tag==100)
    {
        static NSString *identifier = @"ItemCell";
        ItemCollCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
        
        NSString *cacheKey = [NSString stringWithFormat:@"%ld%ld", (long)indexPath.row, (long)indexPath.section];
        
        [cell downloadFile:[NSURL URLWithString:[[arrImageData objectAtIndex:indexPath.row] valueForKey:@"multiple"]]
              forIndexPath:indexPath cacheKey:cacheKey];
        return cell;
    }
    else
    {
        static NSString *identifier1 = @"small";
      
        
        CategoryDetailCollCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier1 forIndexPath:indexPath];
        //        [cell.imgItemView sd_setImageWithURL:[dict objectForKey:@"thumbnail_imageurl"]
        //                        placeholderImage:[UIImage imageNamed:@"avatar-placeholder.png"]
        //                                 options:SDWebImageRefreshCached];
        NSString *cacheKey = [NSString stringWithFormat:@"%ld%ld", (long)indexPath.row, (long)indexPath.section];
        
        [cell downloadFile:[NSURL URLWithString:[[arrImageData objectAtIndex:indexPath.row] valueForKey:@"multiple"]]
              forIndexPath:indexPath cacheKey:cacheKey];
     
        
       
        return cell;
    }
    
}
//Collection view item Did Select
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView.tag!=100)
    {
        if(Prev!=-1)
        {
            first=0;
            [self collectionView:_collectionvw didDeselectItemAtIndexPath:[NSIndexPath indexPathForItem:Prev inSection:0]];
        }
          CategoryDetailCollCell *cell = (CategoryDetailCollCell*)[collectionView cellForItemAtIndexPath:indexPath];
        CGFloat pageWidth = _collItemView.frame.size.width;
        CGPoint newOffset;
               _pageControl.currentPage = indexPath.row;
        Prev=(int)_pageControl.currentPage ;
        newOffset.y = _collItemView.contentOffset.y;
            newOffset.x = pageWidth*indexPath.row;
         [self.collItemView setContentOffset:newOffset animated:YES];
        cell.layer.borderWidth = 1  ;
        cell.layer.borderColor = [UIColor grayColor].CGColor;

       
    }
}
- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    CategoryDetailCollCell *cell = (CategoryDetailCollCell*)[collectionView cellForItemAtIndexPath:indexPath];
    cell.layer.borderWidth = 1  ;
    cell.layer.borderColor = [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0].CGColor;
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat pageWidth = _collItemView.frame.size.width;
    float currentPage = _collItemView.contentOffset.x / pageWidth;
    if(Prev!=-1)
    {
        [self collectionView:_collectionvw didDeselectItemAtIndexPath:[NSIndexPath indexPathForItem:Prev inSection:0]];
    }
     Prev=currentPage;
//    if(currentPage==4)
//    {
//        CGFloat pageWidth = _collItemView.frame.size.width;
//        CGPoint newOffset;
//        newOffset.y = _collItemView.contentOffset.y;
//        newOffset.x = pageWidth/5;
//        [self.collectionvw setContentOffset:newOffset animated:YES];
//        
//    }
    [self collectionView:_collectionvw didSelectItemAtIndexPath:[NSIndexPath indexPathForItem:currentPage inSection:0]];
    if (0.0f != fmodf(currentPage, 1.0f))
    {
        _pageControl.currentPage = currentPage + 1;
    }
    else
    {
        _pageControl.currentPage = currentPage;
    }
}

@end
