//
//  StringTool.h
//  contact
//
//  Created by bai on 15/12/4.
//  Copyright © 2015年 Yaocui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StringTool : NSObject
+(BOOL)isPhoneNumber:(NSString *)phoneNum;
+(BOOL)isNumber:(NSString *)Num;
+(BOOL)isPureFloat:(NSString *)string;
+(BOOL)isPureInt:(NSString *)string;
///字符串宽
+(CGFloat)widthWithString:(NSString*)string fontSize:(CGFloat)fontSize height:(CGFloat)height;
///字符串高
+(CGFloat)heightWithString:(NSString*)string fontSize:(CGFloat)fontSize width:(CGFloat)width;

///nil [NSNull null] 返回@""  NSString返回原值  数字返回int类型
+(NSString *)stringOfObject:(id)Object;
///字典中int 转string  nil [NSNull null] 返回@""
+(NSString *)stringOfInt:(id)Object;
///字典中int 转float   nil [NSNull null] 返回@""
+(NSString *)stringOfFloat:(id)Object;

///字典中int 转float 保留1位小数   nil [NSNull null] 返回@""
+(NSString *)stringOfFloat2:(id)Object;
///去除前后空格
+(NSString *)trimingWithOutSpaceAndReturn:(NSString *)trimStr;

+(NSAttributedString*)attrStrForPreStr:(NSString *)preStr preColor:(UIColor *)preColor preFont:(UIFont *)preFont behindStr:(NSString*)behindStr behindColor:(UIColor *)behindColor behindFont:(UIFont *)behindFont;
@end
