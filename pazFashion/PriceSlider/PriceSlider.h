//
//  PriceSlider.h
//  ZapFashion

//  Created by bhumesh on 8/18/17.
//  Copyright © 2017 bhumesh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PriceSlider : UIControl
@property(assign, nonatomic) float minimumValue;
@property(assign, nonatomic) float maximumValue;
@property(assign, nonatomic) float minimumRange;
@property(assign, nonatomic) float stepValue;
@property(assign, nonatomic) BOOL stepValueContinuously;
@property(assign, nonatomic) BOOL continuous;
@property(assign, nonatomic) float lowerValue;
@property(assign, nonatomic) float upperValue;
@property(readonly, nonatomic) CGPoint lowerCenter;
@property(readonly, nonatomic) CGPoint upperCenter;
@property(assign, nonatomic) float lowerMaximumValue;
@property(assign, nonatomic) float upperMinimumValue;
@property (assign, nonatomic) UIEdgeInsets lowerTouchEdgeInsets;
@property (assign, nonatomic) UIEdgeInsets upperTouchEdgeInsets;
@property (assign, nonatomic) BOOL lowerHandleHidden;
@property (assign, nonatomic) BOOL upperHandleHidden;
@property (assign, nonatomic) float lowerHandleHiddenWidth;
@property (assign, nonatomic) float upperHandleHiddenWidth;
@property(retain, nonatomic) UIImage* lowerHandleImageNormal;
@property(retain, nonatomic) UIImage* lowerHandleImageHighlighted;
@property(retain, nonatomic) UIImage* upperHandleImageNormal;
@property(retain, nonatomic) UIImage* upperHandleImageHighlighted;
@property(retain, nonatomic) UIImage* trackImage;
@property(retain, nonatomic) UIImage* trackCrossedOverImage;
@property(retain, nonatomic) UIImage* trackBackgroundImage;
- (void)setLowerValue:(float)lowerValue animated:(BOOL) animated;
- (void)setUpperValue:(float)upperValue animated:(BOOL) animated;
- (void) setLowerValue:(float) lowerValue upperValue:(float) upperValue animated:(BOOL)animated;
@end
