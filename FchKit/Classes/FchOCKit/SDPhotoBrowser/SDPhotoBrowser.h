//
//  SDPhotoBrowser.h
//  photobrowser
//
//  Created by aier on 15-2-3.
//  Copyright (c) 2015年 aier. All rights reserved.
//

#import <UIKit/UIKit.h>




@class SDButton, SDPhotoBrowser;

@protocol SDPhotoBrowserDelegate <NSObject>

@required

- (UIImage *)photoBrowser:(SDPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index;

@optional

- (NSURL *)photoBrowser:(SDPhotoBrowser *)browser highQualityImageURLForIndex:(NSInteger)index;

@end


@interface SDPhotoBrowser : UIView <UIScrollViewDelegate>

/**
 存放图片的容器view 只包换图片。 用于图片显示时的放大缩小
 */
@property (nonatomic, weak) UIView *sourceImagesContainerView;

@property (nonatomic, assign) UIViewContentMode tempContentMode;

@property (nonatomic,assign) CGRect tempRect;


@property (nonatomic, assign) NSInteger currentImageIndex;
@property (nonatomic, assign) NSInteger imageCount;



//代理形式提供数据源 优先级高于block形式
@property (nonatomic, weak) id<SDPhotoBrowserDelegate> delegate;

//block形式提供数据源
@property (nonatomic,copy) UIImage* (^placeholderImageBlockForIndex)(SDPhotoBrowser *browser,NSInteger idx);

@property (nonatomic,copy) NSURL* (^highQualityImageURLBlockForIndex)(SDPhotoBrowser *browser,NSInteger idx);

- (void)show;

@end
