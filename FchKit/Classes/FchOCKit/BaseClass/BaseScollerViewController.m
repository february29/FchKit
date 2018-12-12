//
//  BaseScollerViewController.m
//  KT
//
//  Created by bai on 2018/10/23.
//  Copyright © 2018年 北京仙指信息技术有限公司. All rights reserved.
//

#import "BaseScollerViewController.h"

@interface BaseScollerViewController ()

@end

@implementation BaseScollerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(UIScrollView *)scrollerView{
    
    
    if (!_scrollerView) {
        _scrollerView = [UIScrollView new];
        //        _scrollerView.backgroundColor = GLOBLENEVBGGRAY;
        _scrollerView.showsVerticalScrollIndicator = NO;
        _scrollerView.showsHorizontalScrollIndicator = NO;
        
        [self.view addSubview:_scrollerView];
        [_scrollerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view);
            make.left.equalTo(self.view);
            make.right.equalTo(self.view);
            make.bottom.mas_equalTo(self.view);
            
        }];
        [_scrollerView addSubview:self.scrollerContentView];
        [self.scrollerContentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(_scrollerView);
            make.width.equalTo(_scrollerView);
            
        }];
    }
    
    return _scrollerView;
}

-(UIView *)scrollerContentView{
    if (!_scrollerContentView) {
        _scrollerContentView = [UIView new];
        _scrollerContentView.backgroundColor = [UIColor clearColor];
        _scrollerContentView.userInteractionEnabled = YES;
        
    }
    
    return _scrollerContentView;
}

@end
