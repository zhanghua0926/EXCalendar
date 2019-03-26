//
//  EXCalendarCircleView.m
//  EXCalendar
//
//  Created by Eric on 2018/11/14.
//  Copyright © 2018 ex. All rights reserved.
//

#import "EXCalendarCircleView.h"

#import "EXCalendarCircleView.h"

@interface EXCalendarCircleView ()

@property (nonatomic, assign) CGFloat radius;

@end


@implementation EXCalendarCircleView

- (instancetype)initWithRadius:(CGFloat)radius {
    if (self = [super init]) {
        self.backgroundColor = [UIColor whiteColor];
        self.radius = radius;
    }
    return self;
}


- (void)drawRect:(CGRect)rect {
    // 获取当前图形的上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // 添加一个圆形路径到上下文中
    
    /**
     *  context  图形上下文
     *  x,y 圆心坐标点
     *  radius 半径
     *  angle 开始和结束的角度  0度在x轴正方向，角度沿顺时针方向增大
     *  clockwise 画的方向 0表示顺时针画圆，1表示逆时针画
     */
    CGContextAddArc(context, self.bounds.size.width / 2, self.bounds.size.height / 2, _radius, 0, 2*M_PI, 0);
    
    [self.fillColor setFill];
    [self.strokeColor setStroke];
    CGContextSetLineWidth(context, 1);
    
    // 绘制线条
    CGContextDrawPath(context, kCGPathFillStroke);
    
}


- (void)setStrokeColor:(UIColor *)strokeColor {
    _strokeColor = strokeColor;
    
    [self setNeedsDisplay];
}


- (void)setFillColor:(UIColor *)fillColor {
    _fillColor = fillColor;
    
    [self setNeedsDisplay];
}

@end
