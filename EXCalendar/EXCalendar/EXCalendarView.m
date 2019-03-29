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
 The last index path that need to be change color.
 */
@property (nonatomic, strong) NSIndexPath *lastSelectedIndexPath;

/**
 The last month that need to be change color.
 */
@property (nonatomic, assign) int lastSelectedMonth;

/**
 Cell item size.
 */
@property (nonatomic, assign) CGSize itemSize;

/**
 Whether loaded.
 */
@property (nonatomic, assign) BOOL isLoaded;

/**
 Event date array.
 */
@property (nonatomic, strong) NSArray *eventDateArray;

/**
 Need scroll to center month.
 */
@property (nonatomic, assign) BOOL needScrollToCenter;

@end


@implementation EXCalendarView
#pragma mark - InitView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.apperance = [EXCalendarApperance apperance];
        self.lastSelectedMonth = -1;
        
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
        
        item.eventCircleColor = _apperance.dayEventColor;
        [daysOfweek addObject:item];
        
        NSDateComponents *dayComponent = [[NSDateComponents alloc] init];
        dayComponent.day = 1;
        
        currentDate = [calendar dateByAddingComponents:dayComponent toDate:currentDate options:0];
    }
    
    return  daysOfweek;
}


- (void)updateCalendar {
    [self createCalendarData];
    [self refreshEventDate:_eventDateArray];
    [UIView performWithoutAnimation:^{
        [self.calendarCollectionView reloadData];
    }];
}


- (void)refreshEventDate:(NSArray *)dateArray {
    if (!dateArray) {
        return;
    }
    
    self.eventDateArray = dateArray;
    for (NSArray *monthDay in _monthsData) {
        for (EXCalendarDayItem *item in monthDay) {
            NSDateFormatter *format = [[NSDateFormatter alloc] init];
            [format setDateFormat:@"yyyy-MM-dd"];
            NSString *dateString = [format stringFromDate:item.date];
            NSArray *predicateArray = [_eventDateArray filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"self = %@", dateString]];
            if (predicateArray && predicateArray.count > 0) {
                item.eventDate = [predicateArray firstObject];
            }
        }
    }
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
    [cell loadEvent:model.eventDate];
    
    if ([self isToday:model.date]) {
        self.currentSelectedIndexPath = indexPath;
    }
    
    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    EXCalendarCollectionViewCell *cell = (EXCalendarCollectionViewCell*)[collectionView cellForItemAtIndexPath:indexPath];
    cell.isSelected = YES;
    
    // Selected circle change.
    if ((cell.viewData.dateOfMonth != _lastSelectedMonth || indexPath.row != _lastSelectedIndexPath.row)) {
        EXCalendarCollectionViewCell *lastCell = (EXCalendarCollectionViewCell*)[collectionView cellForItemAtIndexPath:_lastSelectedIndexPath];
        
        BOOL isOtherMonth = NO;
        if (!lastCell) {
            [collectionView scrollToItemAtIndexPath:_lastSelectedIndexPath atScrollPosition:0 animated:NO];
            [collectionView layoutIfNeeded];
            
            lastCell = (EXCalendarCollectionViewCell*)[collectionView cellForItemAtIndexPath:_lastSelectedIndexPath];
            
            if (_lastSelectedMonth >=0) {
                isOtherMonth = YES;
            }
        }
        
        if (isOtherMonth) {
            [collectionView setContentOffset:CGPointMake(self.frame.size.width * indexPath.section, 0) animated:NO];
        }
        
        lastCell.isSelected = NO;
        
        self.lastSelectedIndexPath = indexPath;
        self.lastSelectedMonth = cell.viewData.dateOfMonth;
    }
    
    if ([self.delegate respondsToSelector:@selector(calendarDidSelectedDate:)]) {
        [self.delegate calendarDidSelectedDate:cell.viewData.date];
    }
}


- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    self.currentSelectedIndexPath = [self obtainCurrentIndexPath];
    self.currentDate = _monthsData[_currentSelectedIndexPath.section][15].date;
    
    if ([self.delegate respondsToSelector:@selector(calendarDidScrollYear:month:)]) {
        NSCalendar *calendar = _apperance.calendar;
        
        NSDateComponents *currentDateComponents =[calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitWeekday|NSCalendarUnitWeekOfMonth|NSCalendarUnitHour fromDate:_currentDate];
        [self.delegate calendarDidScrollYear:currentDateComponents.year month:currentDateComponents.month];
    }
    
    if (_needScrollToCenter) {
        _needScrollToCenter = NO;
        [self scrollToCenterMonth];
    }
}


#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self refreshEventDate:_eventDateArray];
    if (_currentSelectedIndexPath.section == 0 || _currentSelectedIndexPath.section == _monthsData.count - 1) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.needScrollToCenter = YES;
            [self updateCalendar];
        });
    }
}


- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    [self refreshEventDate:_eventDateArray];
    if (_currentSelectedIndexPath.section == 0 || _currentSelectedIndexPath.section == _monthsData.count - 1) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.needScrollToCenter = YES;
            [self updateCalendar];
        });
    }
}


#pragma mark - Calendar position
- (void)scrollToCenterMonth {
    [self.calendarCollectionView setContentOffset:CGPointMake(self.frame.size.width * round(_monthsData.count / 2), 0)];
}


- (NSIndexPath *)obtainCurrentIndexPath {
    CGPoint point = [self convertPoint:self.calendarCollectionView.center toView:self.calendarCollectionView];
    NSIndexPath *indexPath = [self.calendarCollectionView indexPathForItemAtPoint:point];
    return indexPath;
}


- (void)scrollToPreviousMonth:(BOOL)animated {
    NSInteger index = _currentSelectedIndexPath.section - 1;
    [self.calendarCollectionView setContentOffset:CGPointMake(self.frame.size.width * index, 0) animated:animated];
}


- (void)scrollToNextMonth:(BOOL)animated {
    NSInteger index = _currentSelectedIndexPath.section + 1;
    [self.calendarCollectionView setContentOffset:CGPointMake(self.frame.size.width * index, 0) animated:animated];
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
    
    return [[dateFormatter stringFromDate:date] isEqualToString:[dateFormatter stringFromDate:[NSDate date]]];
}

@end
