//
//  EXCalendarCollectionViewFlowLayout.m
//  EXCalendar
//
//  Created by Eric on 2018/11/8.
//  Copyright © 2018 ex. All rights reserved.
//

#import "EXCalendarCollectionViewFlowLayout.h"

@interface EXCalendarCollectionViewFlowLayout ()

@property (nonatomic, strong) NSMutableArray *allAttributes;

@end


@implementation EXCalendarCollectionViewFlowLayout

- (void)prepareLayout {
    [super prepareLayout];
    
    self.allAttributes = [NSMutableArray array];
    
    NSInteger sections = [self.collectionView numberOfSections];
    for (int i = 0; i < sections; i++) {
        
        // setup one section attributes.
        NSMutableArray *tmpArray = [NSMutableArray array];
        
        NSInteger count = [self.collectionView numberOfItemsInSection:i];
        
        for (NSInteger j = 0; j < count; j++) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:j inSection:i];
            UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForItemAtIndexPath:indexPath];
            [tmpArray addObject:attributes];
        }
        
        [self.allAttributes addObject:tmpArray];
    }
}


- (CGSize)collectionViewContentSize {
    return [super collectionViewContentSize];
}


- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger item = indexPath.item;
    NSInteger x;
    NSInteger y;
    
    // 根据item的序号计算出item的行列位置
    [self targetPositionWithItem:item resultX:&x resultY:&y];
    
    // 根据已得出的item的行列位置，将item放入indexPath中对应的位置。
    NSInteger item2 =  [self orignItemAtX:x y:y];
    NSIndexPath *theNewIndexPath = [NSIndexPath indexPathForItem:item2 inSection:indexPath.section];
    
    UICollectionViewLayoutAttributes *theNewAttr = [super layoutAttributesForItemAtIndexPath:theNewIndexPath];
    theNewAttr.indexPath = indexPath;
    return theNewAttr;
}


- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSArray *attributes = [super layoutAttributesForElementsInRect:rect];
    
    NSMutableArray *tmp = [NSMutableArray array];
    
    for (UICollectionViewLayoutAttributes *attr in attributes) {
        for (NSMutableArray *attributes in self.allAttributes)
        {
            for (UICollectionViewLayoutAttributes *attr2 in attributes) {
                if (attr.indexPath.item == attr2.indexPath.item) {
                    [tmp addObject:attr2];
                    break;
                }
            }
            
        }
    }
    return tmp;
}


// 根据item计算目标item的位置。
- (void)targetPositionWithItem:(NSInteger)item
                       resultX:(NSInteger *)x
                       resultY:(NSInteger *)y {
    //    NSInteger page = item / (self.itemCountPerRow * self.rowCountPerPage);
    
    NSInteger theX = item % self.itemCountPerRow;
    NSInteger theY = item / self.itemCountPerRow;
    
    if (x != NULL) {
        *x = theX;
    }
    
    if (y != NULL) {
        *y = theY;
    }
}


- (NSInteger)orignItemAtX:(NSInteger)x
                        y:(NSInteger)y {
    NSInteger item = x * self.rowCountPerPage + y;
    return item;
}


@end
