//
//  UIImage+BCircle.h
//  Lou_s
//
//  Created by bai on 2017/6/12.
//  Copyright © 2017年 北京仙指信息技术有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (BCircle)

+(UIImage*) circleImage:(UIImage*) image withParam:(CGFloat) inset;

+(UIImage *)circleImage:(UIImage*) image withBordWith:(CGFloat) borderWidth boredColor:(UIColor *)borderColor;
@end
