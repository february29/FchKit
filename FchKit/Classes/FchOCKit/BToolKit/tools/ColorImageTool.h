//
//  ColorTool.h
//  slwl_hz
//
//  Created by bai on 16/4/1.
//  Copyright © 2016年 bai.xianzhi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ColorImageTool : NSObject


/*
 *  使用UIColor创建UIImage
 */
+ (UIImage *) createImageWithColor: (UIColor *)color;


+ (UIImage *) createImageWithColor: (UIColor *)color size:(CGSize )size;
@end
