//
//  UITextField+LeftImage.m
//  Bchart
//
//  Created by bai on 16/6/12.
//  Copyright © 2016年 bai.xianzhi. All rights reserved.
//

#import "UITextField+LeftImage.h"

@implementation UITextField (LeftImage)
-(void)addLeftViewWithImage:(NSString *)image{
    
    
    // 输入框左边图片
    UIImageView *lockIv = [[UIImageView alloc] init];
    
    // 设置尺寸
    CGRect imageBound = self.bounds;
    // 宽度高度一样
    imageBound.size.width = imageBound.size.height;
    lockIv.bounds = imageBound;
    
    // 设置图片
    lockIv.image = [UIImage imageNamed:image];
    
    // 设置图片居中显示
    lockIv.contentMode = UIViewContentModeCenter;
    
    // 添加TextFiled的左边视图
    self.leftView = lockIv;
    
    // 设置TextField左边的总是显示
    self.leftViewMode = UITextFieldViewModeAlways;
}

@end
