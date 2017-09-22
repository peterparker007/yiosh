//
//  DetailsSettingsVC.h
//  ZapFashion
//
//  Created by bhumesh on 8/25/17.
//  Copyright © 2017 bhumesh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Globals.h"
@interface DetailsSettingsVC : UIViewController
@property (strong, nonatomic) IBOutlet UITextView *txtDetailsView;
@property (strong, nonatomic) IBOutlet UILabel *HeaderTitle;
@property (strong, nonatomic) IBOutlet UIView *TopView;
@property (strong, nonatomic) NSString *strTitle;
- (IBAction)btnBackTapped:(id)sender;
@property (strong, nonatomic) IBOutlet UIImageView *divider;
@property (strong, nonatomic) IBOutlet UIImageView *Logo;
@property (strong, nonatomic) IBOutlet UIButton *btnBack;
@property (strong, nonatomic) IBOutlet UIButton *btnMenu;
@property (strong, nonatomic) NSString *strContents;
- (IBAction)MenuButttonTapped:(id)sender;
@end
