//
//  Inserts3TextField.h
//  Rail_hrb
//
//  Created by bai on 15/10/22.
//  Copyright © 2015年 bai.xianzhi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InsertsSpaceTextField : UITextField

@property (nonatomic,copy) void(^keybordBackBlock)(UITextField *textField);

@property(nonatomic,retain,readwrite)UIColor *placeholderColor;

@end
