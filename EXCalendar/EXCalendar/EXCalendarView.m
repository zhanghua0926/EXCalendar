//
//  EXCalendarView.m
//  EXCalendar
//
//  Created by Eric on 2018/11/9.
//  Copyright © 2018 ex. All rights reserved.
//

#import "EXCalendarView.h"
#import "EXCalendarApperance.h"
#import "EXCalendarCollectionViewCell.h"
#import "EXCalendarManager.h"

@interface EXCalendarView ()<UICollectionViewDataSource, UICollectionViewDelegate, UIScrollViewDelegate>

/**
 Calendar apperance.
 */
@property (nonatomic, strong) EXCalendarApperance *apperance;


/**
 Current month index.
 */
@property (nonatomic, assign) NSInteger currentMonthIndex;

/**
 System current month index.
 */
@property (nonatomic, assign) NSInteger systemCurrentMonthIndex;

/**
 Selected index path for obtain cell.
 */
@property (nonatomic, strong) NSIndexPath *currentSelectedIndexPath;

/**
 Cell item size.
 */
@property (nonatomic, assign) CGSize itemSize;

/**
 Whether loaded.
 */
@property (nonatomic, assign) BOOL isLoaded;

@end


@implementation EXCalendarView
#pragma mark - InitView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.apperance = [EXCalendarApperance apperance];
        
        [self createContentView];
    }
    return self;
}


- (void)createContentView {
    self.itemSize = CGSizeMake(self.frame.size.width / 7, (self.frame.size.height - _apperance.weekTitleHeight) / _apperance.weeksToDisplay);
    
    EXCalendarCollectionViewFlowLayout *flowLayout = [[EXCalendarCollectionViewFlowLayout alloc] init];
    flowLayout.sectionInset = UIEdgeInsetsZero;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.itemSize = _itemSize;
    flowLayout.itemCountPerRow = 7;
    flowLayout.rowCountPerPage = _apperance.weeksToDisplay;
    flowLayout.minimumLineSpacing = 0;
    flowLayout.minimumInteritemSpacing = 0;
    
    CGRect collectionViewFrame = CGRectMake(0, _apperance.weekTitleHeight, self.frame.size.width, self.frame.size.height - _apperance.weekTitleHeight);
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:collectionViewFrame collectionViewLayout:flowLayout];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.pagingEnabled = YES;
    collectionView.showsHorizontalScrollIndicator = false;
    collectionView.backgroundColor =  [UIColor whiteColor];
    [collectionView registerClass:[EXCalendarCollectionViewCell class] forCellWithReuseIdentifier:@"EXCalendarCollectionViewCell"];
    self.calendarCollectionView = collectionView;
    [self addSubview:_calendarCollectionView];
}


#pragma mark - LoadData
- (void)createCalendarData {
    [self createMonthsData];
}


- (void)createMonthsData {
    NSCalendar *calendar = _apperance.calendar;
    
    
    if (self.currentDate == nil) {
        self.currentDate = _apperance.defaultDate;
        self.selectedDate = self.currentDate;
    }
    
    
    NSMutableArray *monthsData = [@[] mutableCopy];
    for(int i = 0; i < _apperance.months; i++){
        NSDateComponents *dayComponent = [[NSDateComponents alloc] init];
        
        dayComponent.month = i - _apperance.months / 2;
        
        // Half of apperance months before and half of months after the current date.
        NSDate *monthDate = [calendar dateByAddingComponents:dayComponent toDate:self.currentDate options:0];
            
        monthDate = [self beginningOfMonth:monthDate];
        [monthsData addObject:[self daysOfMonth:monthDate]];
    }
    
    self.systemCurrentMonthIndex = _apperance.months / 2;
    self.monthsData = monthsData;
}


- (NSDate *)beginningOfMonth:(NSDate *)date {
    NSCalendar *calendar = _apperance.calendar;
    
    NSDateComponents *currentDateComponents =[calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitWeekday|NSCalendarUnitWeekOfMonth|NSCalendarUnitHour fromDate:date];
    currentDateComponents.timeZone = [NSTimeZone systemTimeZone];
    
    
    NSDateComponents *components = [NSDateComponents new];
    
    components.year = currentDateComponents.year;
    components.month = currentDateComponents.month;
    components.hour = currentDateComponents.hour;
    components.weekOfMonth = 1;
    components.weekday = calendar.firstWeekday;
    components.timeZone = [NSTimeZone systemTimeZone];
    
    return [calendar dateFromComponents:components];
    
}


- (NSArray *)daysOfMonth:(NSDate *)date {
    NSDate *currentDate = date;
    
    NSCalendar *calendar = _apperance.calendar;
    
    NSMutableArray *monthData = [@[] mutableCopy];
   
    NSDateComponents *componets = [calendar components:NSCalendarUnitMonth|NSCalendarUnitDay fromDate:currentDate];
        
    self.currentMonthIndex = componets.month;
    
    // The first day of the month which is not 1 is the last month.
    if(componets.day > 1){
        self.currentMonthIndex = (self.currentMonthIndex % 12) + 1;
    }
    
    for (NSInteger i = 0; i < _apperance.weeksToDisplay; i++) {
        NSDateComponents *dayComponent = [[NSDateComponents alloc] init];
        dayComponent.day = 7;
        
        NSArray *array = [self daysOfWeek:currentDate];
        
        [monthData addObjectsFromArray:array];
        currentDate = [calendar dateByAddingComponents:dayComponent toDate:currentDate options:0];
    }
    
    return monthData;
}


- (NSArray *)daysOfWeek:(NSDate *)date {
    NSDate *currentDate = date;
    
    NSCalendar *calendar = _apperance.calendar;
    
    //one week date
    NSMutableArray *daysOfweek = [@[] mutableCopy];
    
    for (int i = 0; i < 7; i++) {
        NSDateComponents *comps = [calendar components:NSCalendarUnitMonth | NSCalendarUnitWeekOfMonth fromDate:currentDate];
        NSInteger monthIndex = comps.month;
        
        EXCalendarDayItem *item = [[EXCalendarDayItem alloc] init];
        item.isOtherMonth = monthIndex != self.currentMonthIndex;
        item.date = currentDate;
        
        if ([self isSameDay:currentDate compareDate:_currentDate]) {
            item.isSelected = YES;
        }
        
        item.eventCircleColor = _apperance.dayEventColor;
        [daysOfweek addObject:item];
        
        NSDateComponents *dayComponent = [[NSDateComponents alloc] init];
        dayComponent.day = 1;
        
        currentDate = [calendar dateByAddingComponents:dayComponent toDate:currentDate options:0];
    }
    return  daysOfweek;
    
}


#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return _monthsData.count;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _monthsData[section].count;
}


#pragma mark - UICollectionViewDelegate
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * CellIdentifier = @"EXCalendarCollectionViewCell";
    EXCalendarCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    if (!cell) {
        cell = [[EXCalendarCollectionViewCell alloc] initWithFrame:CGRectMake(0, 0, _itemSize.width, _itemSize.height)];
    }
    
    NSArray *monthData = _monthsData[indexPath.section];
    EXCalendarDayItem *model = monthData[indexPath.row];
    [cell loadData:model];
    
    if ([self isToday:model.date]) {
        self.currentSelectedIndexPath = indexPath;
    }
    
    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    EXCalendarCollectionViewCell *cell = (EXCalendarCollectionViewCell*)[collectionView cellForItemAtIndexPath:indexPath];
    cell.isSelected = YES;
    
    // Selected circle change.
    if (indexPath.section != _currentSelectedIndexPath.section || indexPath.row != _currentSelectedIndexPath.row) {
        EXCalendarCollectionViewCell *lastCell = (EXCalendarCollectionViewCell*)[collectionView cellForItemAtIndexPath:_currentSelectedIndexPath];
        lastCell.isSelected = NO;
        self.currentSelectedIndexPath = indexPath;
    }
    
    if ([self.delegate respondsToSelector:@selector(calendarDidSelectedDate:)]) {
        [self.delegate calendarDidSelectedDate:cell.viewData.date];
    }
}


- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
//    if (indexPath.section != _currentSelectedIndexPath.section) {
//        // The same day is selected by default for other months
//        NSIndexPath *indexPathForMonth = [NSIndexPath indexPathForRow:indexPath.section inSection:_currentSelectedIndexPath.row];
//        EXCalendarCollectionViewCell *currentCell = (EXCalendarCollectionViewCell*)[collectionView cellForItemAtIndexPath:indexPathForMonth];
//        currentCell.isSelected = YES;
//
//        EXCalendarCollectionViewCell *lastCell = (EXCalendarCollectionViewCell*)[collectionView cellForItemAtIndexPath:_currentSelectedIndexPath];
//        lastCell.isSelected = NO;
//        self.currentSelectedIndexPath = indexPath;
//    }
//    NSLog(@"%@", indexPath);
}


#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
//    NSIndexPath *indexPath = [self obtainCurrentIndexPath];
//    if (indexPath.section != _currentSelectedIndexPath.section) {
//        // The same day is selected by default for other months
//        NSIndexPath *indexPathForMonth = [NSIndexPath indexPathForRow:indexPath.section inSection:_currentSelectedIndexPath.row];
//        EXCalendarCollectionViewCell *currentCell = (EXCalendarCollectionViewCell*)[_calendarCollectionView cellForItemAtIndexPath:indexPathForMonth];
//        currentCell.isSelected = YES;
//        
//        EXCalendarCollectionViewCell *lastCell = (EXCalendarCollectionViewCell*)[_calendarCollectionView cellForItemAtIndexPath:_currentSelectedIndexPath];
//        lastCell.isSelected = NO;
//        self.currentSelectedIndexPath = indexPath;
//    }
}


#pragma mark - Calendar position
- (void)scrollViewDidScrollToSystemCurrentMonth {
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:17 inSection:_systemCurrentMonthIndex];
    [self.calendarCollectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
}


- (void)repositionViews {
    [self.calendarCollectionView setContentOffset:CGPointMake(self.frame.size.width*round(_monthsData.count / 2), 0)];
}


- (NSIndexPath *)obtainCurrentIndexPath {
    CGPoint point = [self convertPoint:self.calendarCollectionView.center toView:self.calendarCollectionView];
    NSIndexPath *indexPath = [self.calendarCollectionView indexPathForItemAtPoint:point];
    return indexPath;
}


#pragma mark - Date compare
- (BOOL)isSameDay:(NSDate *)date
      compareDate:(NSDate *)compareDate {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.timeZone = _apperance.calendar.timeZone;
    dateFormatter.dateFormat = @"yyyy-MM-dd";
    
    return [[dateFormatter stringFromDate:date] isEqualToString:[dateFormatter stringFromDate:compareDate]];
}


- (BOOL)isToday:(NSDate *)date {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.timeZone = [EXCalendarApperance apperance].calendar.timeZone;
    dateFormatter.dateFormat = @"yyyy-MM-dd";
    
    NSDate *gmtDate = [NSDate date];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate:gmtDate];
    NSDate *currentDate = [gmtDate  dateByAddingTimeInterval: interval];
    
    return [[dateFormatter stringFromDate:date] isEqualToString:[dateFormatter stringFromDate:currentDate]];
}

@end
