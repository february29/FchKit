//
//  BMultiLevelTable.h
//  KT
//
//  Created by bai on 2018/10/24.
//  Copyright © 2018年 北京仙指信息技术有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMultiLevelModel.h"
#import "BMultiLevelTableViewCell.h"

@protocol BMultiLevelTableViewDelegate <NSObject>


/**
 cell
 注意 indexPath 为cell中的实际位置，与外部的noses中的位置不一定相同

 @param tableView table
 @param indexPath 实际位置
 @param node node
 @return cell
 */
- (UITableViewCell*)multiLevelTable:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath model:(BMultiLevelModel *)node;

- (void)multiLevelTable:(UITableView *)tableView didSelectModel:(BMultiLevelModel *)node;

@end


NS_ASSUME_NONNULL_BEGIN

@interface BMultiLevelTableView : UITableView


- (id)initWithFrame:(CGRect)frame rootNodeID:(NSString*)rootID;

@property (nonatomic, strong) NSMutableArray<BMultiLevelModel *> *nodes;
@property (nonatomic,copy) NSString *rootID;

//@property (nonatomic,copy) NSString *pIdPropertyName;
//@property (nonatomic,copy) NSString *idPropertyName;
//
//@property (nonatomic,copy) NSString *showPropertyName;

@property (nonatomic, weak, nullable) id <BMultiLevelTableViewDelegate> multiLevelTableDelegate;


- (void)foldNodesForLevel:(NSUInteger)level currentIndex:(NSUInteger)currentIndex;

- (NSUInteger)expandNodesForParentID:(NSString*)parentID insertIndex:(NSUInteger)insertIndex;

@end

NS_ASSUME_NONNULL_END
