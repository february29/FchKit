//
//  DeviceTool.h
//  slwl_hz
//
//  Created by bai on 16/4/1.
//  Copyright © 2016年 bai.xianzhi. All rights reserved.
//

#import <Foundation/Foundation.h>

#define BScreen_Width  ([UIScreen mainScreen].bounds.size.width)

#define BScreen_Height ([UIScreen mainScreen].bounds.size.height)
#define BSystemVersion [[[UIDevice currentDevice] systemVersion] floatValue]

@interface DeviceTool : NSObject

@end
