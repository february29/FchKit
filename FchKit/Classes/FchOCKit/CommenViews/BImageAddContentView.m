//
//  BImageAddContentView.m
//  SJTZ
//
//  Created by bai on 2018/1/4.
//  Copyright © 2018年 北京仙指信息技术有限公司. All rights reserved.
//

#import "BImageAddContentView.h"
#import "Masonry.h"
#import "BlocksKit+UIKit.h"
//#import "BaseDefine.h"

@interface BImageAddContentView(){
//    UIButton *addBtn;
    
    NSMutableArray *imageViewsArray;
    float itemw;
    
    
}
@end


@implementation BImageAddContentView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _currentImageArray = [NSMutableArray new];
        imageViewsArray = [NSMutableArray new];
        
        _marging = 15;
        _cloumeCount = 3;
        
        
        itemw = ([UIScreen mainScreen].bounds.size.width-6*2-_marging*(_cloumeCount+1))/_cloumeCount;

        self.addBtn = [UIButton new];
        [self.addBtn setImage:[UIImage imageNamed:@"img_clickadd"] forState:0];
        [self addSubview:self.addBtn];
        [self.addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self);
            make.left.equalTo(self).offset(_marging);
//            make.bottom.equalTo(self);
            make.width.height.mas_equalTo(itemw);
//            make.bottom.equalTo(self);
            
        }];

        [self.addBtn bk_addEventHandler:^(id sender) {
            
            if(self.addBtnClickBlock){
                self.addBtnClickBlock(sender);
            }
            
        } forControlEvents:UIControlEventTouchUpInside];

    }
    return self;
}


-(void)setAddBtnW:(float)addBtnW{
    _addBtnW = addBtnW;
    [self.addBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.left.equalTo(self).offset(_marging);
        //            make.bottom.equalTo(self);
        make.width.height.mas_equalTo(addBtnW);
        //            make.bottom.equalTo(self);
    }];
}

-(void)addImages:(NSArray<UIImage *> *)imageArray{
    
    [_currentImageArray addObjectsFromArray:imageArray];
    if(imageViewsArray.count<_currentImageArray.count){
        
        for (int i = (int)imageViewsArray.count; i<_currentImageArray.count; i++) {
            UIImageView *imageView = [UIImageView new];
            imageView.tag = i;
//            imageView.contin
            imageView.layer.masksToBounds = YES;
            imageView.contentMode = UIViewContentModeScaleAspectFill;
            imageView.image = _currentImageArray[i];
            imageView.userInteractionEnabled = YES;
            [imageView bk_whenTapped:^{
                [self deleteImagesAtIndex:imageView.tag];
            }];
            [imageViewsArray addObject:imageView];
            
            
            UIButton *deletedBtn = [UIButton new];
            deletedBtn.userInteractionEnabled = NO;
            [deletedBtn setImage:[UIImage imageNamed:@"btn_close"] forState:0];
            [imageView addSubview:deletedBtn];
            [deletedBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(imageView.mas_right);
                make.top.equalTo(imageView.mas_top);
                make.width.height.mas_equalTo(15);
               
            }];

            
            
            [self addSubview:imageView];
        }
    }
    

    
    
    [self reLayoutSubViews];
}

-(void)reLayoutSubViews{
    
    float itemw = (self.frame.size.width-_marging*(_cloumeCount+1))/_cloumeCount;
    __block UIView *tempView;
    [imageViewsArray enumerateObjectsUsingBlock:^(UIView *view, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [view mas_remakeConstraints:^(MASConstraintMaker *make) {
            if (tempView) {
                if(idx%_cloumeCount==0){
                    make.top.equalTo(tempView.mas_bottom).offset(_marging);
                    make.left.equalTo(self).offset(_marging);
                }else{
                    make.top.equalTo(tempView);
                    make.left.equalTo(tempView.mas_right).offset(_marging);
                }
            }else{
                make.top.equalTo(self);
                make.left.equalTo(self).offset(_marging);
            }
            make.width.height.mas_equalTo(itemw);
        }];
        tempView = view;
        
    }];
    
    
    if (_currentImageArray.count>0){
        int index = (int)_currentImageArray.count;
        
        [self.addBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            if(index%_cloumeCount==0){
                make.top.equalTo(tempView.mas_bottom).offset(_marging);
                make.left.equalTo(self).offset(_marging);
            }else{
                make.top.equalTo(tempView);
                make.left.equalTo(tempView.mas_right).offset(_marging);
            }
            make.width.height.mas_equalTo(itemw);
        }];
    }else{
        [self.addBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self);
            make.left.equalTo(self).offset(_marging);
            make.width.height.mas_equalTo(itemw);
        }];
    }
    
    
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.addBtn);
    }];
    
    
    
    [UIView animateWithDuration:0.25 animations:^{
        [self layoutIfNeeded];
    }];
}

-(void)deleteImagesAtIndex:(NSInteger)index{
    
    
    
    [_currentImageArray removeObjectAtIndex:index];
    UIView *removedView = [imageViewsArray objectAtIndex:index];
    [removedView removeFromSuperview];
    [imageViewsArray removeObjectAtIndex:index];
    
    //重置tag
    [imageViewsArray enumerateObjectsUsingBlock:^(UIView  *view, NSUInteger idx, BOOL * _Nonnull stop) {
        view.tag =idx;
    }];
    [self reLayoutSubViews];
    
    if (self.deleteImageBlock) {
        self.deleteImageBlock(index);
    }
}

-(void)removeAllImages{
    [_currentImageArray removeAllObjects];
    [imageViewsArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];
    [imageViewsArray removeAllObjects];
    [self reLayoutSubViews];
}

@end
