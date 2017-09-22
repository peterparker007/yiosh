//
//  Globals.m
//  Rover
//
//  Created by Aadil Keshwani on 3/17/15.
//  Copyright (c) 2015 Aadil Keshwani. All rights reserved.
//

#import "Globals.h"

@implementation Globals
@synthesize user,arrItems,arrNewItem,arrWishList;
+ (id)sharedManager {
    static Globals *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        sharedMyManager = [[self alloc] init];
        
    });
    return sharedMyManager;
}
- (id)init {
    if (self = [super init]) {
        self.user=[[Users alloc]init];
        self.addObj=false;
        self.uploadV=false;
        self.isSearched=false;
        self.isSwitchRefreshON=false;
        self.isSwitchNotificationON=true;
        self.isFacebookLogin=false;
        self.isTwitterLogin=false;
        arrItems=[[NSMutableArray alloc]init];
        arrNewItem=[[NSMutableArray alloc]init];
        arrWishList=[[NSMutableArray alloc]init];
        self.arrGlobalItemsBox = [[NSMutableArray alloc] init];
    }
    return self;
}
+ (void)ShowAlertWithTitle:(NSString *)title Message:(NSString *)message
{
    [[[UIAlertView alloc]initWithTitle:title message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
}
#pragma mark - ProgresLoader

- (void)showLoaderIn:(UIView *)view
{ 
    
    self.spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [ self.spinner setFrame:CGRectMake((view.frame.size.width/2)-( self.spinner.frame.size.width/2), (view.frame.size.height/2)-( self.spinner.frame.size.height/2),  self.spinner.frame.size.width*2,  self.spinner.frame.size.height*2)];
     self.spinner.opaque = NO;
     self.spinner.backgroundColor = [UIColor whiteColor];
    [ self.spinner setColor:[UIColor blueColor]];
    
    [self.spinner setHidden:FALSE];
    [self.spinner startAnimating];
    [view addSubview:self.spinner];
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
}
- (void)hideLoader:(UIView *)view
{
    [ self.spinner stopAnimating];
     [self.spinner removeFromSuperview];
        [[UIApplication sharedApplication] endIgnoringInteractionEvents];
}
-(void)Displaymsg:(UIView *)view msg:(NSString*)msg
{
    if(msg.length>0)
    {
    UILabel *lbl=[[UILabel alloc]initWithFrame:CGRectMake(5,0, 100, 20)];
    UIView *toast;
    lbl.text = msg;
    
    lbl.textAlignment=NSTextAlignmentCenter;
    lbl.textColor=[UIColor whiteColor];
    lbl.lineBreakMode= NSLineBreakByWordWrapping;
    lbl.numberOfLines=0;
      [lbl sizeToFit];
    CGSize labelSize = [lbl.text sizeWithAttributes:@{NSFontAttributeName:lbl.font}];
        
  //  yourLabel.intrinsicContentSize.widthz
    if(labelSize.width<300)
    {
    lbl.frame = CGRectMake(
                             lbl.frame.origin.x-5, lbl.frame.origin.y,
                             labelSize.width+10, labelSize.height+10);
        toast=[[UIView alloc]initWithFrame:CGRectMake((view.frame.size.width/2)-(labelSize.width/2),(view.frame.size.height)-85,lbl.frame.size.width,lbl.frame.size.height)];
    }
    else
    {
        lbl.numberOfLines=3;
        lbl.frame = CGRectMake(
                               lbl.frame.origin.x-5, lbl.frame.origin.y,
                               310, labelSize.height+50);
        toast=[[UIView alloc]initWithFrame:CGRectMake((view.frame.size.width/2)-150,(view.frame.size.height)-85,lbl.frame.size.width,lbl.frame.size.height)];
    }
    
    toast.layer.cornerRadius=4.0;
    
    toast.backgroundColor=[UIColor blackColor];
    toast.alpha=0.7;
    [toast addSubview:lbl];
    
    [view addSubview:toast];
    int duration = 2; // duration in seconds
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, duration * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [toast removeFromSuperview];
    });
    }
}

-(CGRect )currentDevicePositions:(CGRect )frame vwRect:(CGRect )vwRect
{
    CGRect tempFrame=frame;
    tempFrame.origin.x=tempFrame.origin.x*(vwRect.size.width/381);
     tempFrame.origin.y=tempFrame.origin.y*(vwRect.size.height/675);
    float HeightDiffrence=tempFrame.size.height*(vwRect.size.height/675);
      float widthDiffrence=tempFrame.size.width*(vwRect.size.width/381);
    tempFrame.size.width=widthDiffrence;
    tempFrame.size.height=HeightDiffrence;
    
    return tempFrame;
}
-(CGRect)getXYPositions:(NSString*)str
{
    NSArray *items = [str componentsSeparatedByString:@","];
    float x=[items[0] floatValue];
    float y=[items[1] floatValue];
    CGRect frame=CGRectMake(x, y, 0, 0);
    return frame;
}
@end
