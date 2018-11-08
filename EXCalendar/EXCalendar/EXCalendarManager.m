//
//  EXCalendarManager.m
//  EXCalendar
//
//  Created by Eric on 2018/11/8.
//  Copyright © 2018 ex. All rights reserved.
//

#import "EXCalendarManager.h"

@implementation EXCalendarManager

+ (EXCalendarManager *)manager {
    static dispatch_once_t onceToken;
    static id singleton;
    dispatch_once(&onceToken, ^{
        singleton = [[self alloc] init];
    });
    
    return singleton;
}

@end
