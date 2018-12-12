//
//  BaseTableViewCell.m
//  Bchart
//
//  Created by bai on 16/6/8.
//  Copyright © 2016年 bai.xianzhi. All rights reserved.
//

#import "BaseTableViewCell.h"

@implementation BaseTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    return self;
}

@end
