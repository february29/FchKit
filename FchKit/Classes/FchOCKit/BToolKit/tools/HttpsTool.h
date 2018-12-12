//
//  HttpsTool.h
//  Fch_Location
//
//  Created by bai on 16/7/22.
//  Copyright © 2016年 bai.xianzhi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>

@interface HttpsTool : NSObject
+(instancetype)sharedInstance;
/**
 *  AFNetWorking HTTPS 请求
 */
@property(nonatomic,retain,readwrite)AFHTTPSessionManager *httpsManager;

+(void)addhttpsSecurityPolicyForAFHTTPSessionManager:(AFHTTPSessionManager *)httpsManager;

/**
 *  苹果原生API https双向请求
 *
 *  @param URLString
 *  @param parameters
 *  @param success
 *  @param failure
 *
 *  @return
 */
-(NSURLSessionDataTask *)POST:(NSString *)URLString
                   parameters:(id)parameters
                      success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                      failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;



-(NSURLSessionDataTask *)POST:(NSString *)URLString
                    parameters:(id)parameters
                      progress:(void (^)(NSProgress *uploadProgress) )uploadProgress
                       success:(void (^)(NSURLSessionDataTask *task, id responseObject ))success
                       failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;



@end
