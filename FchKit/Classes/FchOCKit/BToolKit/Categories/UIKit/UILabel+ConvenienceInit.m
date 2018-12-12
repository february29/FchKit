//
//  UILabel+ConvenienceInit.m
//  SJTZ
//
//  Created by 李鸿飞 on 2018/6/7.
//  Copyright © 2018年 北京仙指信息技术有限公司. All rights reserved.
//

#import "UILabel+ConvenienceInit.h"
#import "BaseDefine.h"
@implementation UILabel (ConvenienceInit)

+ (UILabel *)labelWithTextColor:(UIColor *)color
                      font:(CGFloat)font
                    isBold:(BOOL)isBold{
    UILabel *label = [UILabel new];
    label.textColor = color;
    if (isBold) {
        label.font = [UIFont boldSystemFontOfSize:font];
    }else{
        label.font = [UIFont systemFontOfSize:font];
    }
    return label;
}


+ (UILabel *)initWithText:(NSString *)text
                    Color:(UIColor *)color
                     font:(CGFloat)font
                   isBold:(BOOL)bold
                alignment:(NSTextAlignment)alignment{
    
    UILabel *label = [UILabel new];
    if (text) {
        label.text = text;
    }
    if (color) {
        label.textColor = color;
    }
    if (font) {
       label.font = FONT(font);
    }
    if (bold) {
        label.font = BOLDFONT(font);
    }
    if (alignment) {
        label.textAlignment = alignment;
    }
    return label;
}

@end
