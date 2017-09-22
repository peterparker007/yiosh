//
//  DetailsSettingsVC.m
//  ZapFashion
//
//  Created by bhumesh on 8/25/17.
//  Copyright © 2017 bhumesh. All rights reserved.
//

#import "DetailsSettingsVC.h"
#import "SettingsDynamicVC.h"
@interface DetailsSettingsVC ()
{
    NSMutableDictionary *savedValue;
}
@end

@implementation DetailsSettingsVC

- (void)viewDidLoad {
    [super viewDidLoad];
     SettingsDynamicVC *obj=[[SettingsDynamicVC alloc]init];
     if([[self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count-2]isKindOfClass:obj.class])
    {
            _btnBack.hidden=false;
            _btnMenu.hidden=TRUE;
    }
    else
    {
        _btnBack.hidden=TRUE;
        _btnMenu.hidden=false;
        [self MenuButttonTapped:_btnMenu];
    }
    
    // Do any additional setup after loading the view.
}
- (IBAction)MenuButttonTapped:(id)sender
{
    [sender addTarget:self action:@selector(presentLeftMenuViewController:) forControlEvents:UIControlEventTouchUpInside];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"Data.plist"];
   savedValue = [[NSMutableDictionary alloc] initWithContentsOfFile: path];
    [_TopView setBackgroundColor: [self colorWithHexString:[savedValue valueForKey:@"header_color"]]];
    [_HeaderTitle setTextColor:[self colorWithHexString:[savedValue valueForKey:@"header_text_color"]]];
    [_HeaderTitle setText:_strTitle];
   [self.navigationController setNavigationBarHidden:YES];
    _txtDetailsView.text = _strContents;
    [self SetConfigForTopView];
}
-(void)SetConfigForTopView
{
    Globals *objMyGlobals;
    objMyGlobals=[Globals sharedManager];
    CGRect frame1=[objMyGlobals getXYPositions:[savedValue valueForKey:@"page_title_position"]];
    _HeaderTitle.frame=[objMyGlobals currentDevicePositions:CGRectMake(frame1.origin.x, frame1.origin.y, 145, 21) vwRect:self.view.frame];
    frame1=[objMyGlobals getXYPositions:[savedValue valueForKey:@"logo_position"]];
    _Logo.frame=[objMyGlobals currentDevicePositions:CGRectMake(frame1.origin.x, frame1.origin.y, 77, 18) vwRect:self.view.frame];
    
    CGRect frame= _divider.frame;
    frame.origin.y= _TopView.frame.size.height;
    frame.size.width= _TopView.frame.size.width;
    _divider.frame=frame;
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

- (IBAction)btnBackTapped:(id)sender {
  [self.navigationController popViewControllerAnimated:YES];}
@end
