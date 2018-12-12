//
//  UIButton+BG.m
//  Bchart
//
//  Created by bai on 16/6/12.
//  Copyright © 2016年 bai.xianzhi. All rights reserved.
//

#import "UIButton+BG.h"
#import "UIImage+size.h"

@implementation UIButton (BG)
-(void)setN_BG:(NSString *)nbg H_BG:(NSString *)hbg{
    [self setBackgroundImage:[UIImage imageNamed:nbg] forState:UIControlStateNormal];
    [self setBackgroundImage:[UIImage imageNamed:hbg] forState:UIControlStateHighlighted];
}


-(void)setResizeN_BG:(NSString *)nbg H_BG:(NSString *)hbg{
    [self setBackgroundImage:[UIImage stretchedImageWithName:nbg] forState:UIControlStateNormal];
    [self setBackgroundImage:[UIImage stretchedImageWithName:hbg] forState:UIControlStateHighlighted];
}

@end
