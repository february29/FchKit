//
//  BNetWorkingManager.h
//  Lou_s
//
//  Created by bai on 2017/6/8.
//  Copyright © 2017年 北京仙指信息技术有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking/AFNetworking.h"

//#import <AFURLRequestSerialization.h>


typedef void(^completeBlock)( id _Nullable responseObject,NSError * _Nullable error);

@interface BNetWorkingManager : NSObject

+ (instancetype _Nullable )sharedInstance;



/**
 baseURL 其他网络请求时都拼接该字段
 这里只负责记录 使用时获取手动拼接
 */
@property (nonatomic,strong)  NSString *baseURL;


/**
 备用的baseURL 当一个baseURL无法满足时使用
 这里只负责记录 使用时获取手动拼接
 */
@property (nonatomic,strong)  NSString *baseURL2;


/**
 备用字段 用于记录其他需要记录的信息
 
 */
@property(nonatomic,strong)NSMutableDictionary *reseverDictionnary;


/**
 网络请求的manager
 */
@property(nonatomic,retain,readwrite)AFHTTPSessionManager * _Nullable jsonsessionManager;


/**
 文件下载的manager
 */
@property(nonatomic,retain,readwrite)AFHTTPSessionManager * _Nullable downloadManager;




-(nullable NSURLSessionDataTask *)GET:(nonnull NSString *)urlString
                             paraments:(nullable id)paraments
                         completeBlock:(nullable completeBlock)completeBlock;

-(nullable NSURLSessionDataTask *)POST:(nonnull NSString *)urlString
                              paraments:(nullable id)paraments
                          completeBlock:(nullable completeBlock)completeBlock;

- (nullable NSURLSessionDataTask *)POST:(NSString *_Nullable)urlString
                             parameters:(nullable id)parameters
              constructingBodyWithBlock:(nullable void (^)(id <AFMultipartFormData> formData))block
                               progress:(nullable void (^)(NSProgress * _Nullable uploadProgress)) uploadProgress
                               completeBlock:(nullable completeBlock)completeBlock;



/**
 *  下载文件
 *
 *  @param downloadURL  下载链接
 *  @param success 请求结果
 *  @param completeBlock 错误信息
 */
-(void)downloadURL:(NSString *) downloadURL progress:(void (^)(NSProgress *downloadProgress))progress destination:(NSURL * (^)(NSURL *targetPath, NSURLResponse *response))destination completeBlock:(void(^)(NSURLResponse * _Nonnull response, NSURL * _Nonnull filePath, NSError * _Nonnull error))completeBlock;
@end
