//
//  EXCalendarWeekView.m
//  EXCalendar
//
//  Created by Eric on 2018/11/9.
//  Copyright © 2018 ex. All rights reserved.
//

#import "EXCalendarWeekView.h"
#import "EXCalendarApperance.h"


@implementation EXCalendarWeekView
#pragma mark - InitView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self createContentView];
    }
    return self;
}


- (void)createContentView {
    NSArray *daysOfWeek = @[@"日", @"一", @"二", @"三", @"四", @"五", @"六"];
    for(NSString *day in daysOfWeek){
        UILabel *view = [UILabel new];
        
        view.font = [EXCalendarApperance apperance].weekDayTextFont;
        view.textColor = [EXCalendarApperance apperance].weekDayTextColor;
        
        if ([day isEqualToString:@"日"]) {
            view.textColor = [UIColor colorWithRed:241/255.0f green:154/255.0f blue:118/255.0f alpha:1];
        } else if ([day isEqualToString:@"六"]) {
            view.textColor = [UIColor colorWithRed:0/255.0f green:160/255.0f blue:233/255.0f alpha:1];
        }
        
        view.textAlignment = NSTextAlignmentCenter;
        view.text = day;
        
        [self addSubview:view];
    }
}

- (NSArray *)daysOfWeek {
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    NSMutableArray *days = [[dateFormatter standaloneWeekdaySymbols] mutableCopy];
    
    for(NSInteger i = 0; i < days.count; ++i){
        NSString *day = days[i];
        [days replaceObjectAtIndex:i withObject:[day uppercaseString]];
    }
    
    // Redorder days for be conform to calendar
    {
        NSCalendar *calendar = [EXCalendarApperance apperance].calendar;
        NSUInteger firstWeekday = (calendar.firstWeekday + 6) % 7; // Sunday == 1, Saturday == 7
        
        for(int i = 0; i < firstWeekday; ++i){
            id day = [days firstObject];
            [days removeObjectAtIndex:0];
            [days addObject:day];
        }
    }
    
    return days;
}


- (void)layoutSubviews {
    CGFloat x = 0;
    CGFloat width = self.frame.size.width / 7.;
    CGFloat height = self.frame.size.height;
    
    for(UIView *view in self.subviews){
        view.frame = CGRectMake(x, 0, width, height);
        x = CGRectGetMaxX(view.frame);
    }
}


@end
