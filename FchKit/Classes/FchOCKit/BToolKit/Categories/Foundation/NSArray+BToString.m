//
//  NSArray+BToString.m
//  Fch_OA
//
//  Created by bai on 16/9/13.
//  Copyright © 2016年 bai.xianzhi. All rights reserved.
//

#import "NSArray+BToString.h"

@implementation NSArray (BToString)


-(NSString *)bToString{
    return [self bToStringWithBlock:nil];
    
}

-(NSString *)bToStringWithBlock:(NSString *(^)(id obj)) configBlock
{
    NSMutableString *str = [[NSMutableString alloc]initWithString:@""];
    [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx==0) {
            
            configBlock?[str appendString:configBlock(obj)]:[str appendString:obj];
            
        }else{
            [str appendString:@","];
            configBlock?[str appendString:configBlock(obj)]:[str appendString:obj];
        }
    }];

    return str;
}

-(NSString *)bToString2WithBlock:(NSString *(^)(id obj,NSInteger indext)) configBlock{
    NSMutableString *str = [[NSMutableString alloc]initWithString:@""];
    [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx==0) {
            
            configBlock?[str appendString:configBlock(obj,idx)]:[str appendString:obj];
            
        }else{
            [str appendString:@","];
            configBlock?[str appendString:configBlock(obj,idx)]:[str appendString:obj];
        }
    }];
    
    return str;

}

-(NSString *)bToString3WithSeparater:(NSString *)separater confitBlock:(NSString *(^)(id obj,NSInteger indext)) configBlock{
    
    NSMutableString *str = [[NSMutableString alloc]initWithString:@""];
    [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx==0) {
            
            configBlock?[str appendString:configBlock(obj,idx)]:[str appendString:obj];
            
        }else{
            [str appendString:separater];
            configBlock?[str appendString:configBlock(obj,idx)]:[str appendString:obj];
        }
    }];
    
    return str;
}
@end
