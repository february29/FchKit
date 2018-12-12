//
//  NSString+BSize.h
//  Bchart
//
//  Created by bai on 16/6/14.
//  Copyright © 2016年 bai.xianzhi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSString (BSize)
///字符串宽
-(CGFloat)widthWithFontSize:(CGFloat)fontSize height:(CGFloat)height;
///字符串高
-(CGFloat)heightWithFontSize:(CGFloat)fontSize width:(CGFloat)width;


@end
