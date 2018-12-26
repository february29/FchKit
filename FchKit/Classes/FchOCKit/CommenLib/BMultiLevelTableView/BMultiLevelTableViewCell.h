//
//  BmuitiLevelTableViewCell.h
//  KT
//
//  Created by bai on 2018/10/24.
//  Copyright © 2018年 北京仙指信息技术有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMultiLevelModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface BMultiLevelTableViewCell : UITableViewCell

@property (nonatomic, strong) BMultiLevelModel *model;




@property (nonatomic, strong) void(^leftImageClickBlock)(UIView *image) ;


@property (nonatomic, strong) UIImageView *leftImage;

@property (nonatomic, strong) UILabel *nodeLabel;

@property (nonatomic, strong) UIView *line;

@property (nonatomic, assign) CGRect rect;


@end

NS_ASSUME_NONNULL_END
