//
//  LHFAlertViewController.m
//  lianxi
//
//  Created by 李鸿飞 on 2018/5/4.
//  Copyright © 2018年 李鸿飞. All rights reserved.
//

#import "LHFAlertViewController.h"
#import "BaseDefine.h"
@interface LHFAlertViewController ()

@property(nonatomic,strong)UIWindow *alertWindow;

@property (nonatomic ,strong) UIView *transparentView;
@property (nonatomic ,strong) UIView *alertView;
@property (nonatomic ,strong) UILabel *labTitle;
@property (nonatomic ,strong) UILabel *contentLable;
@property (nonatomic ,strong) UIButton *okBtn;
@property (nonatomic ,strong) UIButton *cancleBtn;
@property (nonatomic,strong) NSString *content;

@end

@implementation LHFAlertViewController


-(UIView *)transparentView{
    if (_transparentView == nil) {
        //遮罩背景
        _transparentView = [[UIView alloc]initWithFrame:self.view.frame];
        _transparentView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
        //弹窗视图
        self.alertView = [UIView new];
        self.alertView.backgroundColor = [UIColor whiteColor];
        self.alertView.layer.cornerRadius = 5.0;
        self.alertView.layer.masksToBounds = YES;
        [self.transparentView addSubview:self.alertView];
        [self.alertView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.transparentView.mas_centerY).mas_offset(-100);
            make.centerX.equalTo(self.transparentView);
            make.width.mas_equalTo(250);
        }];
        //提示内容
        self.contentLable = [UILabel new];
        self.contentLable.numberOfLines = 0;
        self.contentLable.textColor = TEXTGRAYCOLOR;
        self.contentLable.textAlignment = NSTextAlignmentCenter;
        self.contentLable.font = [UIFont boldSystemFontOfSize:20];
        self.contentLable.text = self.content;
        [self.alertView addSubview:self.contentLable];
        [self.contentLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.alertView).mas_offset(20);
            make.left.equalTo(self.alertView).mas_offset(12);
            make.right.equalTo(self.alertView).mas_offset(-12);
        }];
        
        //确定按钮点击
        self.okBtn = [UIButton new];
        [self.okBtn setTitle:@"确定" forState:UIControlStateNormal];
        self.okBtn.layer.cornerRadius = 5.0;
        self.okBtn.layer.masksToBounds = YES;
        self.okBtn.backgroundColor = TEXTBLUECOLOR;
        
        [self.okBtn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
        
        [self.alertView addSubview:self.okBtn];
        
        if (self.showOkAndCancleBtn) {
            [self.okBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.contentLable.mas_bottom).mas_offset(15);
                make.left.equalTo(self.alertView).offset(35);
                make.width.mas_equalTo(80);
                make.height.mas_equalTo(30);
            }];
        }else{
            [self.okBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.contentLable.mas_bottom).mas_offset(15);
                make.centerX.equalTo(self.alertView);
                make.width.mas_equalTo(80);
                make.height.mas_equalTo(30);
            }];
        }
    
        //确定按钮点击
        self.cancleBtn = [UIButton new];
        if (self.showOkAndCancleBtn) {
            self.cancleBtn.hidden = NO;
        }else{
            self.cancleBtn.hidden = YES;
        }
        [self.cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
        self.cancleBtn.layer.cornerRadius = 5.0;
        self.cancleBtn.layer.masksToBounds = YES;
        self.cancleBtn.backgroundColor = [UIColor colorWithWhite:0.6 alpha:0.7];
        
        [self.cancleBtn addTarget:self action:@selector(cancleBtnClick) forControlEvents:UIControlEventTouchUpInside];
        
        [self.alertView addSubview:self.cancleBtn];
        
        [self.cancleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.okBtn);
            make.left.equalTo(self.okBtn.mas_right).offset(20);
            make.width.mas_equalTo(80);
            make.height.mas_equalTo(30);
        }];
        
        
        [self.alertView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.okBtn.mas_bottom).mas_offset(15);
        }];
        
    }
    
    return _transparentView;
}

#pragma mark ******viewDidLoad********
- (void)viewDidLoad {
    [super viewDidLoad];
}

/**
 确定按钮点击
 */
-(void)btnClick
{
    self.alertWindow.hidden = YES;
    self.alertWindow = nil;
    if (self.btnAction) {
        self.btnAction();
    }
    
}
/**
 取消按钮点击
 */
-(void)cancleBtnClick
{
    self.alertWindow.hidden = YES;
    self.alertWindow = nil;
}


-(void)alertShowWith:(NSString *)string{
    
    self.content = string;    
    self.alertWindow = [[UIWindow alloc]initWithFrame:self.view.frame];
    self.alertWindow.rootViewController = self;
    self.alertWindow.windowLevel = UIWindowLevelAlert;
    [self.alertWindow makeKeyAndVisible];
    
    [self.alertWindow addSubview:self.transparentView];
}


@end
