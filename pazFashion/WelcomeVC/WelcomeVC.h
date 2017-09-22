//
//  WelcomeVC.h
//  ZapFashion
//
//  Created by bhumesh on 6/2/17.
//  Copyright © 2017 bhumesh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomFontLabel.h"
@interface WelcomeVC : UIViewController
@property (strong, nonatomic) IBOutlet UIButton *btnSignUp;
@property (strong, nonatomic) IBOutlet UIButton *btnLogin;

- (IBAction)LoginButtonTapped:(id)sender;
- (IBAction)SignupTapped:(id)sender;
@end
