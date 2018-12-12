//
//  NSDictionary+BRelate.m
//  Fch_OA
//
//  Created by bai on 16/9/5.
//  Copyright © 2016年 bai.xianzhi. All rights reserved.
//

#import "NSDictionary+BRelate.h"
#import <objc/runtime.h>

static char RELATEDOBJ;

@implementation NSDictionary (BRelate)

-(void)setRelatedObj:(id)relatedObj{
    objc_setAssociatedObject(self, &RELATEDOBJ, relatedObj, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(id)relatedObj{
    return   objc_getAssociatedObject(self, &RELATEDOBJ);
}

@end
