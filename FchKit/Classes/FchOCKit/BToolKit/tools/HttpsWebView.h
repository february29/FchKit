//
//  HttpsWebView.h
//  Fch_OA
//
//  Created by bai on 16/8/12.
//  Copyright © 2016年 bai.xianzhi. All rights reserved.
//
/**
 *  设想1 利用anetworing 请求下来html字符串 然后利用webview的 loadHTMLString 方法（或者请求下来data数据 利用loadData方法加载页面）  设想不成功 webview加载html字符串的时候只能加载静态的一面其中的图片交互等功时无法实现的。
 *
 *  @param nonatomic
 *  @param retain
 *  @param readwrite
 *
 *  @return 
 */

#import <UIKit/UIKit.h>
#import <AFNetworking.h>

@interface HttpsWebView : UIWebView
@property(nonatomic,retain,readwrite)AFHTTPSessionManager *httpsManager;

//- (void)httpsLoadRequest:(NSURLRequest *)request;
//
//
////==========================================================
//
//@property(nonatomic)BOOL authenticated;
//- (void)httpsLoadRequest2:(NSURLRequest *)request;
@end
