//
//  UILabel+BAppend.m
//  Fch_OA
//
//  Created by bai on 2016/10/21.
//  Copyright © 2016年 bai.xianzhi. All rights reserved.
//

#import "UILabel+BAppend.h"
#import "UILabel+BAtt.h"

@implementation UILabel (BAppend)

-(void)B_appendText:(NSString *)appendText{
    self.text = [NSString stringWithFormat:@"%@%@",self.text,appendText];
}

-(void)B_appendText:(NSString *)appendText textFont:(UIFont *)font{
    self.text = [NSString stringWithFormat:@"%@%@",self.text,appendText];
    [self setFont:font forText:appendText];
}

-(void)B_appendText:(NSString *)appendText textFont:(UIFont *)font color:(UIColor *)color{
    self.text = [NSString stringWithFormat:@"%@%@",self.text,appendText];
    [self setFont:font color:color forText:appendText];
}
@end
