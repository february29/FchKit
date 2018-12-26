//
//  BImageAddContentView.h
//  SJTZ
//
//  Created by bai on 2018/1/4.
//  Copyright © 2018年 北京仙指信息技术有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BImageAddContentView : UIView

@property (nonatomic,assign) float marging;
@property (nonatomic,assign) int cloumeCount;

@property (nonatomic,assign) float addBtnW;
@property (nonatomic,strong) UIButton *addBtn;

@property (nonatomic,copy) void(^addBtnClickBlock)(UIButton *btn);

@property (nonatomic,strong,readonly) NSMutableArray <UIImage *>*currentImageArray;

-(void)addImages:(NSArray<UIImage *> *)imageArray;


-(void)removeAllImages;

@property (nonatomic,copy) void (^deleteImageBlock)(NSInteger index);

@end
