//
//  UILabel+BImage.m
//  Bchart
//
//  Created by bai on 16/6/17.
//  Copyright © 2016年 bai.xianzhi. All rights reserved.
//

#import "UILabel+BImage.h"

@implementation UILabel (BImage)
-(void)showImage:(UIImage *)image{
    // 把图片在label中显示
    NSTextAttachment *attach = [[NSTextAttachment alloc]init];
    attach.image = image;
    NSAttributedString *attachStr = [NSAttributedString attributedStringWithAttachment:attach];
    
    // 用了这个label的属性赋值方法，就可以忽略那个普通的赋值方法
    self.attributedText = attachStr;
}
@end
