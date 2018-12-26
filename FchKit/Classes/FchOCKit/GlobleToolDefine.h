//
//  GlobleToolDefine.h
//  BviewsDemo
//
//  Created by bai on 16/5/24.
//  Copyright © 2016年 bai.xianzhi. All rights reserved.
//

#ifndef GlobleToolDefine_h
#define GlobleToolDefine_h

/*! weakSelf */
//#define BWEAKSELF typeof(self) __weak weakSelf = self
#define BWeakSelf(type)  __weak typeof(type) weak##type = type;

//block 执行
#define EXE_BLOCK(block, ...) if (block){block(__VA_ARGS__);}

//log打印宏定义
#ifdef DEBUG
#define LOG(...) NSLog(__VA_ARGS__);
#define LOG_METHOD NSLog(@"%s", __func__);
#else
#define LOG(...);
#define LOG_METHOD;
#endif

//颜色
#define RANDOM_COLOR [UIColor colorWithRed:arc4random_uniform(256) / 255.0 green:arc4random_uniform(256) / 255.0 blue:arc4random_uniform(256) / 255.0 alpha:1]
#define RGBA_COLOR(R, G, B, A) [UIColor colorWithRed:((R) / 255.0f) green:((G) / 255.0f) blue:((B) / 255.0f) alpha:A]
#define RGB_COLOR(R, G, B) [UIColor colorWithRed:((R) / 255.0f) green:((G) / 255.0f) blue:((B) / 255.0f) alpha:1.0f]

//耗时计算
#define TICK   CFAbsoluteTime start = CFAbsoluteTimeGetCurrent();
#define TOCK   NSLog(@"Time: %f", CFAbsoluteTimeGetCurrent() - start)

//Alert提示宏定义
#define Alert(_S_) [[[UIAlertView alloc] initWithTitle:@"提示" message:(_S_) delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil] show]

//
#define WS(weakSelf)        __weak __typeof(&*self)weakSelf = self

//子类实现判定
#define BMethodNotImplemented() \
@throw [NSException exceptionWithName:NSInternalInconsistencyException \
reason:[NSString stringWithFormat:@"You must override %@ in a subclass.", NSStringFromSelector(_cmd)] \
userInfo:nil]


//忽略内存泄漏编译警告
#define SuppressPerformSelectorLeakWarning(Stuff) \
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
Stuff; \
_Pragma("clang diagnostic pop") \
} while (0)

//判断是真机还是模拟器
#if TARGET_OS_IPHONE
//iPhone Device
#endif

#if TARGET_IPHONE_SIMULATOR
//iPhone Simulator
#endif
//ios10 判断系统版本
#define SYSTEM_VERSION_GRATERTHAN_OR_EQUALTO(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)

#endif /* GlobleToolDefine_h */
