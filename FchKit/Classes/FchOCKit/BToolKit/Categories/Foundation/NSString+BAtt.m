//
//  NSString+BAtt.m
//  Fch_OA
//
//  Created by bai on 2016/12/9.
//  Copyright © 2016年 bai.xianzhi. All rights reserved.
//

#import "NSString+BAtt.h"

@implementation NSString (BAtt)

-(NSMutableAttributedString *)b_attStringWithcolor:( UIColor *)color  font:(UIFont *)font forText:(NSString *)text{
    NSMutableAttributedString *content;
    
    content = [[NSMutableAttributedString alloc] initWithString:self];
    
    
    if (text&&![text isEqualToString:@""]) {
        NSRange range = [self rangeOfString:text];
        if (range.location != NSNotFound) {
            if (font) {
                [content addAttribute:NSFontAttributeName value:font range:range];
            }
            
            if (color) {
                [content addAttribute:NSForegroundColorAttributeName value:color range:range];
            }

        }
        
    }
    return content;

}


-(NSMutableAttributedString *)b_attStringWithLineSpacing:(int)lineSpacing{
    NSMutableAttributedString  *dicAtt = [[NSMutableAttributedString alloc]initWithString:self];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    
    [paragraphStyle setLineSpacing:lineSpacing];//调整行间距
    
    [dicAtt addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [self length])];
    
    
    return  dicAtt;
}
@end
