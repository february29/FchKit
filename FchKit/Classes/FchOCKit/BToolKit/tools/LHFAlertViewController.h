//
//  LHFAlertViewController.h
//  lianxi
//
//  Created by 李鸿飞 on 2018/5/4.
//  Copyright © 2018年 李鸿飞. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Masonry.h>
@interface LHFAlertViewController : UIViewController

-(void)alertShowWith:(NSString *)string;
//点击按钮后的回调方法
@property (nonatomic,strong) void (^btnAction)();

@property (nonatomic,assign) BOOL showOkAndCancleBtn;
@end
