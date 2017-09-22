//
//  ProductDetailsImageVC.h
//  ZapFashion
//
//  Created by bhumesh on 9/1/17.
//  Copyright © 2017 bhumesh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface ProductDetailsImageVC : UIViewController
{
    AppDelegate *appDelegateTemp;
    int Prev,first;
}
@property (strong, nonatomic) IBOutlet UICollectionView *collItemView;
@property (strong, nonatomic) IBOutlet UICollectionView *collectionvw;
@property (strong, nonatomic) IBOutlet UIPageControl *pageControl;
@property (strong, nonatomic) IBOutlet UIButton *btnBack;
@property (strong, nonatomic) IBOutlet UIView *TopView;
@property (strong, nonatomic) IBOutlet UILabel *HeaderTitle;
@property (strong, nonatomic)  NSMutableArray *arrImageData;
@property (strong, nonatomic)  NSMutableString *TitleString;
@property(nonatomic, assign) int  SelectedIndex;
- (IBAction)btnBackClicked:(id)sender;
//-(void)GetData:(NSString*)type;
//-(void)GetData;
@end
