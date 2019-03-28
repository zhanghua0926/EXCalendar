//
//  EXCalendarDayItem.h
//  EXCalendar
//
//  Created by Eric on 2018/11/12.
//  Copyright © 2018 ex. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface EXCalendarDayItem : NSObject

/**
 Date.
 */
@property (nonatomic, strong) NSDate *date;

/**
 Month
 */
@property (nonatomic, assign) int dateOfMonth;

/**
 Whether other month.
 */
@property (nonatomic, assign) BOOL isOtherMonth;

/**
 Selecte.
 */
@property (nonatomic, assign) BOOL isSelected;

/**
 The specified event circle color.
 */
@property (nonatomic, strong) UIColor *eventCircleColor;

/**
 Display event dot.
 */
@property (nonatomic, assign) BOOL showEventDot;

/**
 Display event date.
 */
@property (nonatomic, strong) NSDate *eventDate;

@end
