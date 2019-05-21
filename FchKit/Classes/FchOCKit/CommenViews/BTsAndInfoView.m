//
//  BTsAndInfoView.m
//  Fch_OA
//
//  Created by bai on 2018/11/15.
//  Copyright © 2018 bai.xianzhi. All rights reserved.
//

#import "BTsAndInfoView.h"


#import "Masonry.h"


@implementation BTsAndInfoView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        //        self.backgroundColor = [UIColor whiteColor];
        //        self.layer.cornerRadius =  5;
        
        
        _tsLable = [UILabel new];
//        _tsLable.font = [UIFont boldSystemFontOfSize:FONT_LARGE];
//        _tsLable.textColor = TEXTGRAYCOLOR;
        _tsLable.text = @"批示内容：";
        [_tsLable sizeToFit];
        [self addSubview:_tsLable];
        
        _tsLable.numberOfLines = 1;
        [_tsLable sizeToFit ];
        [_tsLable mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self);
            make.left.equalTo(self);
            make.width.mas_greaterThanOrEqualTo(90).priorityHigh();
        }];
        
        _inforLable = [UILabel new];
//        _inforLable.font = font;
//        _inforLable.textColor = TEXTGRAYCOLOR;
        _inforLable.numberOfLines = 0;
        _inforLable.text = @" ";
        _inforLable.lineBreakMode = NSLineBreakByCharWrapping;
        [self addSubview:_inforLable];
        [_inforLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_tsLable);
            make.left.equalTo(_tsLable.mas_right);
            make.right.equalTo(self);
            make.height.mas_greaterThanOrEqualTo(_tsLable);
            
        }];
        
        
        
        
        
        [self.tsLable setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
        [self.tsLable setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
        //        [self.inforLable setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
        
        //         [self.inforLable setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
        
        //        [self.inforLable setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
        
        
    }
    return self;
}



@end
