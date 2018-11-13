//
//  EXCalendarCollectionViewCell.m
//  EXCalendar
//
//  Created by Eric on 2018/11/8.
//  Copyright © 2018 ex. All rights reserved.
//

#import "EXCalendarCollectionViewCell.h"
#import "EXCalendarApperance.h"

@interface EXCalendarCollectionViewCell ()

/**
 Date label.
 */
@property (nonatomic, strong) UILabel *dateLabel;

@end


@implementation EXCalendarCollectionViewCell
#pragma mark - InitView
- (instancetype)init {
    if (self = [super init]) {
        [self createContentView];
    }
    return self;
}


- (void)createContentView {
    UILabel *dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 17, self.frame.size.width, self.frame.size.height)];
    dateLabel.font = [EXCalendarApperance apperance].dayTextFont;
    dateLabel.textAlignment = NSTextAlignmentLeft;
    dateLabel.textColor = [EXCalendarApperance apperance].dayTextColor;
    self.dateLabel = dateLabel;
    [self addSubview:_dateLabel];
    
    UILabel *topLine = [[UILabel alloc] initWithFrame:CGRectMake(0, -0.5, self.frame.size.width, 1)];
    topLine.backgroundColor = [UIColor colorWithRed:181/255 green:181/255 blue:181/255 alpha:1];
    [self addSubview:topLine];
    
    UILabel *leftLine = [[UILabel alloc] initWithFrame:CGRectMake(-0.5, 0, 1, self.frame.size.height)];
    leftLine.backgroundColor = [UIColor colorWithRed:181/255 green:181/255 blue:181/255 alpha:1];
    [self addSubview:leftLine];
    
    UILabel *rightLine = [[UILabel alloc] initWithFrame:CGRectMake(self.bounds.size.width - 0.5, 0, 1, self.frame.size.height)];
    rightLine.backgroundColor =[UIColor colorWithRed:181/255 green:181/255 blue:181/255 alpha:1];
    [self addSubview:rightLine];
    
    UILabel *bottomLine = [[UILabel alloc] initWithFrame:CGRectMake(0, self.bounds.size.height - 0.5, self.frame.size.width, 1)];
    bottomLine.backgroundColor = [UIColor colorWithRed:181/255 green:181/255 blue:181/255 alpha:1];
    [self addSubview:bottomLine];
}


#pragma mark - LoadData
- (void)loadData:(EXCalendarDayItem *)model {
    
    static NSDateFormatter *dateFormatter;
    if(!dateFormatter){
        dateFormatter = [NSDateFormatter new];
        dateFormatter.timeZone = [EXCalendarApperance apperance].calendar.timeZone;
        [dateFormatter setDateFormat:@"dd"];
    }
    
    self.dateLabel.text = [dateFormatter stringFromDate:model.date];
}

@end
