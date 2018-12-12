//
//  UILabel+BAppend.h
//  Fch_OA
//
//  Created by bai on 2016/10/21.
//  Copyright © 2016年 bai.xianzhi. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 为lable添加其他文字的cotegray  本cotegray依赖UILabel+BAtt.h
 */
@interface UILabel (BAppend)

/**
 为lable添加后续文字

 @param appendText 添加的文字
 */
-(void)B_appendText:(NSString *)appendText;

/**
 为lable添加后续文字

 @param appendText 添加的文字
 @param font       添加的文字的字体
 */
-(void)B_appendText:(NSString *)appendText textFont:(UIFont *)font;

/**
 为lable添加后续文字

 @param appendText 添加的文字
 @param font       添加的文字的字体
 @param color      添加的文字的颜色
 */
-(void)B_appendText:(NSString *)appendText textFont:(UIFont *)font color:(UIColor *)color;

@end
