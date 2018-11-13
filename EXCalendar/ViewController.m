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

@interface ViewController ()

@property (nonatomic, strong) EXCalendarManager *manager;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.manager = [EXCalendarManager manager];
    self.manager.calendarView = [[EXCalendarView alloc] initWithFrame:CGRectMake(10, 150, 300, 400)];
    [self.manager.calendarView createCalendarData];
    [self.manager.calendarView.calendarCollectionView reloadData];
    
    [self.view addSubview:_manager.calendarView];
}


@end
