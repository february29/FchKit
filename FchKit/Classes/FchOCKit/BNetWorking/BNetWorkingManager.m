//
//  BNetWorkingManager.m
//  Lou_s
//
//  Created by bai on 2017/6/8.
//  Copyright © 2017年 北京仙指信息技术有限公司. All rights reserved.
//

#import "BNetWorkingManager.h"
//#import "LuosLoginViewController.h"
//#import "LuosPromptView.h"
#import <BAlertModal.h>

@implementation BNetWorkingManager



+ (BNetWorkingManager*)sharedInstance{
    static BNetWorkingManager *sharedInstance;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        sharedInstance = [[[self class] alloc] init];
    });
    return sharedInstance;
}


- (instancetype)init
{
    self = [super init];
    if (self) {
        //初始化网络请求
        _jsonsessionManager  = [AFHTTPSessionManager manager];
        _jsonsessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
        _jsonsessionManager.responseSerializer.acceptableContentTypes = [_jsonsessionManager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/plain"];
        _jsonsessionManager.requestSerializer.timeoutInterval = 15.0f;
        
        [_jsonsessionManager.requestSerializer setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    }
    return self;
}


-(nullable NSURLSessionDataTask *)GET:(nonnull NSString *)urlString
                            paraments:(nullable id)paraments
                        completeBlock:(nullable completeBlock)completeBlock{
    
    NSLog(@"***>>NetWorking urlString<<**\n%@",urlString);
    NSLog(@"***>>NetWorking paraments<<**\n%@",paraments);
    
    return [_jsonsessionManager GET:urlString parameters:paraments progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSLog(@"***>>NetWorking responseObject:<<**\n%@",responseObject);
            completeBlock(responseObject,nil);
        }else if ([responseObject isKindOfClass:[NSData class]]){
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
            NSLog(@"***>>NetWorking responseObject->responseDic<<**\n%@",dict);
            completeBlock(dict,nil);
        }else{
            NSLog(@"***>>NetWorking responseObject<<**\n%@",responseObject);
            completeBlock(responseObject,nil);
        }
        
       
       
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        int statusCode =  (int)((NSHTTPURLResponse *)task.response).statusCode;
        NSLog(@"***>>NetWorking failure<<**\n%d",statusCode);
        
        completeBlock(nil,error);
        if (statusCode == 403) {
            
            [self handel403Error];
            
        }
       
        
        
    }];
}

-(nullable NSURLSessionDataTask *)POST:(nonnull NSString *)urlString
                             paraments:(nullable id)paraments
                         completeBlock:(nullable completeBlock)completeBlock{
    
    NSLog(@"***>>NetWorking urlString<<**\n%@",urlString);
    NSLog(@"***>>NetWorking paraments<<**\n%@",paraments);
    return [_jsonsessionManager POST:urlString parameters:paraments progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSLog(@"***>>NetWorking responseObject:<<**\n%@",responseObject);
            completeBlock(responseObject,nil);
        }else if ([responseObject isKindOfClass:[NSData class]]){
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
            NSLog(@"***>>NetWorking responseObject->responseDic<<**\n%@",dict);
            completeBlock(dict,nil);
        }else{
            NSLog(@"***>>NetWorking responseObject<<**\n%@",responseObject);
            completeBlock(responseObject,nil);
        }

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        int statusCode =  (int)((NSHTTPURLResponse *)task.response).statusCode;
        NSLog(@"***>>NetWorking failure<<**\n%d",statusCode);
        
        completeBlock(nil,error);
        if (statusCode == 403) {
            
            
            [self handel403Error];
            
            
            
        }
        
        

    }];
    
}


- (nullable NSURLSessionDataTask *)POST:(NSString *_Nullable)URLString
                             parameters:(nullable id)parameters
              constructingBodyWithBlock:(nullable void (^)(id <AFMultipartFormData> formData))block
                               progress:(nullable void (^)(NSProgress * _Nullable uploadProgress)) uploadProgress
                          completeBlock:(nullable completeBlock)completeBlock{
    return [_jsonsessionManager POST:URLString parameters:parameters constructingBodyWithBlock:block progress:uploadProgress success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSLog(@"***>>NetWorking responseObject:<<**\n%@",responseObject);
            completeBlock(responseObject,nil);
        }else if ([responseObject isKindOfClass:[NSData class]]){
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
            NSLog(@"***>>NetWorking responseObject->responseDic<<**\n%@",dict);
            completeBlock(dict,nil);
        }else{
            NSLog(@"***>>NetWorking responseObject<<**\n%@",responseObject);
            completeBlock(responseObject,nil);
        }

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        int statusCode =  (int)((NSHTTPURLResponse *)task.response).statusCode;
        NSLog(@"***>>NetWorking failure<<**\n%d",statusCode);
        
        completeBlock(nil,error);
    }];
}



/**
 *  下载文件
 *
 *  @param downloadURL  下载链接
 *  @param completeBlock 错误信息
 */
-(void)downloadURL:(NSString *) downloadURL progress:(void (^)(NSProgress *downloadProgress))progress destination:(NSURL * (^)(NSURL *targetPath, NSURLResponse *response))destination completeBlock:(void(^)(NSURLResponse * _Nonnull response, NSURL * _Nonnull filePath, NSError * _Nonnull error))completeBlock{
    
    
    //1.创建管理者
    AFHTTPSessionManager *manage  = [AFHTTPSessionManager manager];
    
    //2.下载文件
    /*
     第一个参数：请求对象
     第二个参数：下载进度
     第三个参数：block回调，需要返回一个url地址，用来告诉AFN下载文件的目标地址
     targetPath：AFN内部下载文件存储的地址，tmp文件夹下
     response：请求的响应头
     返回值：文件应该剪切到什么地方
     第四个参数：block回调，当文件下载完成之后调用
     response：响应头
     filePath：文件存储在沙盒的地址 == 第三个参数中block的返回值
     error：错误信息
     */
    
    //2.1 创建请求对象
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString: downloadURL]];
    
    NSURLSessionDownloadTask *downloadTask = [manage downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {//进度
        
        if (downloadProgress) {
            progress(downloadProgress);
        }
        
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        
//        NSString *caches = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
//        //拼接文件全路径
//        NSString *fullpath = [caches stringByAppendingPathComponent:response.suggestedFilename];
//        NSURL *filePathUrl = [NSURL fileURLWithPath:fullpath];
        
        return destination(targetPath,response);
        
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nonnull filePath, NSError * _Nonnull error) {
        
        
        if (completeBlock) {
            completeBlock(response,filePath,error);
        }
    }];
    
    //3.启动任务
    [downloadTask resume];
}

-(void)handel403Error{
//    LuosPromptView *tsView = [[LuosPromptView alloc]initWithFrame:CGRectMake(0, 0, MSCW*0.8, 210) promptImage:nil okClickBlock:^{
//        [[BAlertModal sharedInstance]hideWithCompletionBlock:^{
//            LuosLoginViewController *VC = [LuosLoginViewController new];
//            [[self getCurrentViewController].navigationController pushViewController:VC animated:YES];
//        }];
//
//    } cancleClickBlock:^{
//        [[BAlertModal sharedInstance]hideWithCompletionBlock:^{
//
//        }];
//
//    }];
//    tsView.backgroundColor = [UIColor whiteColor];
//    tsView.layer.cornerRadius = 5;
//    tsView.titleLable.text = @"提示";
//    tsView.infoLable.text = @"您的账户已在其他设备登录，请重新登录";
//    tsView.infoLable.textAlignment = NSTextAlignmentCenter;
//    [tsView.okBtn setTitle:@"去登录" forState:0];
//    [tsView.cancleBtn setTitle:@"取消" forState:0];
//    [[BAlertModal sharedInstance]showAlerView:tsView];
    
    
    
    
    
    UIAlertController *alerter = [UIAlertController alertControllerWithTitle:@"提示" message:@"您的账户已在其他设备登录，请重新登录" preferredStyle:UIAlertControllerStyleAlert];

    UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {

    }];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"登录" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        LuosLoginViewController *VC = [LuosLoginViewController new];
//        [[self getCurrentViewController].navigationController pushViewController:VC animated:YES];
        [[self getCurrentViewController].navigationController  popToRootViewControllerAnimated:YES];

    }];
    [alerter addAction:cancleAction];
    [alerter addAction:okAction];

    [[self getCurrentViewController] presentViewController:alerter animated:YES completion:nil];
    
}



-(UIViewController *)getCurrentViewController
{
    UIViewController *result = nil;
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    //app默认windowLevel是UIWindowLevelNormal，如果不是，找到UIWindowLevelNormal的
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    id  nextResponder = nil;
    UIViewController *appRootVC=window.rootViewController;
    //    如果是present上来的appRootVC.presentedViewController 不为nil
    if (appRootVC.presentedViewController) {
        nextResponder = appRootVC.presentedViewController;
    }else{
        
        
        UIView *frontView = [[window subviews] objectAtIndex:0];
        nextResponder = [frontView nextResponder];
    }
    
    if ([nextResponder isKindOfClass:[UITabBarController class]]){
        UITabBarController * tabbar = (UITabBarController *)nextResponder;
        UINavigationController * nav = (UINavigationController *)tabbar.viewControllers[tabbar.selectedIndex];
        //        UINavigationController * nav = tabbar.selectedViewController ; 上下两种写法都行
        result=nav.childViewControllers.lastObject;
        
    }else if ([nextResponder isKindOfClass:[UINavigationController class]]){
        UIViewController * nav = (UIViewController *)nextResponder;
        result = nav.childViewControllers.lastObject;
    }else{
        result = nextResponder;
    }
    return result;
}


@end
