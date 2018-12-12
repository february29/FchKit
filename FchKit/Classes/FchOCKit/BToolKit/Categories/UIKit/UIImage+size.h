//
//  UIImage+size.h
//  slwl_hz
//
//  Created by bai on 16/3/10.
//  Copyright © 2016年 bai.xianzhi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (size)


+ (UIImage *)imageSizeWithScreenImage:(UIImage *)image;

+(UIImage*) imageNamed:(NSString*)imageName scaleToSize:(CGSize)size;
/**
 *返回中心拉伸的图片
 */
+(UIImage *)stretchedImageWithName:(NSString *)name;
@end
