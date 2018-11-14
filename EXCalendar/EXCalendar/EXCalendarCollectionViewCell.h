//
//  EXCalendarCollectionViewCell.h
//  EXCalendar
//
//  Created by Eric on 2018/11/8.
//  Copyright © 2018 ex. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EXCalendarDayItem.h"

@interface EXCalendarCollectionViewCell : UICollectionViewCell

/**
 Whether the day is selected.
 */
@property (nonatomic, assign) BOOL isSelected;

/**
 Load cell data.

 @param model Cell data.
 */
- (void)loadData:(EXCalendarDayItem *)model;

@end
