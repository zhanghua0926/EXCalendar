//
//  EXCalendarDelegate.h
//  EXCalendar
//
//  Created by Eric on 2018/11/14.
//  Copyright © 2018 ex. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol EXCalendarDelegate <NSObject>
@optional


/**
 Click on the selected date.

 @param date Selected date.
 */
- (void)calendarDidSelectedDate:(NSDate *)date;


/**
 Display the current month.
 
 @param year Current year.
 @param month Current month.
 */
- (void)calendarDidScrollYear:(NSInteger)year
                        month:(NSInteger)month;

@end
