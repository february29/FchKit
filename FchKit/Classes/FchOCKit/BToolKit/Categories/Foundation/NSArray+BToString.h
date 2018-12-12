//
//  NSArray+BToString.h
//  Fch_OA
//
//  Created by bai on 16/9/13.
//  Copyright © 2016年 bai.xianzhi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (BToString)
-(NSString *)bToString;
-(NSString *)bToStringWithBlock:(NSString *(^)(id obj)) configBlock;

-(NSString *)bToString2WithBlock:(NSString *(^)(id obj,NSInteger indext)) configBlock;

-(NSString *)bToString3WithSeparater:(NSString *)separater confitBlock:(NSString *(^)(id obj,NSInteger indext)) configBlock;

@end
