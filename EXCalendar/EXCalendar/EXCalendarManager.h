//
//  EXCalendarManager.h
//  EXCalendar
//
//  Created by Eric on 2018/11/8.
//  Copyright © 2018 ex. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EXCalendarView.h"
#import "EXCalendarWeekView.h"


@interface EXCalendarManager : NSObject

/**
 Calendar view.
 */
@property (nonatomic, strong) EXCalendarView *calendarView;

/**
 Calendar week view.
 */
@property (nonatomic, strong) EXCalendarWeekView *calendarWeekView;



/**
 EXCalendarManager singleton.

 @return EXCalendarManager.
 */
+ (EXCalendarManager *)manager;

/**
 Scroll to previous month section.
 */
- (void)scrollToPreviousMonth;

/**
 Scroll to next month section.
 */
- (void)scrollToNextMonth;

@end
