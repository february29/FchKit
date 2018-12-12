//
//  UILabel+BAtt.m
//  Fch_Location
//
//  Created by bai on 16/6/23.
//  Copyright © 2016年 bai.xianzhi. All rights reserved.
//

#import "UILabel+BAtt.h"

@implementation UILabel (BAtt)
-(void)setColor:(UIColor *)color forText:(NSString *)text{
    [self setFont:nil color:color forText:text];
}
-(void)setFont:(UIFont *)font forText:(NSString *)text{
    [self setFont:font color:nil forText:text];
}

-(void)setFont:(UIFont *)font color:(UIColor *)color forText:(NSString *)text{
    NSAssert(self.text!=nil,@"You must set the text of the lable" );
    
    NSMutableAttributedString *content;
    if (self.attributedText) {
        content = [self.attributedText mutableCopy];
    }else{
        content = [[NSMutableAttributedString alloc] initWithString:self.text];
    }
    
    if (text&&![text isEqualToString:@""]) {
         NSRange range = [self.text rangeOfString:text];
        if (font) {
            [content addAttribute:NSFontAttributeName value:font range:range];
        }
        
        if (color) {
            [content addAttribute:NSForegroundColorAttributeName value:color range:range];
        }
        self.attributedText = content;
    }
}

-(void)setFont:(UIFont *)font color:(UIColor *)color delLine:(BOOL)hasDelLine forText:(NSString *)text{
    NSAssert(self.text!=nil,@"You must set the text of the lable" );
    
    NSMutableAttributedString *content;
    if (self.attributedText) {
        content = [self.attributedText mutableCopy];
    }else{
        content = [[NSMutableAttributedString alloc] initWithString:self.text];
    }
    
    if (text&&![text isEqualToString:@""]) {
        NSRange range = [self.text rangeOfString:text];
        if (font) {
            [content addAttribute:NSFontAttributeName value:font range:range];
        }
        
        if (color) {
            [content addAttribute:NSForegroundColorAttributeName value:color range:range];
        }
        
        if (hasDelLine) {
            [content addAttribute:NSStrikethroughStyleAttributeName
                             value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle)
                             range:range];
        }
        self.attributedText = content;
    }
}



-(void)setFont:(UIFont *)font forRange:(NSRange)range{
    [self setFont:font color:nil forRange:range];
}
-(void)setColor:(UIColor *)color forRange:(NSRange)range{
    [self setFont:nil color:color forRange:range];
}
-(void)setFont:(UIFont *)font color:(UIColor *)color forRange:(NSRange)range{
    NSAssert(self.text!=nil,@"You must set the text of the lable" );
    
    NSMutableAttributedString *content;
    if (self.attributedText) {
        content = [self.attributedText mutableCopy];
    }else{
        content = [[NSMutableAttributedString alloc] initWithString:self.text];
    }
    
    
    if (font) {
        [content addAttribute:NSFontAttributeName value:font range:range];
    }
        
    if (color) {
        [content addAttribute:NSForegroundColorAttributeName value:color range:range];
    }
    self.attributedText = content;
    
}

- (void)setLineSpacing:(int)lineSpacing {
   
    NSMutableAttributedString  *dicAtt = [[NSMutableAttributedString alloc]initWithString:self.text];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    
    [paragraphStyle setLineSpacing:lineSpacing];//调整行间距
    
    [dicAtt addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [self.text length])];
    
    
    self.attributedText = dicAtt;

}





@end
