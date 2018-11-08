//
//  EXCalendarCollectionViewFlowLayout.h
//  EXCalendar
//
//  Created by Eric on 2018/11/8.
//  Copyright © 2018 ex. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EXCalendarCollectionViewFlowLayout : UICollectionViewFlowLayout

@property (nonatomic, assign) NSInteger itemCountPerRow;

@property (nonatomic, assign) NSInteger rowCountPerPage;

@end
