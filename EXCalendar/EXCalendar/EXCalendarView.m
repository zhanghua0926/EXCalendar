//
//  EXCalendarView.m
//  EXCalendar
//
//  Created by Eric on 2018/11/9.
//  Copyright © 2018 ex. All rights reserved.
//

#import "EXCalendarView.h"
#import "EXCalendarAppearance.h"
#import "EXCalendarCollectionViewCell.h"

@interface EXCalendarView ()<UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) EXCalendarAppearance *apperance;

@end


@implementation EXCalendarView
#pragma mark - InitView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.apperance = [[EXCalendarAppearance alloc] init];
    }
    return self;
}


- (void)createContentView {
    EXCalendarCollectionViewFlowLayout *flowLayout = [[EXCalendarCollectionViewFlowLayout alloc] init];
    flowLayout.sectionInset = UIEdgeInsetsZero;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.itemSize = CGSizeMake(self.frame.size.width / 7, [EXCalendarAppearance apperance].weekTitleHeight);
    flowLayout.itemCountPerRow = 7;
    flowLayout.rowCountPerPage = [EXCalendarAppearance apperance].weeksToDisplay;
    flowLayout.minimumLineSpacing = 0;
    flowLayout.minimumInteritemSpacing = 0;
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, [EXCalendarAppearance apperance].weekTitleHeight, self.frame.size.width, self.frame.size.height) collectionViewLayout:flowLayout];
    [self addSubview:collectionView];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.pagingEnabled = YES;
    collectionView.showsHorizontalScrollIndicator = false;
    collectionView.backgroundColor =  [UIColor whiteColor];
    [collectionView registerClass:[EXCalendarCollectionViewCell class] forCellWithReuseIdentifier:@"EXCalendarCollectionViewCell"];
}


#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 1;
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
