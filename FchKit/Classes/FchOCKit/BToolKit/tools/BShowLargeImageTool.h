//
//  BShowLargeImageTool.h
//  Fch_OA
//
//  Created by bai on 2017/1/10.
//  Copyright © 2017年 bai.xianzhi. All rights reserved.
//




/**
 显示大图片   半成品  带完善

 @param instancetype

 @return 
 */
#import <UIKit/UIKit.h>

@interface BShowLargeImageTool : NSObject

+(instancetype)sharedInstance;
-(void)showLargeImageWithImageUrl:(NSString *)imageUrl sender:(UIView * )sender ;
@end
