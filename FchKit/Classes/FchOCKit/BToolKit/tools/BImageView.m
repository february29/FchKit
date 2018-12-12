//
//  BImageView.m
//  Lou_s
//
//  Created by bai on 2017/5/25.
//  Copyright © 2017年 北京仙指信息技术有限公司. All rights reserved.
//

#import "BImageView.h"
#import <UIImageView+WebCache.h>
#import <Masonry.h>

@implementation BImageView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _imageView = [UIImageView new];
//        _imageView.frame = self.bounds;
        [self addSubview:_imageView];
        
        [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
            make.height.width.equalTo(self);
           
        }];

        
    }
    return self;
}




-(void)b_setImage:(UIImage *)image{
    
    _imageView.image = image;
    if (image) {
        if (image.size.width>image.size.height) {
            
            if (image.size.width>self.frame.size.width) {
                //宽图片 图片宽度大于控件宽度
                __block float imageh = image.size.height / image.size.width * self.frame.size.width;
                [_imageView mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.center.equalTo(self);
                    make.width.equalTo(self);
                    make.height.mas_equalTo(imageh);
                    
                }];

            }else{
                [_imageView mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.center.equalTo(self);
                    make.width.mas_equalTo(image.size.width);
                    make.height.mas_equalTo(image.size.height);
                }];
                    

            }
            
            
        }else{
            
            
            if (image.size.height>self.frame.size.height) {
                //高图片 高度大于控件高度
                float imagew = image.size.width / image.size.height * self.frame.size.height;
                [_imageView mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.center.equalTo(self);
                    make.width.mas_equalTo(imagew);
                    make.height.mas_equalTo(self);
                    
                }];

            }else{
                [_imageView mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.center.equalTo(self);
                    make.width.mas_equalTo(image.size.width);
                    make.height.mas_equalTo(image.size.height);
                }];
            }
           
        }
        
    }

}

-(void)b_setImageUrl:(NSString *)imageUrl placeholderImage:(UIImage *)placeholderImage{
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:placeholderImage completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        
        //重新设置图片位置大小
        if (image) {
            if (image.size.width>image.size.height) {
                
                if (image.size.width>self.frame.size.width) {
                    //宽图片 图片宽度大于控件宽度
                    __block float imageh = image.size.height / image.size.width * self.frame.size.width;
                    [_imageView mas_remakeConstraints:^(MASConstraintMaker *make) {
                        make.center.equalTo(self);
                        make.width.equalTo(self);
                        make.height.mas_equalTo(imageh);
                        
                    }];
                    
                }else{
                    [_imageView mas_remakeConstraints:^(MASConstraintMaker *make) {
                        make.center.equalTo(self);
                        make.width.mas_equalTo(image.size.width);
                        make.height.mas_equalTo(image.size.height);
                    }];
                    
                    
                }
                
                
            }else{
                
                
                if (image.size.height>self.frame.size.height) {
                    //高图片 高度大于控件高度
                    float imagew = image.size.width / image.size.height * self.frame.size.height;
                    [_imageView mas_remakeConstraints:^(MASConstraintMaker *make) {
                        make.center.equalTo(self);
                        make.width.mas_equalTo(imagew);
                        make.height.mas_equalTo(self);
                        
                    }];
                    
                }else{
                    [_imageView mas_remakeConstraints:^(MASConstraintMaker *make) {
                        make.center.equalTo(self);
                        make.width.mas_equalTo(image.size.width);
                        make.height.mas_equalTo(image.size.height);
                    }];
                }
                
            }
            
        }
        
    }];

}

-(void)b_setImageUrl:(NSString *)imageUrl{
    [self b_setImageUrl:imageUrl placeholderImage:nil];
    
}

@end
