
//  BaseViewController.m
//
//  Created by bai on 16/2/16.
//  Copyright © 2016年 bai.xianzhi. All rights reserved.


#import "BaseViewController.h"


//#import <MBProgressHUD.h>
//#import "StringTool.h"






//#import "ColorImageTool.h"


@interface BaseViewController ()<UIAlertViewDelegate>{
   // IQKeyboardReturnKeyHandler *returnKeyHandler;
//    LuosHudView *hudView;
}

//@property (nonatomic,strong) UIImageView *bgImage;

@end

@implementation BaseViewController


//-(void)loadView
//{
//    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
//    self.view = scrollView;
//}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self confitNavgationBar];
}


- (void)confitNavgationBar{
    //    self.bgImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bg_dafault"]];
    //    self.bgImage.frame = self.view.bounds;
    //    [self.view addSubview:self.bgImage];
    
    //
    //    [self.view setBackgroundColor:GLOBLEBACKGRAY];
    //    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    //创建一个高20的假状态栏背景
    //    UIView *statusBarView = [[UIView alloc] initWithFrame:CGRectMake(0, -20, MSCW+MSCH, 20)];
    //    statusBarView.backgroundColor=[UIColor blackColor];
    //    [self.navigationController.navigationBar addSubview:statusBarView];
    
    
    //    CAGradientLayer *layer = [CAGradientLayer new];
    //    //colors存放渐变的颜色的数组
    //    layer.colors=@[(__bridge id)[UIColor greenColor].CGColor,(__bridge id)[UIColor whiteColor].CGColor];
    //    /**
    //     * 起点和终点表示的坐标系位置，(0,0)表示左上角，(1,1)表示右下角
    //     */
    //    layer.startPoint = CGPointMake(0, 0);
    //    layer.endPoint = CGPointMake(0, 1);
    //    layer.frame = self.navigationController.view.bounds;
    //    [self.navigationController.view.layer addSublayer:layer];
    
    
    
    //    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"bg-top"] forBarMetrics:UIBarMetricsDefault];
    //    [self.navigationController.navigationBar setBackgroundImage:[ColorImageTool createImageWithColor:[UIColor colorWithRed:23/255.0 green:148/255.0 blue:200/255.0 alpha:1]] forBarMetrics:UIBarMetricsDefault];
    
    //    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    //    self.navigationController.navigationBar.shadowImage = [[UIImage alloc]init];
    
    
    //    //修改导航栏文字颜色，
    //    UIColor * color = [UIColor blackColor];
    //    //这里我们设置的是颜色，还可以设置shadow等，具体可以参见api
    //    NSDictionary * dict=[NSDictionary dictionaryWithObject:color forKey:NSForegroundColorAttributeName];
    //    self.navigationController.navigationBar.titleTextAttributes = dict;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:21],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    // [self.navigationController.navigationBar setBackgroundColor:[UIColor blackColor]];
    
    
    
    
    // 左侧的button
    UIView *leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 50, 44)];
    _leftbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _leftbtn.frame = CGRectMake(0, 0, 44, 44);
    [_leftbtn setImage:[UIImage imageNamed:@"btn-top-back"] forState:UIControlStateNormal];
    [_leftbtn setImageEdgeInsets:UIEdgeInsetsMake(7.5,0, 7.5, 15)];
    [_leftbtn addTarget: self action: @selector(goBackAction) forControlEvents: UIControlEventTouchUpInside];
    [_leftbtn setTitleColor:[UIColor whiteColor] forState:0];
    [leftView addSubview:_leftbtn];
    UIBarButtonItem*back=[[UIBarButtonItem alloc]initWithCustomView:leftView];
    self.navigationItem.leftBarButtonItem=back;
    
    
    // 右侧的button
    UIView *rightView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 50, 44)];
    _rigthtbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _rigthtbtn.frame = CGRectMake(6, 0, 44, 44);
    [_rigthtbtn setImage:[UIImage imageNamed:@"btn_top_setting"] forState:UIControlStateNormal];
    [_rigthtbtn setTitleColor:[UIColor whiteColor] forState:0];
    [_rigthtbtn.titleLabel setFont:[UIFont systemFontOfSize:17]];
    [_rigthtbtn addTarget: self action: @selector(rightBarButtonAction:) forControlEvents: UIControlEventTouchUpInside];
    _rigthtbtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [rightView addSubview:_rigthtbtn];
    UIBarButtonItem*rigthbtnitem=[[UIBarButtonItem alloc]initWithCustomView:rightView];
    _rigthtbtn.hidden = YES;
    self.navigationItem.rightBarButtonItem=rigthbtnitem;
    
    
    
    //       self.navigationController.navigationBarHidden = NO;
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];

}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];

}



- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
- (BOOL)prefersStatusBarHidden
{
    return NO;
}

#pragma mark Button
-(void)setLeftBtnHidde:(BOOL)hidde{
    _leftbtn.hidden = hidde;
}
-(void)setRigthtBtnHidde:(BOOL)hidde{
    _rigthtbtn.hidden = hidde;
}

-(void)goBackAction{
    
    if (self.navigationController) {
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    
    
}

-(void)setLeftbtnTitle:(NSString *)title{
    [self setLeftBtnHidde:NO];
    [self.leftbtn setImage:nil forState:0];
    [self.leftbtn setTitle:title forState:0];
    [self.leftbtn.titleLabel setFont:[UIFont systemFontOfSize:16]];
}



-(void)setRigthtbtnTitle:(NSString *)title{
    [self setRigthtBtnHidde:NO];
    [self.rigthtbtn setImage:nil forState:0];
    [self.rigthtbtn setTitle:title forState:0];
    [self.rigthtbtn.titleLabel setFont:[UIFont systemFontOfSize:16]];
}



-(void)setRigthtbtnImage:(UIImage *)image{
    [self setRigthtBtnHidde:NO];
    [self.rigthtbtn setImage:image forState:0];
    self.rigthtbtn.imageEdgeInsets = UIEdgeInsetsMake(10, 20, 10, 0);
    
}

-(void)rightBarButtonAction:(id)sender{
    
}


-(void)alertViewWithTitle:(NSString *)title  message:(NSString *)massage cancleBlock:(void(^)(void))cancleBlock okBlock:(void(^)(void))okBlock{
    
    
    UIAlertController *alert  = [UIAlertController alertControllerWithTitle:title message:massage preferredStyle:UIAlertControllerStyleAlert];
    
    if (cancleBlock){
        UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            if (cancleBlock) {
                cancleBlock();
            }
        }];
        [alert addAction:cancleAction];
    }
    
    if (okBlock){
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if (okBlock) {
                okBlock();
            }
        }];
        [alert addAction:okAction];
    }
    [self presentViewController:alert animated:YES completion:nil];
    
}

@end
