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


@interface BNetWorkingManager(){
    
}

@end


@implementation BNetWorkingManager



+ (BNetWorkingManager*)sharedInstance{
    static BNetWorkingManager *sharedInstance;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        sharedInstance = [[[self class] alloc] init];
    });
    return sharedInstance;
}

- (AFHTTPSessionManager *)jsonsessionManager{
    if (!_jsonsessionManager) {
        _jsonsessionManager  = [AFHTTPSessionManager manager];
        _jsonsessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
        _jsonsessionManager.responseSerializer.acceptableContentTypes = [_jsonsessionManager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/plain"];
        _jsonsessionManager.requestSerializer.timeoutInterval = 15.0f;
        
        [_jsonsessionManager.requestSerializer setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    }
    return _jsonsessionManager;
}
-(AFHTTPSessionManager *)downloadManager{
    if (!_downloadManager) {
        _downloadManager = [AFHTTPSessionManager manager];
    }
    return _downloadManager;
}


- (instancetype)init
{
    self = [super init];
    if (self) {
        
        
    }
    return self;
}


-(void)setBaseURL:(NSString *)baseURL{
    _baseURL = baseURL;
}



-(nullable NSURLSessionDataTask *)GET:(nonnull NSString *)urlString
                            paraments:(nullable id)paraments
                        completeBlock:(nullable completeBlock)completeBlock{
    
    if (self.baseURL) {
        urlString = [NSString stringWithFormat:@"%@/%@",self.baseURL,urlString];
    }
    
    NSLog(@"***>>NetWorking urlString<<**\n%@",urlString);
    NSLog(@"***>>NetWorking paraments<<**\n%@",paraments);
    
    return [self.jsonsessionManager GET:urlString parameters:paraments progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
       
        NSDictionary *dict = responseObject;
        if ([responseObject isKindOfClass:[NSData class]]){
            dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        }
        NSLog(@"***>>NetWorking responseObject->responseDic<<**\n%@",dict);
        completeBlock(dict,nil);

        
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
    
    if (self.baseURL) {
        urlString = [NSString stringWithFormat:@"%@/%@",self.baseURL,urlString];
    }
    
    NSLog(@"***>>NetWorking urlString<<**\n%@",urlString);
    NSLog(@"***>>NetWorking paraments<<**\n%@",paraments);
    return [self.jsonsessionManager POST:urlString parameters:paraments progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dict = responseObject;
        if ([responseObject isKindOfClass:[NSData class]]){
            dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        }
        NSLog(@"***>>NetWorking responseObject->responseDic<<**\n%@",dict);
        completeBlock(dict,nil);

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        int statusCode =  (int)((NSHTTPURLResponse *)task.response).statusCode;
        NSLog(@"***>>NetWorking failure<<**\n%d",statusCode);
        
        completeBlock(nil,error);
        if (statusCode == 403) {
            
            
            [self handel403Error];
            
            
            
        }
        
        

    }];
    
}


- (nullable NSURLSessionDataTask *)POST:(NSString *_Nullable)urlString
                             parameters:(nullable id)parameters
              constructingBodyWithBlock:(nullable void (^)(id <AFMultipartFormData> formData))block
                               progress:(nullable void (^)(NSProgress * _Nullable uploadProgress)) uploadProgress
                          completeBlock:(nullable completeBlock)completeBlock{
    
    if (self.baseURL) {
        urlString = [NSString stringWithFormat:@"%@/%@",self.baseURL,urlString];
    }
    
    return [self.jsonsessionManager POST:urlString parameters:parameters constructingBodyWithBlock:block progress:uploadProgress success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dict = responseObject;
        if ([responseObject isKindOfClass:[NSData class]]){
            dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        }
        NSLog(@"***>>NetWorking responseObject->responseDic<<**\n%@",dict);
        completeBlock(dict,nil);

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
    
    
    if (self.baseURL) {
        downloadURL = [NSString stringWithFormat:@"%@/%@",self.baseURL,downloadURL];
    }
    
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString: downloadURL]];
    
    NSURLSessionDownloadTask *downloadTask = [self.downloadManager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {//进度
        
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

    
    UIViewController * currentVC = [self getCurrentViewController];
    if (currentVC ) {
        UIAlertController *alerter = [UIAlertController alertControllerWithTitle:@"提示" message:@"您的账户已在其他设备登录，请重新登录" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"登录" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            if (currentVC && currentVC.navigationController) {
                [currentVC.navigationController  popToRootViewControllerAnimated:YES];
            }
            
            
        }];
        [alerter addAction:cancleAction];
        [alerter addAction:okAction];
        
        [currentVC presentViewController:alerter animated:YES completion:nil];
    }else{
        
    }

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
