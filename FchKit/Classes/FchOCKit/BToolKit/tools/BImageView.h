//
//  BImageView.h
//  Lou_s
//
//  Created by bai on 2017/5/25.
//  Copyright © 2017年 北京仙指信息技术有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BImageView : UIView

@property(nonatomic,retain,readwrite)UIImageView *imageView;

-(void)b_setImage:(UIImage *)image;

-(void)b_setImageUrl:(NSString *)imageUrl;

-(void)b_setImageUrl:(NSString *)imageUrl placeholderImage:(UIImage *)placeholderImage;

@end
