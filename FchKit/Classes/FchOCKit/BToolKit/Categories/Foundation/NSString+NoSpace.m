//
//  NSString+NoSpace.m
//  Bchart
//
//  Created by bai on 16/7/12.
//  Copyright © 2016年 bai.xianzhi. All rights reserved.
//

#import "NSString+NoSpace.h"

@implementation NSString (NoSpace)
-(NSString *)noSpaceString{
    return [self stringByReplacingOccurrencesOfString:@" " withString:@""];
}
-(NSString *)noSpaceBothEndsString{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}


@end
