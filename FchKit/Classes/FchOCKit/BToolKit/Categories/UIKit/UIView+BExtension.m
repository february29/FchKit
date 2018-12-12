//
//  UIView+BExtension.m
//  BviewsDemo
//
//  Created by bai on 16/5/24.
//  Copyright © 2016年 bai.xianzhi. All rights reserved.
//

#import "UIView+BExtension.h"

@implementation UIView (BExtension)
- (void)setB_x:(CGFloat)b_x
{
    CGRect frame = self.frame;
    frame.origin.x = b_x;
    self.frame = frame;
}

- (CGFloat)b_x
{
    return self.frame.origin.x;
}

- (void)setB_y:(CGFloat)b_y
{
    CGRect frame = self.frame;
    frame.origin.y = b_y;
    self.frame = frame;
}

- (CGFloat)b_y
{
    return self.frame.origin.y;
}

- (void)setB_w:(CGFloat)b_w
{
    CGRect frame = self.frame;
    frame.size.width = b_w;
    self.frame = frame;
}

- (CGFloat)b_w
{
    return self.frame.size.width;
}

- (void)setB_h:(CGFloat)b_h
{
    CGRect frame = self.frame;
    frame.size.height = b_h;
    self.frame = frame;
}

- (CGFloat)b_h
{
    return self.frame.size.height;
}

- (void)setB_size:(CGSize)b_size
{
    CGRect frame = self.frame;
    frame.size = b_size;
    self.frame = frame;
}

- (CGSize)b_size
{
    return self.frame.size;
}

- (void)setB_origin:(CGPoint)b_origin
{
    CGRect frame = self.frame;
    frame.origin = b_origin;
    self.frame = frame;
}

- (CGPoint)b_origin
{
    return self.frame.origin;
}

@end
