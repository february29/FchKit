
//  BaseViewController.m
//
//  Created by bai on 16/2/16.
//  Copyright © 2016年 bai.xianzhi. All rights reserved.


#import "BaseViewController.h"


//#import <MBProgressHUD.h>
#import "StringTool.h"






#import "ColorImageTool.h"


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
    [self.navigationController.navigationBar setBackgroundImage:[ColorImageTool createImageWithColor:[UIColor colorWithRed:23/255.0 green:148/255.0 blue:200/255.0 alpha:1]] forBarMetrics:UIBarMetricsDefault];

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
    [_leftbtn setTitleColor:TEXTGRAYCOLOR forState:0];
    [leftView addSubview:_leftbtn];
    UIBarButtonItem*back=[[UIBarButtonItem alloc]initWithCustomView:leftView];
    self.navigationItem.leftBarButtonItem=back;
    

    // 右侧的button
    UIView *rightView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 50, 44)];
   _rigthtbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _rigthtbtn.frame = CGRectMake(6, 0, 44, 44);
    [_rigthtbtn setImage:[UIImage imageNamed:@"btn_top_setting"] forState:UIControlStateNormal];
    [_rigthtbtn setTitleColor:[UIColor whiteColor] forState:0];
    [_rigthtbtn.titleLabel setFont:FONTSUPPERLARGE];
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
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(orientationChanged:)
//                                                 name:@"UIDeviceOrientationDidChangeNotification"
//                                               object:nil];
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
//     [[NSNotificationCenter defaultCenter] removeObserver:self name:@"UIDeviceOrientationDidChangeNotification" object:nil];
}

- (void)orientationChanged:(NSNotification *)notification {
   // NSLog(@"orientationChanged");
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

////ios8 隐藏状态栏
//- (BOOL)prefersStatusBarHidden
//{
//    return NO; // 返回NO表示要显示，返回YES将hiden
//}






//#pragma mark AFHTTPSessionManager
//-(AFHTTPSessionManager *)jsonsessionManager{
//    if (!_jsonsessionManager) {
//        
//        _jsonsessionManager  = [AFHTTPSessionManager manager];
//        _jsonsessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
//        _jsonsessionManager.responseSerializer.acceptableContentTypes = [_jsonsessionManager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/plain"];
//        _jsonsessionManager.requestSerializer.timeoutInterval = 10.0f;
//        
//        [_jsonsessionManager.requestSerializer setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//        
//        //_jsonsessionManager.session.configuration.timeoutIntervalForRequest = 10.0f;
//        
//    }
//    return _jsonsessionManager;
//}




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
    
    
    
//    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:title message:massage delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
//    
//    [alertView bk_setCancelBlock:^{
//        if (cancleBlock) {
//            cancleBlock();
//        }
//    }];
//    
//    [alertView bk_setHandler:^{
//        if (okBlock) {
//            okBlock();
//        }
//    } forButtonAtIndex:1];
//    [alertView show];
}







///**
// //判断app是否更新
//
// @param tag 最新版本时是否显示为最新版本
// */
//-(void)checkAppHasNewVersionWithTag:(NSInteger ) tag{
//    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleVersionKey];
//    NSString* requestURI=[[NSString alloc] initWithFormat:@"%@/%@",[SJTNetWorkingChangeHelper sharedInstance].BaseURL_1,@"app/detail/1"];
//    
////    http://223.100.6.179:30001/backend/web/cadres/user/api-user-base/app-detail
//    
//    NSDictionary *par = @{
////                          @"token":[UserInfor token],
////                          @"id":@"0"
//                          };
//    
//    
//    
//    
//    
//    [[BNetWorkingManager sharedInstance]POST:requestURI paraments:par completeBlock:^(NSDictionary * _Nullable responseObject, NSError * _Nullable error) {
//        if (responseObject) {
//            
//            
//            NSLog(@"resultDic：%@",responseObject);
////            if([[responseObject objectForKey:@"code"] intValue]  != 0){
////                BMAKETOAST([responseObject objectForKey:@"msg"]);
////                return ;
////            }
//            
//            NSDictionary *app = [responseObject objectForKey:@"app"];
//            
//            if (!app) {
//                return ;
//            }
//            //正常情况
//            
//            NSString *iosUrl = [app objectForKey:@"ios_url"];
//            if([app objectForKey:@"ios_version"]==[NSNull null]){
//                return;
//            }
//            float webVersion =[[app objectForKey:@"ios_version"]floatValue];
//            
////            NSString *new_version_info = [app objectForKey:@"new_version_info"];
//            
//            float locoalVeision = [version floatValue];
//            NSLog(@"当前版本%@ ，最新版本%f ",version,webVersion);
//            //提示更新
//            
//            if (webVersion>locoalVeision) {
//                
//                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"客户端有新版本，是否现在更新?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
//
//                [alert show];
//                [alert bk_setHandler:^{
//                    //客户端更新。。。。
//                    NSLog(@"客户端更新iosUrl %@",iosUrl);
//                    UIApplication *application = [UIApplication sharedApplication];
//                    [application openURL:[NSURL URLWithString:iosUrl]];
//                } forButtonAtIndex:1];
//            }else{
//                if (tag>0) {
//                    NSString *str =  [NSString stringWithFormat:@"当前版本%.1f，最新版本%.1f，您的客户端已是最新版本！",locoalVeision,webVersion];
//                    Alert(str);
//                }else{
//                     NSLog(@"不需要更新");
//                }
//               
//            }
//        }
//    }];
//    
//    
//}


@end
