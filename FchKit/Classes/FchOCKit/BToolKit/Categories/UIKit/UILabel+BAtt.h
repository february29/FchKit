//
//  UILabel+BAtt.h
//  Fch_Location
//
//  Created by bai on 16/6/23.
//  Copyright © 2016年 bai.xianzhi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (BAtt)
-(void)setColor:(UIColor *)color forText:(NSString *)text;
-(void)setFont:(UIFont *)font forText:(NSString *)text;
-(void)setFont:(UIFont *)font color:(UIColor *)color forText:(NSString *)text;
-(void)setFont:(UIFont *)font color:(UIColor *)color delLine:(BOOL)hasDelLine forText:(NSString *)text;


-(void)setFont:(UIFont *)font forRange:(NSRange)range;
-(void)setColor:(UIColor *)color forRange:(NSRange)range;
-(void)setFont:(UIFont *)font color:(UIColor *)color forRange:(NSRange)range;

- (void)setLineSpacing:(int)lineSpacing;
@end
