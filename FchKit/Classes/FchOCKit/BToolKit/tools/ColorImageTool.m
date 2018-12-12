//
//  ColorTool.m
//  slwl_hz
//
//  Created by bai on 16/4/1.
//  Copyright © 2016年 bai.xianzhi. All rights reserved.
//

#import "ColorImageTool.h"

@implementation ColorImageTool

// 使用UIColor创建UIImage
+ (UIImage *)createImageWithColor: (UIColor *)color;{
    CGRect rect=CGRectMake(0.0f, 0.0f,1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;

}


+ (UIImage *) createImageWithColor: (UIColor *)color size:(CGSize )size{
    
    CGRect rect=CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;

}

@end
