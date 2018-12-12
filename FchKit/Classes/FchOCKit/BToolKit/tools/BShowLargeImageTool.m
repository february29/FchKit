//
//  BShowLargeImageTool.m
//  Fch_OA
//
//  Created by bai on 2017/1/10.
//  Copyright © 2017年 bai.xianzhi. All rights reserved.
//

#import "BShowLargeImageTool.h"
#import "SDBrowserImageView.h"
#import <BlocksKit+UIKit.h>



@interface BShowLargeImageTool(){
    UIWindow *window;
    UIView *mSender;
}
@end


@implementation BShowLargeImageTool

+(instancetype)sharedInstance{
    static BShowLargeImageTool *instance;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        instance = [[[self class]alloc]init];
    });
    return instance;
}




-(void)showLargeImageWithImageUrl:(NSString *)imageUrl sender:(UIView * )sender{
    
     window = [UIApplication sharedApplication].keyWindow;
    mSender = sender;

    
//    UIView *contentView = [UIView new];
//    [contentView setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.95]];
//    [window addSubview:contentView];
    
    [window setBackgroundColor:[UIColor blackColor]];
    SDBrowserImageView *imageView = [[SDBrowserImageView alloc] init];
    
    
    
    
    
     [imageView setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:@""]];
    imageView.hidden = YES;
    
    [window addSubview:imageView];
    
    
    
    //动画相关
    UIView *sourceView = sender;
    CGRect rect = [sender convertRect: sender.bounds toView:window];
    
    UIImageView *tempView = [[UIImageView alloc] init];
    UIImage *image;
    if ([sender isKindOfClass:[UIButton class]]) {
        image =((UIButton *) sender).currentImage;
       
    }else{
        image = ((UIImageView *) sender).image;
    }
     tempView.image =image;
     tempView.frame = rect;
    [window addSubview:tempView];
    
    //默认图片大小
    float scale = image.size.width/image.size.height;
    CGFloat w = window.bounds.size.width;
    CGFloat h = window.bounds.size.height;
//    CGFloat h = w/scale;

   
    CGRect targetTemp = CGRectMake(0, window.frame.size.height/2-h/2, w, h);
    imageView.frame = targetTemp;
   
   
    
    
    
    [UIView animateWithDuration:SDPhotoBrowserShowImageAnimationDuration animations:^{
        tempView.center = window.center;
        tempView.bounds = (CGRect){CGPointZero, targetTemp.size};
    } completion:^(BOOL finished) {
        imageView.hidden = NO;
        [tempView removeFromSuperview];
       
    }];
    
    
    
    // 单击图片
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(photoClick:)];
    
    // 双击放大图片
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewDoubleTaped:)];
    doubleTap.numberOfTapsRequired = 2;
    
    [singleTap requireGestureRecognizerToFail:doubleTap];
    
    [imageView addGestureRecognizer:singleTap];
    [imageView addGestureRecognizer:doubleTap];

    
    
    //图片点击
//    [imageView bk_whenTapped:^{
//        
//
//    }];
//    
//    [imageView bk_whenDoubleTapped:^{
//
//    }];
//
    
}

- (void)photoClick:(UITapGestureRecognizer *)recognizer
{
    SDBrowserImageView *currentImageView = (SDBrowserImageView *)recognizer.view;
   
    
    
    
    UIView *sourceView = mSender;
    CGRect targetTemp = [mSender convertRect:sourceView.frame toView:window];
    
    UIImageView *tempView = [[UIImageView alloc] init];
    tempView.contentMode = sourceView.contentMode;
    tempView.clipsToBounds = YES;
    tempView.image = currentImageView.image;
    //        CGFloat h = (self.bounds.size.width / currentImageView.image.size.width) * currentImageView.image.size.height;
    //
    //        if (!currentImageView.image) { // 防止 因imageview的image加载失败 导致 崩溃
    //            h = self.bounds.size.height;
    //        }
    //
    //        tempView.bounds = CGRectMake(0, 0, self.bounds.size.width, h);
    //        tempView.center = self.center;
    //
    //        [self addSubview:tempView];
    //
    //        _saveButton.hidden = YES;
    
    [UIView animateWithDuration:SDPhotoBrowserHideImageAnimationDuration animations:^{

         tempView.frame = targetTemp;
        
    } completion:^(BOOL finished) {
        [currentImageView removeFromSuperview];
    }];

  
    
}

- (void)imageViewDoubleTaped:(UITapGestureRecognizer *)recognizer
{
    SDBrowserImageView *imageView = (SDBrowserImageView *)recognizer.view;
    CGFloat scale;
    if (imageView.isScaled) {
        scale = 1.0;
    } else {
        scale = 2.0;
    }
    
    SDBrowserImageView *view = (SDBrowserImageView *)recognizer.view;
    
//    [view doubleTapToZommWithScale:scale];

}




@end
