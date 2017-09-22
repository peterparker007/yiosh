//
//  CheckoutVC.m
//  ZapFashion
//
//  Created by bhumesh on 6/8/17.
//  Copyright © 2017 bhumesh. All rights reserved.
//

#import "CheckoutVC.h"
#import "CheckouttblvwCell.h"

#import "ViewController.h"
#import "CacheController.h"
#import "AddressListVC.h"
@interface CheckoutVC ()
@end

@implementation CheckoutVC{
     DropDownListView * Dropobj;
    NSInteger selectedIndex;
    NSArray *items;
    NSMutableArray *arrQTY;
    NSMutableDictionary *savedValue ;
}
@synthesize tblvw;
- (void)viewDidLoad {
    [super viewDidLoad];
       objMyGlobals=[Globals sharedManager];
    appDelegateTemp = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    //Get Cart Data.
    [self GetCartData];
  [self.navigationController setNavigationBarHidden:YES];
   
   
 /*   int total=[[_arrCart objectForKey:@"discount_price"] intValue];
    _totalPrice.text=[NSString stringWithFormat:@"₹ %d",total+50];
    _subtotal.text=[NSString stringWithFormat:@"₹ %d",total];
    _FullTotal.text= _totalPrice.text;*/
   
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
    [_btnProcced setBackgroundColor:[self colorWithHexString:[savedValue valueForKey:@"proceed_pay_btn_col"]]];
    [_scrlsubvw setBackgroundColor:[self colorWithHexString:[savedValue valueForKey:@"bg_color"]]];
    [self SetConfigForTopView];
}
-(void)SetConfigForTopView
{
    
    _TopView.frame=[objMyGlobals currentDevicePositions:CGRectMake(0, 0, 381, 50) vwRect:self.view.frame];
  
    
    CGRect frame1=[objMyGlobals getXYPositions:[savedValue valueForKey:@"page_title_position"]];
    _HeaderTitle.frame=[objMyGlobals currentDevicePositions:CGRectMake(frame1.origin.x, frame1.origin.y, 105, 21) vwRect:self.view.frame];
    frame1=[objMyGlobals getXYPositions:[savedValue valueForKey:@"logo_position"]];
    _Logo.frame=[objMyGlobals currentDevicePositions:CGRectMake(frame1.origin.x, frame1.origin.y, 77, 18) vwRect:self.view.frame];
    
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
//Getting Cart Data From Server.
-(void)GetCartData
{
  [objMyGlobals showLoaderIn:self.view];
    if([appDelegateTemp checkInternetConnection]==true)
    {[objMyGlobals.user DisplayCart:^(NSString *str, int status){
        if(status==1)
        {
            [objMyGlobals Displaymsg:self.view msg:str];
            if(appDelegateTemp.CartData.count>0)
            {
            _lblItemCount.text=[NSString stringWithFormat:@"%lu Items in your bag.",(unsigned long)appDelegateTemp.CartData.count];
              
            }
            else
                 _lblItemCount.text=[NSString stringWithFormat:@"No more items in your bag."];
            [self calculateBill];
            [tblvw reloadData];
            [objMyGlobals hideLoader:self.view];
        }        
        else
        {
            if(appDelegateTemp.CartData.count>0)
            {
                _lblItemCount.text=[NSString stringWithFormat:@"%lu Items in your bag.",(unsigned long)appDelegateTemp.CartData.count];
                
            }
            else
                _lblItemCount.text=[NSString stringWithFormat:@"No more items in your bag."];
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
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    
    CGPoint newOffset;
    newOffset.x = 0;
    newOffset.y = textField.frame.origin.y;
    [self.scrollView setContentOffset:newOffset animated:YES];
    
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    CGPoint newOffset;
    newOffset.x = 0;
    newOffset.y = 0;
    [self.scrollView setContentOffset:newOffset animated:YES];
    NSInteger nextTag = textField.tag + 1;
    // Try to find next responder
    UIResponder* nextResponder = [textField.superview viewWithTag:nextTag];
    if (nextResponder) {
        // Found next responder, so set it.
        [nextResponder becomeFirstResponder];
    } else {
        // Not found, so remove keyboard.
        [textField resignFirstResponder];
    }
    return NO;
}
//Apply Coupon Data.
-(void)ApplyCouponData:(NSString*)flag
{
  [objMyGlobals showLoaderIn:self.view];
    //  objMyGlobals.user.userid=[appDelegateTemp.localDataDic objectForKey:@"userid"];
    objMyGlobals.user.flag=[flag mutableCopy];
    objMyGlobals.user.CouponCode=[_txtCouponCode.text mutableCopy];
    if([appDelegateTemp checkInternetConnection]==true)
    {[objMyGlobals.user ApplyCoupon:^(NSString *str, int status){
        if(status==1)
        {
            [objMyGlobals Displaymsg:self.view msg:str];
            objMyGlobals.user.IsAppliedCoupon=!objMyGlobals.user.IsAppliedCoupon;
             [objMyGlobals hideLoader:self.view];
            if(objMyGlobals.user.IsAppliedCoupon){
                _txtCouponCode.hidden=true;
                _lblRemoveOffer.hidden=false;
                _lblRemoveOffer.text=[NSString stringWithFormat:@"Remove Coupon (%@)",_txtCouponCode.text ];
                [_btnApplyCoupon setTitle:@"Remove" forState:UIControlStateNormal];
                
                _subtotal.text=[NSString stringWithFormat:@"₹ %@", [[appDelegateTemp.DiscountData objectAtIndex:0] objectForKey:@"amount"]];
                //       _lblShipping.text=[NSString stringWithFormat:@"₹ %@", [[appDelegateTemp.DiscountData objectAtIndex:2] objectForKey:@"amount"]];
                _lblDiscount.text=[NSString stringWithFormat:@"₹ %@", [[appDelegateTemp.DiscountData objectAtIndex:1] objectForKey:@"amount"]];
                if([[[appDelegateTemp.DiscountData objectAtIndex:2] objectForKey:@"title"] rangeOfString:@"Shipping"].location == NSNotFound)
                {
                    _FullTotal.text=[NSString stringWithFormat:@"₹ %@",[[appDelegateTemp.DiscountData objectAtIndex:2] objectForKey:@"amount"]];
                }
                else
                {
                    _lblShipping.text=[NSString stringWithFormat:@"₹ %@", [[appDelegateTemp.DiscountData objectAtIndex:2] objectForKey:@"amount"]];
                    _lblShipping1.text=[NSString stringWithFormat:@"₹ %@", [[appDelegateTemp.DiscountData objectAtIndex:2] objectForKey:@"amount"]];
                    _FullTotal.text=[NSString stringWithFormat:@"₹ %@",[[appDelegateTemp.   DiscountData objectAtIndex:3] objectForKey:@"amount"]];
                }
            }
            else
            {
                _txtCouponCode.hidden=false;
                _lblRemoveOffer.hidden=true;
                [_btnApplyCoupon setTitle:@"Apply" forState:UIControlStateNormal];
                _lblDiscount.text=@"0";
                _subtotal.text=[NSString stringWithFormat:@"₹ %@", [[appDelegateTemp.DiscountData objectAtIndex:0] objectForKey:@"amount"]];
                //       _lblShipping.text=[NSString stringWithFormat:@"₹ %@", [[appDelegateTemp.DiscountData objectAtIndex:2] objectForKey:@"amount"]];
             
                if([[[appDelegateTemp.DiscountData objectAtIndex:1] objectForKey:@"title"] rangeOfString:@"Shipping"].location == NSNotFound)
                {
                    _FullTotal.text=[NSString stringWithFormat:@"₹ %@",[[appDelegateTemp.DiscountData objectAtIndex:1] objectForKey:@"amount"]];
                }
                else
                {
                    _lblShipping.text=[NSString stringWithFormat:@"₹ %@", [[appDelegateTemp.DiscountData objectAtIndex:1] objectForKey:@"amount"]];
                    
                    _lblShipping1.text=[NSString stringWithFormat:@"₹ %@", [[appDelegateTemp.DiscountData objectAtIndex:1] objectForKey:@"amount"]];
                    _FullTotal.text=[NSString stringWithFormat:@"₹ %@",[[appDelegateTemp.   DiscountData objectAtIndex:2] objectForKey:@"amount"]];
                }
            }
            [objMyGlobals hideLoader:self.view];
              [_btnProcced setTitle:[NSString stringWithFormat:@"Procced To Pay %@",_FullTotal.text] forState:UIControlStateNormal];
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
//Delete Item From Cart
-(void)DeleteItemCart:(NSString*)productID{
  [objMyGlobals showLoaderIn:self.view];
    objMyGlobals.user.prod_id=[productID mutableCopy];
    if([appDelegateTemp checkInternetConnection]==true)
    {[objMyGlobals.user DeleteItemCart:^(NSString *str, int status){
        if(status==1)
        {
            [objMyGlobals Displaymsg:self.view msg:str];
            //  [tblvw reloadData];
            if(appDelegateTemp.CartData.count>0)
            {
                _lblItemCount.text=[NSString stringWithFormat:@"%lu Items in your bag.",(unsigned long)appDelegateTemp.CartData.count];
              
            }
            else
                _lblItemCount.text=[NSString stringWithFormat:@"No more items in your bag."];
            [self calculateBill];
            [tblvw reloadData];
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
-(void)UpdateCart:(NSString*)productID quenty:(NSString*)qty{
  [objMyGlobals showLoaderIn:self.view];
    objMyGlobals.user.qty=[qty mutableCopy];
    objMyGlobals.user.prod_id=[productID mutableCopy];
    if([appDelegateTemp checkInternetConnection]==true)
    {[objMyGlobals.user UpdateCart:^(NSString *str, int status){
        if(status==1)
        {
            [objMyGlobals Displaymsg:self.view msg:str];
            if(appDelegateTemp.CartData.count>0)
            {
                _lblItemCount.text=[NSString stringWithFormat:@"%lu Items in your bag.",(unsigned long)appDelegateTemp.CartData.count];
             

            }
            else
                _lblItemCount.text=[NSString stringWithFormat:@"No more items in your bag."];
            [self calculateBill];
            [tblvw reloadData];
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
//Apply Coupon Button Tapped.
- (IBAction)ApplyCoupon:(id)sender {
    [self.view endEditing:YES];
    CGPoint newOffset;
    newOffset.x = 0;
    newOffset.y = 0;
    [self.scrollView setContentOffset:newOffset animated:YES];
    if(!objMyGlobals.user.IsAppliedCoupon){
       // objMyGlobals.user.IsAppliedCoupon=true;
        [self ApplyCouponData:@"add"];
        
    }
    else
    {
      //  objMyGlobals.user.IsAppliedCoupon=false;
        [self ApplyCouponData:@"remove"];       
    }
   
}

- (IBAction)btnProccedToPay:(id)sender {
    if(appDelegateTemp.CartData.count>0)
    {
    UIStoryboard *objStoryboard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    AddressListVC *newView = (AddressListVC *)[objStoryboard instantiateViewControllerWithIdentifier:@"AddressListVC"];
    [self.navigationController pushViewController:newView animated:YES];
    }
    else
    {
        [objMyGlobals Displaymsg:self.view msg:@"No more items in your bag."];
    }
}
-(void)calculateBill
{
    /*manully Calculation*/
//    int Price,qty,Total = 0;
//    for(int i=0;i<appDelegateTemp.CartData.count;i++)
//    {
//        NSMutableDictionary *temp=[appDelegateTemp.CartData objectAtIndex:i];
//        Price=[[temp objectForKey:@"discount_price"]intValue];
//        qty=[[temp objectForKey:@"qty"]intValue];
//        Total+=(Price*qty);
//        
//    }
//    _totalPrice.text=[NSString stringWithFormat:@"₹ %d",Total+50];
//    _subtotal.text=[NSString stringWithFormat:@"₹ %d",Total];
//    _FullTotal.text=[NSString stringWithFormat:@"₹ %d",Total+50];
    
   if([[[appDelegateTemp.DiscountData objectAtIndex:1] objectForKey:@"title"]rangeOfString:@"Discount"].location == NSNotFound)
   {
       objMyGlobals.user.IsAppliedCoupon=false;
   }
    else
    {
           objMyGlobals.user.IsAppliedCoupon=true;
    }
    if( objMyGlobals.user.IsAppliedCoupon)
    {
        _txtCouponCode.hidden=true;
        _lblRemoveOffer.hidden=false;
      //  _lblRemoveOffer.text=[NSString stringWithFormat:@"Remove Coupon (%@)",_txtCouponCode.text ];
        [_btnApplyCoupon setTitle:@"Remove" forState:UIControlStateNormal];
        
      /*  NSString*inputString= [NSString stringWithFormat:@"₹ %@", [[appDelegateTemp.DiscountData objectAtIndex:1] objectForKey:@"title"]];
        NSCharacterSet *delimiters = [NSCharacterSet characterSetWithCharactersInString:@"()"];
        NSArray *splitString = [inputString componentsSeparatedByCharactersInSet:delimiters];*/
        _txtCouponCode.text = objMyGlobals.user.CouponCode;
           _lblRemoveOffer.text=[NSString stringWithFormat:@"Remove Coupon (%@)",_txtCouponCode.text ];
        
        
        
        _subtotal.text=[NSString stringWithFormat:@"₹ %@", [[appDelegateTemp.DiscountData objectAtIndex:0] objectForKey:@"amount"]];
        _totalPrice.text=[NSString stringWithFormat:@"₹ %@", [[appDelegateTemp.DiscountData objectAtIndex:0] objectForKey:@"amount"]];
        //       _lblShipping.text=[NSString stringWithFormat:@"₹ %@", [[appDelegateTemp.DiscountData objectAtIndex:2] objectForKey:@"amount"]];
        _lblDiscount.text=[NSString stringWithFormat:@"₹ %@", [[appDelegateTemp.DiscountData objectAtIndex:1] objectForKey:@"amount"]];
        if([[[appDelegateTemp.DiscountData objectAtIndex:2] objectForKey:@"title"] rangeOfString:@"Shipping"].location == NSNotFound)
        {
            _FullTotal.text=[NSString stringWithFormat:@"₹ %@",[[appDelegateTemp.DiscountData objectAtIndex:2] objectForKey:@"amount"]];
        }
        else
        {
            _lblShipping.text=[NSString stringWithFormat:@"₹ %@", [[appDelegateTemp.DiscountData objectAtIndex:2] objectForKey:@"amount"]];
            _lblShipping1.text=[NSString stringWithFormat:@"₹ %@", [[appDelegateTemp.DiscountData objectAtIndex:2] objectForKey:@"amount"]];
            _FullTotal.text=[NSString stringWithFormat:@"₹ %@",[[appDelegateTemp.   DiscountData objectAtIndex:3] objectForKey:@"amount"]];
        }
        
    }
    else
    {
        _txtCouponCode.hidden=false;
        _lblRemoveOffer.hidden=true;
        [_btnApplyCoupon setTitle:@"Apply" forState:UIControlStateNormal];
        _lblDiscount.text=@"0";
        _subtotal.text=[NSString stringWithFormat:@"₹ %@", [[appDelegateTemp.DiscountData objectAtIndex:0] objectForKey:@"amount"]];
          _totalPrice.text=[NSString stringWithFormat:@"₹ %@", [[appDelegateTemp.DiscountData objectAtIndex:0] objectForKey:@"amount"]];
        //       _lblShipping.text=[NSString stringWithFormat:@"₹ %@", [[appDelegateTemp.DiscountData objectAtIndex:2] objectForKey:@"amount"]];
        
        if([[[appDelegateTemp.DiscountData objectAtIndex:1] objectForKey:@"title"] rangeOfString:@"Shipping"].location == NSNotFound)
        {
            _FullTotal.text=[NSString stringWithFormat:@"₹ %@",[[appDelegateTemp.DiscountData objectAtIndex:1] objectForKey:@"amount"]];
        }
        else
        {
            _lblShipping.text=[NSString stringWithFormat:@"₹ %@", [[appDelegateTemp.DiscountData objectAtIndex:1] objectForKey:@"amount"]];
            
            _lblShipping1.text=[NSString stringWithFormat:@"₹ %@", [[appDelegateTemp.DiscountData objectAtIndex:1] objectForKey:@"amount"]];
            _FullTotal.text=[NSString stringWithFormat:@"₹ %@",[[appDelegateTemp.   DiscountData objectAtIndex:2] objectForKey:@"amount"]];
        }
        
    }
  [_btnProcced setTitle:[NSString stringWithFormat:@"Procced To Pay %@",_FullTotal.text] forState:UIControlStateNormal];
}
//Set Cart Data.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return appDelegateTemp.CartData.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"CheckouttblvwCell";
    
    CheckouttblvwCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier forIndexPath:indexPath];
    
    if (cell == nil) {
        cell = [[CheckouttblvwCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    [cell awakeFromNib];
    NSMutableDictionary *dict=[appDelegateTemp.CartData objectAtIndex:indexPath.row];
//    cell.imgView.layer.cornerRadius = cell.imgView.frame.size.height/2;
//    cell.imgView.layer.masksToBounds = YES;
    cell.imgView.layer.cornerRadius = 30;
    cell.imgView.layer.masksToBounds = YES;
//    [cell.imgView sd_setImageWithURL:[dict objectForKey:@"imageurl"]
//                        placeholderImage:[UIImage imageNamed:@"avatar-placeholder.png"]
//                                 options:SDWebImageRefreshCached];
    
    NSString *cacheKey = [NSString stringWithFormat:@"%ld%ld",(long)indexPath.row, (long)indexPath.section];
//    NSData *cachedObject = [[CacheController sharedInstance] getCacheForKey:cacheKey];
//    
//    if (cachedObject != nil) {
//        UIImage *img=[UIImage imageWithData:cachedObject];
//        [cell.imgView setImage:img];
//        // [[cell textLabel] setText:@"Got object from cache!"];
//    }
//    
//    else {
    
        [cell downloadFile:[NSURL URLWithString:[dict objectForKey:@"imageurl"]]
               forIndexPath:indexPath cacheKey:cacheKey];
        
   // }
    
     NSString *tempstr1=[NSString stringWithFormat:@"%@",[dict objectForKey:@"price"]];
    cell.NewPrice.text = [NSString stringWithFormat:@"%@",[dict objectForKey:@"discount_price"]];
    /* -- set String with ₹ Symbol--->*/
    NSMutableAttributedString *myString1= [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"₹%@ ",tempstr1]];
    
    [myString1 addAttribute:NSStrikethroughStyleAttributeName
                      value:@2
                      range:NSMakeRange(0, [myString1 length])];
    cell.itemName.text=[dict objectForKey:@"name"];
    cell.btnQty.tag=indexPath.row;
    cell.btnDeleteItem.tag=indexPath.row+100;
    cell.txtQTY.text=[NSString stringWithFormat:@"%@",[dict objectForKey:@"qty"]];
    [cell.btnQty addTarget:self action:@selector(DropDownPressed:) forControlEvents:UIControlEventTouchUpInside];
      [cell.btnDeleteItem addTarget:self action:@selector(DeleteItem:) forControlEvents:UIControlEventTouchUpInside];
    cell.oldPrice.textColor=[UIColor lightGrayColor];
    cell.oldPrice.attributedText = myString1;
    return cell;
}
//Delete Item From Cart
-(void)DeleteItem:(id)sender
{
    UIButton *btn=sender;
    NSIndexPath* indexpath = [NSIndexPath indexPathForRow:btn.tag inSection:0];
    NSMutableDictionary *dict=[appDelegateTemp.CartData objectAtIndex:indexpath.row-100];
    [self DeleteItemCart:[NSString stringWithFormat:@"%@",[dict objectForKey:@"id"]]];
 
}
- (void)checkButtonTapped:(id)sender event:(id)event
{
    NSSet *touches = [event allTouches];
    UITouch *touch = [touches anyObject];
    CGPoint currentTouchPosition = [touch locationInView:tblvw];
    NSIndexPath *indexPath = [tblvw indexPathForRowAtPoint: currentTouchPosition];
  //  UIButton *btn=(UIButton *)sender;
    CheckouttblvwCell *cell = [tblvw cellForRowAtIndexPath:indexPath
                               ];
    int qty=  [[NSString stringWithFormat:@"%@", cell.lblQty.text] intValue];
    qty=qty+1;
    NSLog(@"%d",qty);
    cell.lblQty.text=[NSString stringWithFormat:@"%d", qty];
}
//Increment Value.
-(IBAction)addValue:(id)sender
{
    UIButton *btn=sender;
    NSIndexPath* indexpath = [NSIndexPath indexPathForRow:btn.tag inSection:0];
    CheckouttblvwCell *cell = [tblvw cellForRowAtIndexPath:indexpath
                    ];
    int qty=  [[NSString stringWithFormat:@"%@", cell.lblQty.text] intValue];
    qty=qty+1;
    NSLog(@"%d",qty);
    cell.lblQty.text=[NSString stringWithFormat:@"%d", qty];
}
//Decrement Value
-(IBAction)minusValue:(id)sender
{
    UIButton *btn=sender;
    NSIndexPath* indexpath = [NSIndexPath indexPathForRow:btn.tag-1000 inSection:0];
    CheckouttblvwCell *cell = [tblvw cellForRowAtIndexPath:indexpath                               ];
    int qty=  [[NSString stringWithFormat:@"%@", cell.lblQty.text] intValue];
    qty=qty-1;
    NSLog(@"%d",qty);
    cell.lblQty.text=[NSString stringWithFormat:@"%d", qty];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)btnBackTapped:(id)sender {
   
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark DropDown
//Set Value of QTY By Drop Down.
-(void)showPopUpWithTitle:(NSString*)popupTitle withOption:(NSArray*)arrOptions xy:(CGPoint)point size:(CGSize)size isMultiple:(BOOL)isMultiple{
    Dropobj = [[DropDownListView alloc] initWithTitle:popupTitle options:arrOptions xy:point size:size isMultiple:isMultiple];
    Dropobj.delegate = self;
    [Dropobj showInView:self.view animated:YES];
    
    /*----------------Set DropDown backGroundColor-----------------*/
    [Dropobj SetBackGroundDropDown_R:0.0 G:108.0 B:194.0 alpha:0.70];
    
}
- (void)DropDownListView:(DropDownListView *)dropdownListView didSelectedIndex:(NSInteger)anIndex{
    
    /*----------------Get Selected Value[Single selection]-----------------*/
    
   NSIndexPath* indexpath = [NSIndexPath indexPathForRow:selectedIndex inSection:0];

    CheckouttblvwCell *cell = [tblvw cellForRowAtIndexPath:indexpath
                               ];
    cell.txtQTY.text=[items objectAtIndex:anIndex];
    NSMutableDictionary *dict=[[appDelegateTemp.CartData objectAtIndex:indexpath.row] mutableCopy];
    [self UpdateCart:[dict objectForKey:@"id"] quenty:cell.txtQTY.text];

 
}
- (void)DropDownListView:(DropDownListView *)dropdownListView Datalist:(NSMutableArray*)ArryData{
    
}
- (void)DropDownListViewDidCancel{
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    
    if ([touch.view isKindOfClass:[UIView class]]) {
        [Dropobj fadeOut];
    }
}
-(CGSize)GetHeightDyanamic:(UILabel*)lbl
{
    NSRange range = NSMakeRange(0, [lbl.text length]);
    CGSize constraint;
    constraint= CGSizeMake(288 ,MAXFLOAT);
    CGSize size;
    if (([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)) {
        NSDictionary *attributes = [lbl.attributedText attributesAtIndex:0 effectiveRange:&range];
        CGSize boundingBox = [lbl.text boundingRectWithSize:constraint options: NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
        
        size = CGSizeMake(ceil(boundingBox.width), ceil(boundingBox.height));
    }
    else{
        
        size = [lbl.text sizeWithFont:[UIFont fontWithName:@"Helvetica" size:14] constrainedToSize:constraint lineBreakMode:NSLineBreakByWordWrapping];
    }
    return size;
}
- (IBAction)DropDownPressed:(id)sender {
    UIButton *btn=sender;
    selectedIndex=btn.tag;
 items =[[NSArray alloc]initWithObjects:
            @"1",
            @"2",
            @"3",
            @"4",
            @"5",
            @"6",
            @"7",
            @"8",
            @"9",
            @"10",nil];
    [self showPopUpWithTitle:@"Select QTY" withOption:items xy:CGPointMake(216, 58) size:CGSizeMake(87, 330) isMultiple:NO];
    //  [Dropobj fadeOut];
    
}
@end
