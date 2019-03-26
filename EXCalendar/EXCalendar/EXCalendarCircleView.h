//
//  EXCalendarCircleView.h
//  EXCalendar
//
//  Created by Eric on 2018/11/14.
//  Copyright © 2018 ex. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface EXCalendarCircleView : UIView

@property (nonatomic, strong) UIColor *strokeColor;

@property (nonatomic, strong) UIColor *fillColor;


- (instancetype)initWithRadius:(CGFloat)radius;

@end
