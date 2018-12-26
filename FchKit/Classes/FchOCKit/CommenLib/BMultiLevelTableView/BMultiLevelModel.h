//
//  BMultiLevelModel.h
//  KT
//
//  Created by bai on 2018/10/24.
//  Copyright © 2018年 北京仙指信息技术有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BMultiLevelModel : NSObject


@property (nonatomic, strong) NSString *parentID;

@property (nonatomic, strong) NSString *childrenID;

@property (nonatomic, strong) NSString *name;

@property (nonatomic, assign) NSUInteger level;// depth in the tree sturct

@property (nonatomic, assign, getter=isExpand) BOOL expand;

@property (nonatomic, assign, getter=isLeaf) BOOL leaf;

@property (nonatomic, assign, getter=isRoot) BOOL root;


@property (nonatomic,strong) id data;
/**
 *  初始化节点
 *
 *  @param parentID parent node's ID
 *  @param name       node's name
 *  @param childrenID this node's ID
 *  @param level      depth in the tree
 *  @param bol        this node's child node is expand or not
 */
+ (instancetype)nodeWithParentID:(NSString*)parentID name:(NSString*)name childrenID:(NSString*)childrenID level:(NSInteger)level isExpand:(BOOL)bol;

@end

NS_ASSUME_NONNULL_END
