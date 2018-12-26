//
//  SDBrowserImageView.h
//  SDPhotoBrowser
//
//  Created by aier on 15-2-6.
//  Copyright (c) 2015年 GSD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDWaitingView.h"


@interface SDBrowserImageView : UIView


@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic,strong) UIImage *image;
@property (nonatomic,strong) SDWaitingView *waitingView;
@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UITapGestureRecognizer *singleTap;
@property (nonatomic, copy)   void (^singleTapCallBack)(UIView *sender);



@property (nonatomic, assign) CGFloat progress;
@property (nonatomic, assign, readonly) BOOL isScaled;
@property (nonatomic, assign) BOOL hasLoadedImage;

- (void)eliminateScale; // 清除缩放

- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder;

//- (void)doubleTapToZommWithScale:(CGFloat)scale;

//- (void)zoomWithScale:(CGFloat)scale;

- (void)clear;

@end
