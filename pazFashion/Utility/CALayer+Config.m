//
//  CALayer+Config.m
//  ZapFashion
//
//  Created by bhumesh  on 6/7/17.
//  Copyright © 2017 bhumesh. All rights reserved.
//

#import "CALayer+Config.h"

@implementation CALayer (CALayer_Config)
-(void)setBorderUIColor:(UIColor*)color
{
    self.borderColor = color.CGColor;
}
-(UIColor*)borderUIColor
{
    return [UIColor colorWithCGColor:self.borderColor];
}

@end
