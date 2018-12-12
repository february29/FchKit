//
//  UILabel+autoHeigth.m
//  slwl_hz
//
//  Created by bai on 16/3/6.
//  Copyright © 2016年 bai.xianzhi. All rights reserved.
//

#import "UILabel+autoHeigth.h"

@implementation UILabel (autoHeigth)


-(void)autoFitHeigth{
    self.lineBreakMode = NSLineBreakByCharWrapping;
    self.numberOfLines = 0;
    CGSize newsize = [self sizeThatFits:CGSizeMake(self.frame.size.width, MAXFLOAT)];
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y,self.frame.size.width, newsize.height);
}
@end
