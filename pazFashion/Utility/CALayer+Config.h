//
//  CALayer+Config.h
//  ZapFashion
//

//  Bhumesh Purohit
//
//  Created by Bhumesh Purohit on 3/17/15.
//  Copyright (c) 2015 Bhumesh Purohit. All rights reserved.

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

@interface CALayer_Config : CALayer
@property(nonatomic, assign) UIColor* borderUIColor;
-(void)setBorderUIColor:(UIColor*)color;
-(UIColor*)borderUIColor;

@end
