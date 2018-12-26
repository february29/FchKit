//
//  BMultiLevelModel.m
//  KT
//
//  Created by bai on 2018/10/24.
//  Copyright © 2018年 北京仙指信息技术有限公司. All rights reserved.
//

#import "BMultiLevelModel.h"

@implementation BMultiLevelModel

+ (instancetype)nodeWithParentID:(NSString*)parentID name:(NSString*)name childrenID:(NSString*)childrenID level:(NSInteger)level isExpand:(BOOL)bol{
    
    BMultiLevelModel *node = [[BMultiLevelModel alloc] init];
    node.parentID = parentID;
    node.name = name;
    node.childrenID = childrenID;
    node.level = level;
    node.expand  =bol;
    
    return node;
}



@end
