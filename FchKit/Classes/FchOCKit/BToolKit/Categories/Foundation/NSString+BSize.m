//
//  NSString+BSize.m
//  Bchart
//
//  Created by bai on 16/6/14.
//  Copyright © 2016年 bai.xianzhi. All rights reserved.
//

#import "NSString+BSize.h"

@implementation NSString (BSize)
///字符串宽
-(CGFloat)widthWithFontSize:(CGFloat)fontSize height:(CGFloat)height{
    NSDictionary *attrs = @{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]};
    return  [self boundingRectWithSize:CGSizeMake(MAXFLOAT, height) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attrs context:nil].size.width;

}
///字符串高
-(CGFloat)heightWithFontSize:(CGFloat)fontSize width:(CGFloat)width{
    NSDictionary *attrs = @{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]};
    return  [self boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attrs context:nil].size.height;
}
@end
