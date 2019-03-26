//
//  EXCalendarView.h
//  EXCalendar
//
//  Created by Eric on 2018/11/9.
//  Copyright © 2018 ex. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EXCalendarWeekView.h"
#import "EXCalendarCollectionViewFlowLayout.h"
#import "EXCalendarDayItem.h"
#import "EXCalendarDelegate.h"

@interface EXCalendarView : UIView

/**
 Calendar collection view.
 */
@property (nonatomic, strong) UICollectionView *calendarCollectionView;

/**
 Flow layout.
 */
@property (nonatomic, strong) EXCalendarCollectionViewFlowLayout *flowLayout;

/**
 Week view.
 */
@property (nonatomic, strong) EXCalendarWeekView *weekView;



/**
 All months data.
 */
@property (nonatomic, strong) NSArray<NSArray<EXCalendarDayItem *> *> *monthsData;

/**
 One month data.
 */
@property (nonatomic, strong) NSArray<EXCalendarDayItem *> *monthData;

/**
 Current date.
 */
@property (nonatomic, strong) NSDate *currentDate;

/**
 Selected date.
 */
@property (nonatomic, strong) NSDate *selectedDate;

/**
 EXCalendar delegate.
 */
@property (nonatomic, weak) id<EXCalendarDelegate> delegate;



/**
 Create calendar data.
 */
- (void)createCalendarData;

/**
 Scroll to current month.
 */
- (void)scrollToCenterMonth;

/**
 Scroll to previous month section.
 */
- (void)scrollToPreviousMonth;

/**
 Scroll to next month section.
 */
- (void)scrollToNextMonth;

/**
 Refresh specified date.
 */
- (void)refreshEventDate:(NSArray *)dateArray;
@end
