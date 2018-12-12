//
//  BPageTableViewVM.m
//  Lou_s
//
//  Created by bai on 2017/10/11.
//  Copyright © 2017年 北京仙指信息技术有限公司. All rights reserved.
//

#import "BPageTableViewVM.h"

@implementation BPageTableViewVM


- (instancetype)init
{
    self = [super init];
    if (self) {
        _pageNow = 1;
        _pageSize = 20;
    }
    return self;
}
@end
