//
//  ViewController.m
//  EXCalendar
//
//  Created by Eric on 2018/11/8.
//  Copyright © 2018 ex. All rights reserved.
//

#import "ViewController.h"
#import "EXCalendarManager.h"
#import "EXCalendarView.h"
#import "EXCalendarApperance.h"

@interface ViewController ()<EXCalendarDelegate>

@property (nonatomic, strong) UILabel *yearMonthLabel;
@property (nonatomic, strong) EXCalendarManager *manager;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSArray *eventDates = @[@"2019-03-11",@"2019-03-18",@"2019-03-25"];
    
    UILabel *yearMonthLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 45, self.view.frame.size.width, 20)];
    yearMonthLabel.textColor = [UIColor blackColor];
    yearMonthLabel.textAlignment = NSTextAlignmentCenter;
    self.yearMonthLabel = yearMonthLabel;
    [self.view addSubview:yearMonthLabel];
    
    [EXCalendarApperance apperance].weekTitleHeight = 30;
    [EXCalendarApperance apperance].hiddenGridLine = YES;
    [EXCalendarApperance apperance].dayTextFont = [UIFont systemFontOfSize:14];
    
    self.manager = [EXCalendarManager manager];
    
    self.manager.calendarWeekView = [[EXCalendarWeekView alloc] initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 30)];
    [self.view addSubview:self.manager.calendarWeekView];
    
    self.manager.calendarView = [[EXCalendarView alloc] initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 260)];
    self.manager.calendarView.delegate = self;
    [self.manager.calendarView createCalendarData];
    [self.manager.calendarView scrollToCenterMonth];
    [self.manager.calendarView refreshEventDate:eventDates];
    [self.manager.calendarView.calendarCollectionView reloadData];
    
    [self.view addSubview:_manager.calendarView];
    
    [self loadCurrentMonth];
}


- (void)loadCurrentMonth {
    NSDate *currentDate = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:currentDate];
    NSInteger year = [dateComponent year];
    NSInteger month = [dateComponent month];
    self.yearMonthLabel.text = [NSString stringWithFormat:@"%ld年%ld月", (long)year,(long)month];
}


#pragma mark - EXCalendarDelegate
- (void)calendarDidScrollYear:(NSInteger)year month:(NSInteger)month {
    self.yearMonthLabel.text = [NSString stringWithFormat:@"%ld年%ld月", (long)year,(long)month];
}


@end
