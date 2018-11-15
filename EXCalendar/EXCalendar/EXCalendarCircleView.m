//
//  EXCalendarCircleView.m
//  EXCalendar
//
//  Created by Eric on 2018/11/14.
//  Copyright © 2018 ex. All rights reserved.
//

#import "EXCalendarCircleView.h"

@implementation EXCalendarCircleView

- (instancetype)init {
    self = [super init];
    if(self){
        self.color = [UIColor whiteColor];
    }
    
    return self;
}


- (void)drawRect:(CGRect)rect {
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(ctx, [[UIColor whiteColor] CGColor]);
    CGContextFillRect(ctx, rect);
    
    rect = CGRectInset(rect, .5, .5);
    
    CGContextSetStrokeColorWithColor(ctx, [self.color CGColor]);
    CGContextSetFillColorWithColor(ctx, [self.color CGColor]);
    
    CGContextAddEllipseInRect(ctx, rect);
    CGContextFillEllipseInRect(ctx, rect);
    
    CGContextFillPath(ctx);
}

- (void)setColor:(UIColor *)color {
    _color = color;
    
    [self setNeedsDisplay];
}

@end
