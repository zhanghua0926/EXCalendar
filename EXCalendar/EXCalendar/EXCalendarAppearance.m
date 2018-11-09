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

@end
