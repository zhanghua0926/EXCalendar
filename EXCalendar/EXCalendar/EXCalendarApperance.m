//
//  EXCalendarApperance.m
//  EXCalendar
//
//  Created by Eric on 2018/11/8.
//  Copyright © 2018 ex. All rights reserved.
//

#import "EXCalendarApperance.h"

@implementation EXCalendarApperance

+ (EXCalendarApperance *)apperance {
    static dispatch_once_t onceToken;
    static id singleton;
    dispatch_once(&onceToken, ^{
        singleton = [[EXCalendarApperance alloc] init];
    });
    
    return singleton;
}


- (CGFloat)weekTitleHeight {
    if (_weekTitleHeight <= 0) {
        return 100;
    }
    
    return _weekTitleHeight;
}


- (CGFloat)weekDayHeight {
    if (_weekDayHeight <= 0) {
        return 100;
    }
    
    return _weekDayHeight;
}


- (NSInteger)weeksToDisplay {
    if (_weeksToDisplay <= 0) {
        return 5;
    }
    
    return _weeksToDisplay;
}


- (NSInteger)months {
    if (_months <= 0) {
        return 5;
    }
    
    return _months;
}


- (UIColor *)dayBorderColorToday {
    if (!_dayBorderColorToday) {
        return [UIColor colorWithRed:133./255. green:205./255. blue:243./255. alpha:1.];
    }
    
    return _dayBorderColorToday;
}


- (UIColor *)dayCircleColorToday {
    if (!_dayCircleColorToday) {
        return [UIColor colorWithRed:133./255. green:205./255. blue:243./255. alpha:1.];
    }
    
    return _dayCircleColorToday;
}


- (UIColor *)dayCircleColorSelected {
    if (!_dayCircleColorSelected) {
        return [UIColor colorWithRed:133./255. green:205./255. blue:243./255. alpha:1.];
    }
    
    return _dayCircleColorSelected;
}


- (UIColor *)dayTextColorToday {
    if (!_dayTextColorToday) {
        return [UIColor whiteColor];
    }
    
    return _dayTextColorToday;
}


- (CGFloat)dayCircleSize {
    if (_dayCircleSize <= 0) {
        return 30;
    }
    
    return _dayCircleSize;
}


- (UIColor *)dayTextColorOtherMonth {
    if (!_dayTextColorOtherMonth) {
        return [UIColor colorWithRed:152./255 green:147./255 blue:157./255 alpha:1.];
    }
    
    return _dayTextColorOtherMonth;
}


- (UIColor *)dayEventColor {
    if (!_dayEventColor) {
        return [UIColor colorWithRed:254./255 green:161./255 blue:88./255 alpha:1.];
    }
    
    return _dayEventColor;
}


- (NSDate *)defaultDate {
    if (!_defaultDate) {
        
        // This time is used to take the calendar, and it does not need to add 8 hours, otherwise the value in NSDateComponents will be wrong。
        return [NSDate date];
    }
    
    return _defaultDate;
}


-(NSCalendar *)calendar {
    static NSCalendar *calendar;
    static dispatch_once_t once;
    
    dispatch_once(&once, ^{
        calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        calendar.timeZone = [NSTimeZone systemTimeZone];
    });
    
    return calendar;
}

@end
