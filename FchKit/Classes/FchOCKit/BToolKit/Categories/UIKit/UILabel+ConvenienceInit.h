//
//  UILabel+ConvenienceInit.h
//  SJTZ
//
//  Created by 李鸿飞 on 2018/6/7.
//  Copyright © 2018年 北京仙指信息技术有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (ConvenienceInit)

+ (UILabel *)labelWithTextColor:(UIColor *)color
                      font:(CGFloat)font
                    isBold:(BOOL)bold;

+ (UILabel *)initWithText:(NSString *)text
                    Color:(UIColor *)color
                    font:(CGFloat)font
                    isBold:(BOOL)bold
                    alignment:(NSTextAlignment)alignment;

@end
