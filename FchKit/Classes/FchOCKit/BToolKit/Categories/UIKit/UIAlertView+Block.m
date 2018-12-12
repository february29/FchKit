//
//  UIAlertView+Block.m
//  contact
//
//  Created by bai on 15/12/2.
//  Copyright © 2015年 Yaocui. All rights reserved.
//

#import "UIAlertView+Block.h"
#import <objc/runtime.h>
static char key;
@implementation UIAlertView (Block)
-(instancetype)initWithTitle:(NSString *)title message:(NSString *)message withActionBlock:(actionBlock)action {
    objc_setAssociatedObject(self, &key, action, OBJC_ASSOCIATION_COPY_NONATOMIC);
    return [self initWithTitle:title message:message delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==alertView.firstOtherButtonIndex){
       actionBlock action =  objc_getAssociatedObject(self, &key);
        if (action) {
            action(alertView);
        }
    }
}
@end
