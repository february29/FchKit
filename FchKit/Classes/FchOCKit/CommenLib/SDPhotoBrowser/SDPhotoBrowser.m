//
//  SDPhotoBrowser.m
//  photobrowser
//
//  Created by aier on 15-2-3.
//  Copyright (c) 2015年 aier. All rights reserved.
//

#import "SDPhotoBrowser.h"
#import "UIImageView+WebCache.h"
#import "SDBrowserImageView.h"
//  隐藏时有缩放先还原 缩小功能待完善不能小于1？
 
//  ============在这里方便配置样式相关设置===========

//                      ||
//                      ||
//                      ||
//                     \\//
//                      \/

#import "SDPhotoBrowserConfig.h"

//  =============================================

@implementation SDPhotoBrowser 
{
    UIScrollView *_scrollView;
    BOOL _hasShowedFistView;
    UILabel *_indexLabel;
    UIButton *_saveButton;
    UIActivityIndicatorView *_indicatorView;
    BOOL _willDisappear;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    
        self.backgroundColor = SDPhotoBrowserBackgrounColor;
//        self.backgroundColor = [UIColor clearColor];
            [self setupScrollView];
            [self setupToolbars];
    }
    return self;
}




-(void)setImageCount:(NSInteger)imageCount{
    _imageCount = imageCount;
    __weak typeof(self) wkself = self;
    for (int i = 0; i < self.imageCount; i++) {
        SDBrowserImageView *imageView = [[SDBrowserImageView alloc] init];
        imageView.tag = i;
        
        // 单击图片
        imageView.singleTapCallBack = ^(UIView *sender) {
            [wkself photoClick:sender];
        };
        
//        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(photoClick:)];
        
        // 双击放大图片
//        UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewDoubleTaped:)];
//        doubleTap.numberOfTapsRequired = 2;
        
//        [singleTap requireGestureRecognizerToFail:doubleTap];
        
//        [imageView addGestureRecognizer:singleTap];
//        [imageView addGestureRecognizer:doubleTap];
        [_scrollView addSubview:imageView];
    }
    
    if (self.imageCount > 1) {
        _indexLabel.hidden = NO;
        _indexLabel.text = [NSString stringWithFormat:@"1/%ld", (long)self.imageCount];
    }
    
    
}



- (void)dealloc
{
    [[UIApplication sharedApplication].keyWindow removeObserver:self forKeyPath:@"frame"];
}

- (void)setupToolbars
{
    // 1. 序标
    UILabel *indexLabel = [[UILabel alloc] init];
    indexLabel.bounds = CGRectMake(0, 0, 80, 30);
    indexLabel.textAlignment = NSTextAlignmentCenter;
    indexLabel.textColor = [UIColor whiteColor];
    indexLabel.font = [UIFont boldSystemFontOfSize:20];
    indexLabel.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    indexLabel.layer.cornerRadius = indexLabel.bounds.size.height * 0.5;
    indexLabel.clipsToBounds = YES;
    indexLabel.hidden = YES;
    
    _indexLabel = indexLabel;
    [self addSubview:indexLabel];
    
//    // 2.保存按钮
//    UIButton *saveButton = [[UIButton alloc] init];
//    [saveButton setTitle:@"保存" forState:UIControlStateNormal];
//    [saveButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    saveButton.backgroundColor = [UIColor colorWithRed:0.1f green:0.1f blue:0.1f alpha:0.90f];
//    saveButton.layer.cornerRadius = 5;
//    saveButton.clipsToBounds = YES;
//    [saveButton addTarget:self action:@selector(saveImage) forControlEvents:UIControlEventTouchUpInside];
//    _saveButton = saveButton;
//    [self addSubview:saveButton];
}

- (void)saveImage
{
    int index = _scrollView.contentOffset.x / _scrollView.bounds.size.width;
    UIImageView *currentImageView = _scrollView.subviews[index];
    
    UIImageWriteToSavedPhotosAlbum(currentImageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
    
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] init];
    indicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
    indicator.center = self.center;
    _indicatorView = indicator;
    [[UIApplication sharedApplication].keyWindow addSubview:indicator];
    [indicator startAnimating];
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo;
{
    [_indicatorView removeFromSuperview];
    
    UILabel *label = [[UILabel alloc] init];
    label.textColor = [UIColor whiteColor];
    label.backgroundColor = [UIColor colorWithRed:0.1f green:0.1f blue:0.1f alpha:0.90f];
    label.layer.cornerRadius = 5;
    label.clipsToBounds = YES;
    label.bounds = CGRectMake(0, 0, 150, 30);
    label.center = self.center;
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont boldSystemFontOfSize:17];
    [[UIApplication sharedApplication].keyWindow addSubview:label];
    [[UIApplication sharedApplication].keyWindow bringSubviewToFront:label];
    if (error) {
        label.text = SDPhotoBrowserSaveImageFailText;
    }   else {
        label.text = SDPhotoBrowserSaveImageSuccessText;
    }
    [label performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:1.0];
}

- (void)setupScrollView
{
    _scrollView = [[UIScrollView alloc] init];
    _scrollView.delegate = self;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.pagingEnabled = YES;
    [self addSubview:_scrollView];
    
//    for (int i = 0; i < self.imageCount; i++) {
//        SDBrowserImageView *imageView = [[SDBrowserImageView alloc] init];
//        imageView.tag = i;
//
//        // 单击图片
//        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(photoClick:)];
//
//        // 双击放大图片
//        UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewDoubleTaped:)];
//        doubleTap.numberOfTapsRequired = 2;
//
//        [singleTap requireGestureRecognizerToFail:doubleTap];
//
//        [imageView addGestureRecognizer:singleTap];
//        [imageView addGestureRecognizer:doubleTap];
//        [_scrollView addSubview:imageView];
//    }
//
//    [self setupImageOfImageViewForIndex:self.currentImageIndex];
    
}

// 加载图片
- (void)setupImageOfImageViewForIndex:(NSInteger)index
{
    SDBrowserImageView *imageView = _scrollView.subviews[index];
    self.currentImageIndex = index;
    if (imageView.hasLoadedImage) return;
    if ([self highQualityImageURLForIndex:index]) {
        [imageView setImageWithURL:[self highQualityImageURLForIndex:index] placeholderImage:[self placeholderImageForIndex:index]];
    } else {
        imageView.image = [self placeholderImageForIndex:index];
    }
    imageView.hasLoadedImage = YES;
}

- (void)photoClick:(id )sender
{
    
    SDBrowserImageView *currentImageView = (SDBrowserImageView *)sender;
//    NSInteger currentIndex = currentImageView.tag;
    
   
    
    currentImageView.hidden = YES;
    _willDisappear = YES;
    
    
    CGRect tempRect = CGRectNull;
    
    if (!CGRectIsEmpty(self.tempRect)) {
        //有强制rect
        tempRect = self.tempRect;
        
    }else{
        //无强制rect
        if (self.sourceImagesContainerView)  {
            //有包含image的父view  且只包含image
            UIView *sourceView ;
            if (self.currentImageIndex<self.sourceImagesContainerView.subviews.count) {
                //找到sourceView
                sourceView =  self.sourceImagesContainerView.subviews[self.currentImageIndex];
                tempRect = [self.sourceImagesContainerView convertRect:sourceView.frame toView:self]; //找到点击数据的具体位置
            }else{
                //找不到
            }
            
            
        }else{
            //无包含image的父view
        }
    }
    
    
    if (!CGRectIsEmpty(tempRect)) {
        //有强制的或者能找到tempRect
        UIImageView *tempView = [[UIImageView alloc] init];
        tempView.layer.masksToBounds = true;
        if (self.tempContentMode) {
            //有强制的 contentModel
            tempView.contentMode = self.tempContentMode;
        }else{
            //无强制的contentModel
            if (self.sourceImagesContainerView && self.currentImageIndex<self.sourceImagesContainerView.subviews.count) {
                //能找到contentModel
                tempView.contentMode =  self.sourceImagesContainerView.subviews[self.currentImageIndex].contentMode;
            }else{
                //能找不到contentModel
            }
        }
        
        
       
        
        
//        SDBrowserImageView *targetView = _scrollView.subviews[self.currentImageIndex];
        SDBrowserImageView *targetView = currentImageView;
        CGRect targetRect = targetView.frame;
        
        
        if (!targetView.image) { // 防止 因imageview的image加载失败 导致 崩溃
            targetRect = CGRectMake(0, 0, self.bounds.size.width, (self.bounds.size.width / targetView.image.size.width) * self.bounds.size.height);
        }else{
            
//            if (targetView.isScaled) {
//                // 抖动bug  需要完善
//                targetRect = CGRectMake(0, 0, self.bounds.size.width, (self.bounds.size.width / targetView.image.size.width) * targetView.image.size.height);
//            }else{
//                targetRect = CGRectMake(0, 0, self.bounds.size.width, (self.bounds.size.width / targetView.image.size.width) * targetView.image.size.height);
//            }
            
            targetRect = targetView.containerView.frame;
            
        }
        
        
        
        tempView.image = [self placeholderImageForIndex:self.currentImageIndex];
        tempView.frame = targetRect;
        tempView.center = self.center;
        [self addSubview:tempView];
       
        targetView.hidden = true;
        
        

        
        [UIView animateWithDuration:SDPhotoBrowserHideImageAnimationDuration delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            tempView.frame = tempRect;
            self.backgroundColor = [UIColor clearColor];
            _indexLabel.alpha = 0.1;
            
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
            
        }];
        
        
        
    }else{
        //无强制的或者能找不到tempRect  直接找到view显示
        [UIView animateWithDuration:SDPhotoBrowserHideImageAnimationDuration animations:^{
            
            self.backgroundColor = [UIColor clearColor];
            _indexLabel.alpha = 0.1;
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
        
    }
    
    
    
   
    
}



//- (void)imageViewDoubleTaped:(UITapGestureRecognizer *)recognizer
//{
//    SDBrowserImageView *imageView = (SDBrowserImageView *)recognizer.view;
//    CGFloat scale;
//    if (imageView.isScaled) {
//        scale = 1.0;
//    } else {
//        scale = 2.0;
//    }
//
//    [imageView doubleTapToZommWithScale:scale];
//}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGRect rect = self.bounds;
    rect.size.width += SDPhotoBrowserImageViewMargin * 2;
    
    _scrollView.bounds = rect;
    _scrollView.center = self.center;
    
    CGFloat y = 0;
    CGFloat w = _scrollView.frame.size.width - SDPhotoBrowserImageViewMargin * 2;
    CGFloat h = _scrollView.frame.size.height;
    
    
    
    [_scrollView.subviews enumerateObjectsUsingBlock:^(SDBrowserImageView *obj, NSUInteger idx, BOOL *stop) {
        CGFloat x = SDPhotoBrowserImageViewMargin + idx * (SDPhotoBrowserImageViewMargin * 2 + w);
        obj.frame = CGRectMake(x, y, w, h);
    }];
    
    _scrollView.contentSize = CGSizeMake(_scrollView.subviews.count * _scrollView.frame.size.width, 0);
    _scrollView.contentOffset = CGPointMake(self.currentImageIndex * _scrollView.frame.size.width, 0);
    
    
   
    
    _indexLabel.center = CGPointMake(self.bounds.size.width * 0.5, 45);
    _saveButton.frame = CGRectMake(30, self.bounds.size.height - 70, 50, 25);
    
    if (!_hasShowedFistView) {
        [self setupImageOfImageViewForIndex:self.currentImageIndex];
        [self showFirstImage];
    }
}

- (void)show
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    self.frame = window.bounds;
    [window addObserver:self forKeyPath:@"frame" options:0 context:nil];
    [window addSubview:self];
    
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(UIView *)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"frame"]) {
        self.frame = object.bounds;
        SDBrowserImageView *currentImageView = _scrollView.subviews[_currentImageIndex];
        if ([currentImageView isKindOfClass:[SDBrowserImageView class]]) {
            [currentImageView clear];
        }
    }
}




- (void)showFirstImage
{
    
    CGRect tempRect = CGRectNull;
    
    if (!CGRectIsEmpty(self.tempRect)) {
        //有强制rect
        tempRect = self.tempRect;
        
    }else{
        //无强制rect
        if (self.sourceImagesContainerView)  {
            //有包含image的父view  且只包含image
            UIView *sourceView ;
            if (self.currentImageIndex<self.sourceImagesContainerView.subviews.count) {
                //找到sourceView
                sourceView =  self.sourceImagesContainerView.subviews[self.currentImageIndex];
                tempRect = [self.sourceImagesContainerView convertRect:sourceView.frame toView:self]; //找到点击数据的具体位置
            }else{
                //找不到
            }
            
            
        }else{
            //无包含image的父view
        }
    }
    
    
    if (!CGRectIsEmpty(tempRect)) {
        //有强制的或者能找到tempRect
        UIImageView *tempView = [[UIImageView alloc] init];
        tempView.layer.masksToBounds = true;
        if (self.tempContentMode) {
            //有强制的 contentModel
            tempView.contentMode = self.tempContentMode;
        }else{
            //无强制的contentModel
            if (self.sourceImagesContainerView && self.currentImageIndex<self.sourceImagesContainerView.subviews.count) {
                //能找到contentModel
                tempView.contentMode =  self.sourceImagesContainerView.subviews[self.currentImageIndex].contentMode;
            }else{
                //能找不到contentModel
            }
        }
       
        tempView.frame = tempRect;
        tempView.image = [self placeholderImageForIndex:self.currentImageIndex];
        [self addSubview:tempView];
        
        
        SDBrowserImageView *targetView = _scrollView.subviews[self.currentImageIndex];
        
        CGRect targetRect = targetView.frame;
       
        
        if (!targetView.image) { // 防止 因imageview的image加载失败 导致 崩溃
             targetRect = CGRectMake(0, 0, self.bounds.size.width, (self.bounds.size.width / targetView.image.size.width) * self.bounds.size.height);
        }else{

            targetRect = CGRectMake(0, 0, self.bounds.size.width, (self.bounds.size.width / targetView.image.size.width) * targetView.image.size.height);
        }
        
        
        
    
        targetView.hidden = true;
        [UIView animateWithDuration:SDPhotoBrowserShowImageAnimationDuration animations:^{
            tempView.center = self.center;
            tempView.bounds = (CGRect){CGPointZero, targetRect.size};
//            self.backgroundColor = SDPhotoBrowserBackgrounColor;
        } completion:^(BOOL finished) {
            targetView.hidden = NO;
            _hasShowedFistView = YES;
            [tempView removeFromSuperview];

        }];

        
        
    }else{
        //无强制的或者能找不到tempRect  直接找到view显示
        UIImageView *imageView = _scrollView.subviews[self.currentImageIndex];
        CGRect rect = imageView.bounds;
        
        imageView.alpha = 0;
        imageView.bounds = CGRectZero;
        [UIView animateWithDuration:SDPhotoBrowserShowImageAnimationDuration animations:^{
            imageView.alpha = 1;
            imageView.bounds = rect;
//            self.backgroundColor = SDPhotoBrowserBackgrounColor;
        } completion:^(BOOL finished) {
            _hasShowedFistView = YES;
        }];
    }
    
    
}

- (UIImage *)placeholderImageForIndex:(NSInteger)index
{
    if ([self.delegate respondsToSelector:@selector(photoBrowser:placeholderImageForIndex:)]) {
        return [self.delegate photoBrowser:self placeholderImageForIndex:index];
    }else if(self.placeholderImageBlockForIndex){
        return self.placeholderImageBlockForIndex(self,index);
    }
    return nil;
}

- (NSURL *)highQualityImageURLForIndex:(NSInteger)index
{
    if ([self.delegate respondsToSelector:@selector(photoBrowser:highQualityImageURLForIndex:)]) {
        return [self.delegate photoBrowser:self highQualityImageURLForIndex:index];
    }else if (self.highQualityImageURLBlockForIndex){
        return self.highQualityImageURLBlockForIndex(self,index);
    }
    return nil;
}

#pragma mark - scrollview代理方法

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int index = (scrollView.contentOffset.x + _scrollView.bounds.size.width * 0.5) / _scrollView.bounds.size.width;
    
    // 有过缩放的图片在拖动一定距离后清除缩放
    CGFloat margin = 150;
    CGFloat x = scrollView.contentOffset.x;
    if ((x - index * self.bounds.size.width) > margin || (x - index * self.bounds.size.width) < - margin) {
        SDBrowserImageView *imageView = _scrollView.subviews[index];
        if (imageView.isScaled) {
            [UIView animateWithDuration:0.5 animations:^{
                imageView.transform = CGAffineTransformIdentity;
            } completion:^(BOOL finished) {
                [imageView eliminateScale];
            }];
        }
    }
    
    
    if (!_willDisappear) {
        _indexLabel.text = [NSString stringWithFormat:@"%d/%ld", index + 1, (long)self.imageCount];
    }
    [self setupImageOfImageViewForIndex:index];
}



@end
