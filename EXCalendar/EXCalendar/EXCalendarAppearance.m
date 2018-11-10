//
//  EXCalendarAppearance.m
//  EXCalendar
//
//  Created by Eric on 2018/11/8.
//  Copyright © 2018 ex. All rights reserved.
//

#import "EXCalendarAppearance.h"

@implementation EXCalendarAppearance

+ (EXCalendarAppearance *)apperance {
    static dispatch_once_t onceToken;
    static id singleton;
    dispatch_once(&onceToken, ^{
        singleton = [[EXCalendarAppearance alloc] init];
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

@end
