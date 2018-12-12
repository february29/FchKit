//
//  UIColor+Hex.h
//  contact
//
//  Created by Yaocui on 15/6/11.
//  Copyright (c) 2015年 Yaocui. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIColor (Hex)

+ (UIColor *)colorWithHexString:(NSString *)color;

//从十六进制字符串获取颜色，
//color:支持@“#123456”、 @“0X123456”、 @“123456”三种格式
+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;

@end
