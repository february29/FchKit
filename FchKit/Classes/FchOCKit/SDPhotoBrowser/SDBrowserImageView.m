//
//  SDBrowserImageView.m
//  SDPhotoBrowser
//
//  Created by aier on 15-2-6.
//  Copyright (c) 2015年 GSD. All rights reserved.
//

#import "SDBrowserImageView.h"
#import "UIImageView+WebCache.h"
#import "SDPhotoBrowserConfig.h"

@interface SDBrowserImageView()<UIScrollViewDelegate>{
//    __weak SDWaitingView *_waitingView;
//    UIScrollView *_zoomingScroolView;
//    UIImageView *_zoomingImageView;
//    CGFloat _totalScale;
}
@end


@implementation SDBrowserImageView



- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        
        
        [self addSubview:self.scrollView];
        [self.scrollView addSubview:self.containerView];
        [self.containerView addSubview:self.imageView];
        [self addSubview:self.waitingView];
        
       
        UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTapAction:)];
        doubleTap.numberOfTapsRequired = 2;
        [self addGestureRecognizer:doubleTap];
        
        _singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapAction)];
        [self addGestureRecognizer:_singleTap];
        [_singleTap requireGestureRecognizerToFail:doubleTap];
        
        
    }
    return self;
}



- (UIImageView *)imageView
{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        //        _imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    }
    return _imageView;
}


-(SDWaitingView *)waitingView{
    if (!_waitingView) {
        _waitingView = [[SDWaitingView alloc] init];
        _waitingView.bounds = CGRectMake(0, 0, 60, 60);
        _waitingView.mode = SDWaitingViewProgressMode;
        _waitingView.hidden = true;
    }
    return _waitingView;
}

-(UIImage *)image{
    return self.imageView.image;
}


- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.frame = self.bounds;
        _scrollView.maximumZoomScale = 3.0;
        _scrollView.minimumZoomScale = 1.0;
        _scrollView.multipleTouchEnabled = YES;
        _scrollView.delegate = self;
        _scrollView.scrollsToTop = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        //        _scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _scrollView.delaysContentTouches = NO;
    }
    return _scrollView;
}

- (UIView *)containerView
{
    if (!_containerView) {
        _containerView = [[UIView alloc] init];
    }
    return _containerView;
}





- (BOOL)isScaled
{
    return  1.0 != self.scrollView.zoomScale;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.waitingView.center = self.center;
    self.scrollView.frame = self.bounds;
    [self.scrollView setZoomScale:1.0];
    
    
}



- (void)setProgress:(CGFloat)progress
{
    _progress = progress;
    _waitingView.progress = progress;

}

- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder
{
    
    _waitingView.hidden = NO;
    
    __weak SDBrowserImageView *imageViewWeak = self;

    [self.imageView sd_setImageWithURL:url placeholderImage:placeholder options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        imageViewWeak.progress = (CGFloat)receivedSize / expectedSize;
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        _waitingView.hidden = YES;
        
        
        if (error) {
            UILabel *label = [[UILabel alloc] init];
            label.bounds = CGRectMake(0, 0, 160, 30);
            label.center = CGPointMake(imageViewWeak.bounds.size.width * 0.5, imageViewWeak.bounds.size.height * 0.5);
            label.text = @"图片加载失败";
            label.font = [UIFont systemFontOfSize:13];
            label.textColor = [UIColor whiteColor];
            label.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.8];
            label.layer.cornerRadius = 5;
            label.clipsToBounds = YES;
            label.textAlignment = NSTextAlignmentCenter;
            [imageViewWeak addSubview:label];
        } else {
            self.imageView.image = image;
            
            [self resetSubviewSize:image];
        }
   
    }];
}

- (void)resetSubviewSize:(id)obj
{
    CGRect frame;
    
    BOOL isLandscape = UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation);
    CGFloat w, h;
    
    w = ((UIImage *)obj).size.width;
    h = ((UIImage *)obj).size.height;
    CGFloat kViewWidth = UIScreen.mainScreen.bounds.size.width;
    
//    CGFloat width = MIN(kViewWidth, w);
    CGFloat width = kViewWidth;
    BOOL orientationIsUpOrDown = YES;
    if (isLandscape) {
        orientationIsUpOrDown = NO;
        CGFloat height = MIN(self.frame.size.height, h);
        frame.origin = CGPointZero;
        frame.size.height = height;
        UIImage *image = self.imageView.image;
        
        CGFloat imageScale = image.size.width/image.size.height;
        CGFloat screenScale = kViewWidth/self.frame.size.height;
        
        if (imageScale > screenScale) {
            frame.size.width = floorf(height * imageScale);
            if (frame.size.width > kViewWidth) {
                frame.size.width = kViewWidth;
                frame.size.height = kViewWidth / imageScale;
            }
        } else {
            CGFloat width = floorf(height * imageScale);
            if (width < 1 || isnan(width)) {
                //iCloud图片height为NaN
                width = self.frame.size.width;
            }
            frame.size.width = width;
        }
    } else {
        frame.origin = CGPointZero;
        frame.size.width = width;
        UIImage *image = self.imageView.image;
        
        CGFloat imageScale = image.size.height/image.size.width;
        CGFloat screenScale = self.frame.size.height/kViewWidth;
        
        if (imageScale > screenScale) {
            frame.size.height = floorf(width * imageScale);
        } else {
            CGFloat height = floorf(width * imageScale);
            if (height < 1 || isnan(height)) {
                //iCloud图片height为NaN
                height = self.frame.size.height;
            }
            frame.size.height = height;
        }
    }
    
    self.containerView.frame = frame;
    
    
    CGSize contentSize;
    if (orientationIsUpOrDown) {
        contentSize = CGSizeMake(width, MAX(self.frame.size.height, frame.size.height));
        if (frame.size.height < self.frame.size.height) {
            self.containerView.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
        } else {
            self.containerView.frame = (CGRect){CGPointMake((self.frame.size.width-frame.size.width)/2, 0), frame.size};
        }
    } else {
        contentSize = frame.size;
        if (frame.size.width < self.frame.size.width ||
            frame.size.height < self.frame.size.height) {
            self.containerView.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
        }
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.scrollView.contentSize = contentSize;
        
        self.imageView.frame = self.containerView.bounds;
        
        [self.scrollView scrollRectToVisible:self.bounds animated:NO];
    });
}

//- (void)zoomImage:(UIPinchGestureRecognizer *)recognizer
//{
//    [self prepareForImageViewScaling];
//    CGFloat scale = recognizer.scale;
//    CGFloat temp = _totalScale + (scale - 1);
//    [self setTotalScale:temp];
//    recognizer.scale = 1.0;
//}
//
//- (void)setTotalScale:(CGFloat)totalScale
//{
//    if ((_totalScale < 0.25 && totalScale < _totalScale) || (_totalScale > 4.0 && totalScale > _totalScale)) return; // 最大缩放 4倍,最小0.25倍
//
//    [self zoomWithScale:totalScale];
//}


//- (void)zoomWithScale:(CGFloat)scale
//{
//    _totalScale = scale;
//
//    _zoomingImageView.transform = CGAffineTransformMakeScale(scale, scale);
//
//    if (scale > 1) {
//        CGFloat contentW = _zoomingImageView.frame.size.width;
//        CGFloat contentH = MAX(_zoomingImageView.frame.size.height, self.frame.size.height);
////        CGFloat contentH = _zoomingImageView.frame.size.height;
//
//
////        if (_zoomingImageView.frame.size.height < self.frame.size.height ) {
//            _zoomingImageView.center = CGPointMake(contentW * 0.5, contentH * 0.5);
////        }else{
////            _zoomingImageView.frame = (CGRect){CGPointMake((self.frame.size.width - _zoomingImageView.frame.size.width)/2, 0), _zoomingImageView.frame.size};
////        }
//
//        _zoomingScroolView.contentSize = CGSizeMake(contentW, contentH);
////        [_zoomingScroolView scrollRectToVisible:self.bounds animated:NO];
//
//
//
//        CGPoint offset = _zoomingScroolView.contentOffset;
//        offset.x = (contentW - _zoomingScroolView.frame.size.width) * 0.5;
//        //        offset.y = (contentH - _zoomingImageView.frame.size.height) * 0.5;
//        _zoomingScroolView.contentOffset = offset;
//
//    } else {
//        _zoomingScroolView.contentSize = _zoomingScroolView.frame.size;
//        _zoomingScroolView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
//        _zoomingImageView.center = _zoomingScroolView.center;
//    }
//}

//- (void)zoomWithScale:(CGFloat)scale
//{
//    _totalScale = scale;
//
//    _zoomingImageView.transform = CGAffineTransformMakeScale(scale, scale);
//
//    if (scale > 1) {
//        CGFloat contentW = _zoomingImageView.frame.size.width;
//        CGFloat contentH = MAX(_zoomingImageView.frame.size.height, self.frame.size.height);
////        CGFloat contentH = _zoomingImageView.frame.size.height;
//
//
//        _zoomingImageView.center = CGPointMake(contentW * 0.5, contentH * 0.5);
//        _zoomingScroolView.contentSize = CGSizeMake(contentW, contentH);
//
//
//        CGPoint offset = _zoomingScroolView.contentOffset;
//        offset.x = (contentW - _zoomingScroolView.frame.size.width) * 0.5;
////        offset.y = (contentH - _zoomingScroolView.frame.size.height) * 0.5;
//        _zoomingScroolView.contentOffset = offset;
//
//    } else {
//        _zoomingScroolView.contentSize = _zoomingScroolView.frame.size;
//        _zoomingScroolView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
//        _zoomingImageView.center = _zoomingScroolView.center;
//    }
//}
//

- (void)singleTapAction
{
    if (self.singleTapCallBack) self.singleTapCallBack(self);
}
- (void)doubleTapAction:(UITapGestureRecognizer *)tap
{
    UIScrollView *scrollView = self.scrollView;
    
    CGFloat scale = 1;
    if (scrollView.zoomScale != 2.0) {
        scale = 2;
    } else {
        scale = 1;
    }
    CGRect zoomRect = [self zoomRectForScale:scale withCenter:[tap locationInView:tap.view]];
    [scrollView zoomToRect:zoomRect animated:YES];
}


- (CGRect)zoomRectForScale:(float)scale withCenter:(CGPoint)center
{
    CGRect zoomRect;
    zoomRect.size.height = self.scrollView.frame.size.height / scale;
    zoomRect.size.width  = self.scrollView.frame.size.width  / scale;
    zoomRect.origin.x    = center.x - (zoomRect.size.width  /2.0);
    zoomRect.origin.y    = center.y - (zoomRect.size.height /2.0);
    return zoomRect;
}

//
//- (void)prepareForImageViewScaling
//{
//    if (!_zoomingScroolView) {
//        _zoomingScroolView = [[UIScrollView alloc] initWithFrame:self.bounds];
//        _zoomingScroolView.backgroundColor = SDPhotoBrowserBackgrounColor;
//        _zoomingScroolView.contentSize = self.bounds.size;
//        _zoomingScroolView.delegate = self;
//        _zoomingScroolView.minimumZoomScale = 1;
//        _zoomingScroolView.maximumZoomScale = 3;
//        UIImageView *zoomingImageView = [[UIImageView alloc] initWithImage:self.image];
//        CGSize imageSize = zoomingImageView.image.size;
//        CGFloat imageViewH = self.bounds.size.height;
//        if (imageSize.width > 0) {
//            imageViewH = self.bounds.size.width * (imageSize.height / imageSize.width);
//        }
//        zoomingImageView.bounds = CGRectMake(0, 0, self.bounds.size.width, imageViewH);
//        zoomingImageView.center = _zoomingScroolView.center;
//        zoomingImageView.contentMode = UIViewContentModeScaleAspectFit;
//        _zoomingImageView = zoomingImageView;
//        [_zoomingScroolView addSubview:zoomingImageView];
//        [self addSubview:_zoomingScroolView];
//    }
//}
//
//- (void)scaleImage:(CGFloat)scale
//{
//    [self prepareForImageViewScaling];
//    [self setTotalScale:scale];
//}

// 清除缩放
- (void)eliminateScale
{
    [self clear];
    
}

- (void)clear
{
   
    [self.scrollView setZoomScale:1 animated:true];

}





#pragma mark scrollViewDelegate


- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return scrollView.subviews[0];
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    
    CGFloat offsetX = (scrollView.frame.size.width > scrollView.contentSize.width) ? (scrollView.frame.size.width - scrollView.contentSize.width) * 0.5 : 0.0;
    CGFloat offsetY = (scrollView.frame.size.height > scrollView.contentSize.height) ? (scrollView.frame.size.height - scrollView.contentSize.height) * 0.5 : 0.0;
    self.containerView.center = CGPointMake(scrollView.contentSize.width * 0.5 + offsetX, scrollView.contentSize.height * 0.5 + offsetY);
}



@end
