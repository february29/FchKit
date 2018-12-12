//
//  UIAlertView+Block.h
//  contact
//
//  Created by bai on 15/12/2.
//  Copyright © 2015年 Yaocui. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^actionBlock)(UIAlertView *alert);
//typedef void(^cancleActionBlock)(UIAlertView *alert);

@interface UIAlertView (Block)<UIAlertViewDelegate>
-(instancetype)initWithTitle:(NSString *)title message:(NSString *)message withActionBlock:(actionBlock) action ;
@end
