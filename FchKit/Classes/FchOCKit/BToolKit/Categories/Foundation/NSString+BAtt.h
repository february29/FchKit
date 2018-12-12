//
//  NSString+BAtt.h
//  Fch_OA
//
//  Created by bai on 2016/12/9.
//  Copyright © 2016年 bai.xianzhi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSString (BAtt)
-(NSMutableAttributedString *)b_attStringWithcolor:( UIColor *)color  font:(UIFont *)font forText:(NSString *)text;
-(NSMutableAttributedString *)b_attStringWithLineSpacing:(int)lineSpacing;

@end
