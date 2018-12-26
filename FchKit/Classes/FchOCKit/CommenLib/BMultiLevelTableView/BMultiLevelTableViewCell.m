//
//  BmuitiLevelTableViewCell.m
//  KT
//
//  Created by bai on 2018/10/24.
//  Copyright © 2018年 北京仙指信息技术有限公司. All rights reserved.
//

#import "BMultiLevelTableViewCell.h"

static CGFloat const leftMargin = 15.0;
@implementation BMultiLevelTableViewCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        _leftImage = [[UIImageView alloc] initWithFrame:CGRectZero];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageTapAction:)];
        [_leftImage setUserInteractionEnabled:YES];
        [_leftImage addGestureRecognizer:tap];
        _leftImage.contentMode = UIViewContentModeCenter;
        [self  addSubview:_leftImage];
        
        _nodeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _nodeLabel.font  =[UIFont systemFontOfSize:16];
        [self addSubview:_nodeLabel];
        
        //        _selectedBtn = [UIButton new];
        //        [_selectedBtn setTitle:@"选择" forState:0];
        //        [_selectedBtn setTitleColor:[UIColor colorWithRed:0/255.0 green:111/255.0 blue:0/255.0 alpha:1] forState:0];
        //        [_selectedBtn.titleLabel setFont:[UIFont systemFontOfSize:13]];
        //        [_selectedBtn addTarget:self action:@selector(selectedClickBlock:) forControlEvents:UIControlEventTouchUpInside];
        //        [self addSubview:_selectedBtn];
        
        _line = [[UIView alloc] initWithFrame:CGRectZero];
        _line.backgroundColor = [UIColor colorWithWhite:0.95f alpha:1];//[UIColor lightGrayColor];
        [self addSubview:_line];
    }
    return self;
}


//-(void)selectedClickBlock:(UIButton *)button{
//    self.selectedBtnClickBlock(button);
//}

-(void)imageTapAction:(UITapGestureRecognizer *)tapGestureRecognizer{
    self.leftImageClickBlock(tapGestureRecognizer.view);
}

-(void)setModel:(BMultiLevelModel *)model{
    _model = model;
    
    
    CGFloat indentationX = 0;
    CGFloat rgbValue = 0;
    for (int i = 1; i<model.level;i++) {
        indentationX += leftMargin;
        rgbValue += 50;
    }
    //set indentation
    [self moveNode:indentationX];

    _nodeLabel.textColor  = [UIColor colorWithRed:rgbValue/255.0 green:rgbValue/255.0 blue:rgbValue/255.0 alpha:1];
    _nodeLabel.text = model.name;

    if (model.isExpand || model.isLeaf) {
        _leftImage.image = [UIImage imageNamed:@"btn_panel_hide"];
    }else{
        _leftImage.image = [UIImage imageNamed:@"btn_panel_show"];
    }

    _leftImage.hidden = model.isLeaf;//hidden left log for leaf node or not
}


- (void)moveNode:(CGFloat)indentationX{

    CGFloat cellHeight = _rect.size.height;
    CGFloat cellWidth  = _rect.size.width;

    CGRect frame = CGRectMake(leftMargin, 0, cellWidth-leftMargin, cellHeight);
    frame.origin.x = leftMargin+indentationX;
    _nodeLabel.frame = frame;

    CGRect frame1 = CGRectMake(cellWidth-50, 0, cellHeight, cellHeight);
    frame1.origin.x = cellWidth-cellHeight;
    _leftImage.frame = frame1;

    CGRect frame2 = CGRectMake(0, cellHeight-1, cellWidth, 1);
    frame2.origin.x = indentationX;
    _line.frame = frame2;

    //    CGRect frame3 = CGRectMake(cellWidth-50, 0, 50, cellHeight);
    //    frame3.origin.x = leftMargin+indentationX;
    //    _selectedBtn.frame = frame3;

}

@end
