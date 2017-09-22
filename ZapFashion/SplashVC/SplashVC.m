//
//  SplashVC.m
//  KidsFun
//
//  Created by bhumesh on 2/22/17.
//  Copyright © 2017 com.zaptechsolution. All rights reserved.
//

#import "SplashVC.h"
#import "WelcomeVC.h"
#import "LoginVC.h"
#import "Globals.h"

@interface SplashVC ()

@end

@implementation SplashVC
@synthesize imgSplashMove;
- (void)viewDidLoad {
    [super viewDidLoad];
  [self.navigationController setNavigationBarHidden:YES];
    
       
}
-(void)viewWillAppear:(BOOL)animated
{
    [self SetConfiguration];
}
-(void)SetConfiguration
{
        Globals *objMyGlobals;
     objMyGlobals=[Globals sharedManager];
   [objMyGlobals showLoaderIn:self.view];
    [objMyGlobals.user Setconfiguration:^(NSString *str, int status){
        if(status==1){
           [objMyGlobals hideLoader:self.view];
            [self Navigate];
        }
        else{
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Mobile Config Failed" message:str delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
            [alert show];
            [objMyGlobals hideLoader:self.view];
            // [hud hide:YES];
            //  [Globals ShowAlertWithTitle:@"Error" Message:str ];
        }
    }];
}
-(void)Navigate
{
      UIStoryboard *storyboard = [UIStoryboard storyboardWithName: @"Main" bundle:nil];
    LoginVC *ObjDashboardVC = (LoginVC *)[storyboard instantiateViewControllerWithIdentifier:@"LoginVC"];
    
     [self.navigationController pushViewController:ObjDashboardVC animated:NO ];
   
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return interfaceOrientation == UIInterfaceOrientationPortrait;
}

@end
