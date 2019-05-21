//
//  Inserts3TextField.m
//  Rail_hrb
//
//  Created by bai on 15/10/22.
//  Copyright © 2015年 bai.xianzhi. All rights reserved.
//

#import "InsertsSpaceTextField.h"

static float leftSpaceValue = 7;


@implementation InsertsSpaceTextField
//控制 placeHolder 的位置，左右缩 20
- (CGRect)textRectForBounds:(CGRect)bounds {
     return CGRectInset( bounds , leftSpaceValue, 0 );
}

// 控制文本的位置，左右缩 20
- (CGRect)editingRectForBounds:(CGRect)bounds {
    return CGRectInset( bounds , leftSpaceValue , 0 );
}


-(void)setPlaceholderColor:(UIColor *)placeholderColor{
    _placeholderColor = placeholderColor;
    [self setValue:placeholderColor forKeyPath:@"_placeholderLabel.textColor"];
}


-(void)deleteBackward{
    [super deleteBackward];
    if (self.keybordBackBlock) {
        self.keybordBackBlock(self);
    }
}


@end
