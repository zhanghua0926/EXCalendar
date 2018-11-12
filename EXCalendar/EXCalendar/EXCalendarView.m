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

@interface EXCalendarView ()<UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) EXCalendarApperance *apperance;

@end


@implementation EXCalendarView
#pragma mark - InitView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.apperance = [[EXCalendarApperance alloc] init];
    }
    return self;
}


- (void)createContentView {
    EXCalendarCollectionViewFlowLayout *flowLayout = [[EXCalendarCollectionViewFlowLayout alloc] init];
    flowLayout.sectionInset = UIEdgeInsetsZero;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.itemSize = CGSizeMake(self.frame.size.width / 7, [EXCalendarApperance apperance].weekTitleHeight);
    flowLayout.itemCountPerRow = 7;
    flowLayout.rowCountPerPage = [EXCalendarApperance apperance].weeksToDisplay;
    flowLayout.minimumLineSpacing = 0;
    flowLayout.minimumInteritemSpacing = 0;
    
    CGRect collectionViewFrame = CGRectMake(0, [EXCalendarApperance apperance].weekTitleHeight, self.frame.size.width, self.frame.size.height - [EXCalendarApperance apperance].weekTitleHeight);
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:collectionViewFrame collectionViewLayout:flowLayout];
    [self addSubview:collectionView];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.pagingEnabled = YES;
    collectionView.showsHorizontalScrollIndicator = false;
    collectionView.backgroundColor =  [UIColor whiteColor];
    [collectionView registerClass:[EXCalendarCollectionViewCell class] forCellWithReuseIdentifier:@"EXCalendarCollectionViewCell"];
}


#pragma mark -LoadData
- (void)createCalendarData {
    [self createMonthsData];
}


- (void)createMonthsData {
    NSCalendar *calendar = [EXCalendarApperance apperance].calendar;
    
    
    if (self.currentDate == nil) {
        self.currentDate = [EXCalendarApperance apperance].defaultDate;
        self.selectedDate = self.currentDate;
    }
    
    
    NSMutableArray *daysInMonths = [@[] mutableCopy];
    for(int i = 0; i < [EXCalendarApperance apperance].months; i++){
        NSDateComponents *dayComponent = [[NSDateComponents alloc] init];
        dayComponent.month = i - [EXCalendarApperance apperance].months / 2;
        
        // Half of apperance months before and half of months after the current date.
        NSDate *monthDate = [calendar dateByAddingComponents:dayComponent toDate:self.currentDate options:0];
            
        monthDate = [self beginningOfMonth:monthDate];
//        [daysInMonths addObject:[self getDaysOfMonth:monthDate]];
        
        }
        
//    self.daysInMonth = daysInMonths;
}


- (NSDate *)beginningOfMonth:(NSDate *)date {
    NSCalendar *calendar = [EXCalendarApperance apperance].calendar;
    
    NSDateComponents *componentsCurrentDate =[calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitWeekday|NSCalendarUnitWeekOfMonth|NSCalendarUnitHour fromDate:date];
    
    
    NSDateComponents *componentsNewDate = [NSDateComponents new];
    
    componentsNewDate.year = componentsCurrentDate.year;
    componentsNewDate.month = componentsCurrentDate.month;
    componentsNewDate.weekOfMonth = 1;
    componentsNewDate.weekday = calendar.firstWeekday;
    
    return [calendar dateFromComponents:componentsNewDate];
    
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
        cell = [[EXCalendarCollectionViewCell alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    }
    
//    NSString *model = [_demoNumArray objectAtIndex:[indexPath row]];
//    [cell loadData:model];
    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}

@end
