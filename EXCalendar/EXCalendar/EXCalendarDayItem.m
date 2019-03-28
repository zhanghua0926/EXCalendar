//
//  EXCalendarDayItem.m
//  EXCalendar
//
//  Created by Eric on 2018/11/12.
//  Copyright © 2018 ex. All rights reserved.
//

#import "EXCalendarDayItem.h"
#import "EXCalendarApperance.h"

@implementation EXCalendarDayItem

- (void)setDate:(NSDate *)date {
    _date = date;
    
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    dateFormatter.timeZone = [EXCalendarApperance apperance].calendar.timeZone;
    [dateFormatter setDateFormat:@"MM"];
    
    self.dateOfMonth = [[dateFormatter stringFromDate:date] intValue];
}

@end
