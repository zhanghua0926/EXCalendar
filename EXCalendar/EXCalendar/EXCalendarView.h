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



- (void)createCalendarData;

- (void)scrollViewDidScrollToSystemCurrentMonth;

- (void)repositionViews;

@end
