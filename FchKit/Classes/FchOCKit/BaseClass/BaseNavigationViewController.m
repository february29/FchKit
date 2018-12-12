//
//  BaseNavigationViewController.m
//  slwl_hz
//
//  Created by bai on 16/3/3.
//  Copyright © 2016年 bai.xianzhi. All rights reserved.
//






#import "BaseNavigationViewController.h"



@implementation BNavTitleView

-(CGSize)intrinsicContentSize

{
    
    return UILayoutFittingExpandedSize;
    
}

//-(void)setFrame:(CGRect)frame{
//    float w = [UIScreen mainScreen].bounds.size.width*0.618;
//     [super setFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2-w/2, 0,w,44)];
//}

@end

@interface BaseNavigationViewController ()<UINavigationControllerDelegate,UIGestureRecognizerDelegate>{
    UIPercentDrivenInteractiveTransition *_interactiveTransition;
}
@end




@implementation BaseNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.orietation = UIInterfaceOrientationMaskPortrait;
    
    



    
    
    //系统自带滑动触发方式
    self.interactivePopGestureRecognizer.delegate = self;
    
}



// 作用：拦截手势触发
- (BOOL)gestureRecognizerShouldBegin:(UIPanGestureRecognizer *)gestureRecognizer
{
    if (self.childViewControllers.count == 1) {
        // 表示用户在根控制器界面，就不需要触发滑动手势，
        return NO;
    }
    
    
    return YES;
   
}





- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}


//ios8 隐藏状态栏
- (BOOL)prefersStatusBarHidden
{
    return NO; // 返回NO表示要显示，返回YES将hiden
}

- (BOOL)shouldAutorotate//当前viewcontroller是否支持转屏
{
    
   return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations//当前viewcontroller支持哪些转屏方向
{

    
    return UIInterfaceOrientationMaskAllButUpsideDown;//self.orietation;
  
   
}

-(UIInterfaceOrientation)preferredInterfaceOrientationForPresentation//当前viewcontroller默认的屏幕方向
{
    
    return UIInterfaceOrientationPortrait;//UIInterfaceOrientationPortrait;
}

//过期方法
-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return self.orietation != UIDeviceOrientationLandscapeRight;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
