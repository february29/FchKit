//
//  BaseTableView.m
//  Bchart
//
//  Created by bai on 16/6/8.
//  Copyright © 2016年 bai.xianzhi. All rights reserved.
//

#import "BaseTableView.h"

@implementation BaseTableView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor clearColor]];
//        [self setBackgroundView:nil];
//        self.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
//        self.allowsSelection=YES;
//        self.showsHorizontalScrollIndicator = NO;
//        self.showsVerticalScrollIndicator = NO;

    }
    return self;
}

@end
