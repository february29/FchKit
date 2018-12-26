//
//  BMultiLevelTable.m
//  KT
//
//  Created by bai on 2018/10/24.
//  Copyright © 2018年 北京仙指信息技术有限公司. All rights reserved.
//

#import "BMultiLevelTableView.h"
#import "BMultiLevelTableViewCell.h"
@interface BMultiLevelTableView ()<UITableViewDelegate, UITableViewDataSource>


@property (nonatomic, strong) NSMutableArray *tempNodes;

@property (nonatomic, strong) NSMutableArray *reloadArray;



@end

//static CGFloat const cellHeight = 60.0;
@implementation BMultiLevelTableView

-  (id)initWithFrame:(CGRect)frame rootNodeID:(NSString*)rootID{
    self = [self initWithFrame:frame];
    if (self) {
        self.rootID = (!rootID) ? @"" : rootID;
       
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        _tempNodes = [NSMutableArray array];
        _reloadArray = [NSMutableArray array];
        self.delegate = self;
        self.dataSource = self;
        self.separatorStyle =UITableViewCellSeparatorStyleNone;
    }
    return self;
}





- (void)setNodes:(NSMutableArray *)nodes{
    _nodes = nodes;
    [_tempNodes removeAllObjects];
    
    BOOL hasDepth = YES;
    for (int i = 0 ; i<nodes.count;i++) {
        BMultiLevelModel *node = nodes[i];
        
        //judge have set depth or not
        if (node.level <= 0) {
            hasDepth = NO;
        }
        
        //judge leaf node and root node
        BOOL isLeaf = YES;
        BOOL isRoot = YES;
        for (BMultiLevelModel *tempNode in nodes) {
            if ([tempNode.parentID isEqualToString:node.childrenID]) {
                isLeaf = NO;
            }
            if ([tempNode.childrenID isEqualToString:node.parentID]) {
                isRoot = NO;
            }
            if (!isRoot && !isLeaf) {
                break;
            }
        }
        node.leaf = isLeaf;
        node.root = isRoot;
        
        
        // add parent nodes on the upper level
        if ([node.parentID isEqualToString:_rootID]) {
            [_tempNodes addObject:node];
        }
    }
    
    //set depath for all nodes
    if (!hasDepth) {
        [self setDepth:1 parentIDs:@[_rootID] childrenNodes:_nodes];
    }
    
    [self reloadData];
}

- (void)setDepth:(NSUInteger)level parentIDs:(NSArray*)parentIDs childrenNodes:(NSMutableArray*)childrenNodes{
    
    NSMutableArray *newParentIDs = [NSMutableArray array];
    NSMutableArray *leftNodes = [childrenNodes  mutableCopy];
    
    for (BMultiLevelModel *node in childrenNodes) {
        if ([parentIDs containsObject:node.parentID]) {
            node.level = level;
            [leftNodes removeObject:node];
            [newParentIDs addObject:node.childrenID];
        }
    }
    //防止newParentIDs为空时死循环
    if (leftNodes.count>0&&newParentIDs.count>0) {
        level += 1;
        [self setDepth:level parentIDs:[newParentIDs copy] childrenNodes:leftNodes];
    }
}




#pragma mark UITableView delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _tempNodes.count;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return cellHeight;
//}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    BMultiLevelModel *model = [_tempNodes objectAtIndex:indexPath.row];
   
    
    if (self.multiLevelTableDelegate && [self.multiLevelTableDelegate respondsToSelector:@selector(multiLevelTable: cellForRowAtIndexPath: model:)]) {
        UITableViewCell *cell =  [self.multiLevelTableDelegate multiLevelTable:tableView cellForRowAtIndexPath:indexPath model:model];
        return cell;

    }else{
        
        //默认
        static NSString *identifier = @"BMultiLevelTableViewCell";
        BMultiLevelTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[BMultiLevelTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        
        cell.rect  =CGRectMake(0, 0, CGRectGetWidth(self.frame), 45);
        cell.model = model;
        cell.leftImageClickBlock = ^(UIView * _Nonnull image) {
            
            if (!model.isLeaf) {
                model.expand = !model.expand;
                
                
                
                if (model.isExpand) {
                    //expand
                    [self expandNodesForParentID:model.childrenID insertIndex:indexPath.row];
                    
                }else{
                    //fold
                    [self foldNodesForLevel:model.level currentIndex:indexPath.row];
                    
                }
            }
            
            
        };
        
        return cell;
    }
    
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 1;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [UIView new];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    BMultiLevelModel *currentNode = [_tempNodes objectAtIndex:indexPath.row];
    if (self.multiLevelTableDelegate && [self.multiLevelTableDelegate respondsToSelector:@selector(multiLevelTable:didSelectModel:)]) {
        
        [self.multiLevelTableDelegate multiLevelTable:tableView didSelectModel:currentNode];
    }
    
}


//fold
- (void)foldNodesForLevel:(NSUInteger)level currentIndex:(NSUInteger)currentIndex{
    
    
    [_reloadArray removeAllObjects];
    [self reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:currentIndex inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
    
    if (currentIndex+1<_tempNodes.count) {
        NSMutableArray *tempArr = [_tempNodes copy];
        for (NSUInteger i = currentIndex+1 ; i<tempArr.count;i++) {
            BMultiLevelModel *node = tempArr[i];
            if (node.level <= level) {
                break;
            }else{
                [_tempNodes removeObject:node];
                [_reloadArray addObject:[NSIndexPath indexPathForRow:i inSection:0]];//need reload nodes
            }
        }
    }
    [self deleteRowsAtIndexPaths:_reloadArray withRowAnimation:UITableViewRowAnimationNone];
    
}

//expand
- (NSUInteger)expandNodesForParentID:(NSString*)parentID insertIndex:(NSUInteger)insertIndex{
    
    
    [_reloadArray removeAllObjects];
    [self reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:insertIndex inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
    
    for (int i = 0 ; i<_nodes.count;i++) {
        BMultiLevelModel *node = _nodes[i];
        if ([node.parentID isEqualToString:parentID]) {
//            if (!self.isPreservation) {
//                node.expand = NO;
//            }
            insertIndex++;
            [_tempNodes insertObject:node atIndex:insertIndex];
            [_reloadArray addObject:[NSIndexPath indexPathForRow:insertIndex inSection:0]];//need reload nodes
            
            if (node.isExpand) {
                insertIndex = [self expandNodesForParentID:node.childrenID insertIndex:insertIndex];
            }
        }
    }
    [self insertRowsAtIndexPaths:_reloadArray withRowAnimation:UITableViewRowAnimationNone];
    
    return insertIndex;
}

@end
