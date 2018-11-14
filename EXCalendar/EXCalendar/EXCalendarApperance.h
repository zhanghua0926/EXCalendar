//
//  EXCalendarApperance.h
//  EXCalendar
//
//  Created by Eric on 2018/11/8.
//  Copyright © 2018 ex. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef enum {
    WeekBeginDayOfSaturday,
    WeekBeginDayOfMonday,
    WeekBeginDayOfTuesday,
    WeekBeginDayOfWednesday,
    WeekBeginDayThursday,
    WeekBeginDayFriday,
    WeekBeginDaySunday,
}WeekBeginDay;

@interface EXCalendarApperance : NSObject

/**
 Whether the lunar calendar display.
 */
@property (nonatomic, assign) BOOL isShowLunarCalender;

/**
 Lunar calendar text font.
 */
@property (nonatomic, strong) UIFont *lunarDayTextFont;

/**
 Start the week on the day of the week.
 */
@property (nonatomic, assign) WeekBeginDay weekBeginDay;

/**
 Week title height.
 */
@property (nonatomic, assign) CGFloat weekTitleHeight;

/**
 Week day height of calendar.
 */
@property (nonatomic, assign) CGFloat weekDayHeight;

/**
 Week day counts per counts. default is 5.
 */
@property (nonatomic, assign) NSInteger weeksToDisplay;

/**
 Week day background color.
 */
@property (nonatomic, strong) UIColor *weekDayBgColor;

/**
 Calendar background color.
 */
@property (nonatomic, strong) UIColor *calendarBgColor;

/**
 Calendar text font.
 */
@property (nonatomic, strong) UIFont *dayTextFont;

/**
 Calendar text color.
 */
@property (nonatomic, strong) UIColor *dayTextColor;

/**
 Calendar text selected color.
 */
@property (nonatomic, strong) UIColor *dayTextColorSelected;

/**
 Lunar calendar text color.
 */
@property (nonatomic, strong) UIColor *lunarDayTextColor;

/**
 Lunar calendar text selected color.
 */
@property (nonatomic, strong) UIColor *lunarDayTextColorSelected;

/**
 Today text color.
 */
@property (nonatomic, strong) UIColor *dayTextColorToday;

/**
 Line color.
 */
@property (nonatomic, strong) UIColor *lineBgColor;

/**
 The calendar's first selected date defaults to today.
 */
@property (nonatomic, strong) NSDate *defaultDate;

/**
 Other months calendar text font.
 */
@property (nonatomic, strong) UIFont *dayTextFontOtherMonth;

/**
 Other months lunar calendar text font.
 */
@property (nonatomic, strong) UIFont *lunarDayTextFontOtherMonth;

/**
 Other months calendar text color.
 */
@property (nonatomic, strong) UIColor *dayTextColorOtherMonth;

/**
 Other months lunar calendar text color.
 */
@property (nonatomic, strong) UIColor *lunarDayTextColorOtherMonth;

/**
 Select the color of the date solid circle.
 */
@property (nonatomic, strong) UIColor *dayCircleColorSelected;

/**
 The color of today's solid circle.
 */
@property (nonatomic, strong)  UIColor *dayCircleColorToday;

/**
 The color of today's outer circle.
 */
@property (nonatomic, strong) UIColor *dayBorderColorToday;

/**
 Default point color for special dates.
 */
@property (nonatomic, strong) UIColor *dayEventColor;

/**
 Date the size of a solid circle.
 */
@property (assign, nonatomic) CGFloat dayCircleSize;

/**
 Default point size for special dates.
 */
@property (assign, nonatomic) CGFloat dayDotSize;

/**
 Week title text color.
 */
@property (strong, nonatomic) UIColor *weekDayTextColor;

/**
 Week title text font.
 */
@property (strong, nonatomic) UIFont *weekDayTextFont;

/**
 Whether the default selection effect is supported.
 */
@property (nonatomic, assign) BOOL defaultSelected;

/**
 Display months.
 */
@property (nonatomic, assign) NSInteger months;

/**
 Whether grid lines are displayed.
 */
@property (nonatomic, assign) BOOL hiddenGridLine;



/**
 EXCalendarAppearance singleton.

 @return EXCalendarAppearance.
 */
+ (EXCalendarApperance *)apperance;


/**
 Standard calendarc.

 @return calendar.
 */
- (NSCalendar *)calendar;

@end
