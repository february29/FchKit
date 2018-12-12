//
//  DocTool.h
//  Rail_hrb
//
//  Created by bai on 15/8/6.
//  Copyright (c) 2015年 bai.xianzhi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DocTool : NSObject


+(NSString *)docPath;


/**
 创建文件路径

 @param path 文件路径
 */
+(void)createPath:(NSString*)path;


/**
 计算单个文件大小

 @param filePath 文件路径

 @return 文件大小  以字节为单位
 */
+ (float)fileSizeAtPath:(NSString*) filePath;



/**
 计算目录大小

 @param path path路径

 @return 计算目录大小 以字节为单位
 */
+(float)folderSizeAtPath:(NSString *)path;

/**
 缓存大小

 @return 缓存大小
 */
+(float)cacheSize;


/**
 清除缓存

 @param successBlock 清除成功后block
 */
+(void)clearCacheWithSuccessBlock:(void(^)())successBlock;



/**
 删除文件

 @param _path 文件路径

 @return 是否成功
 */
+ (BOOL)deleteFileAtPath:(NSString*)_path;

/**
 判断文件是否存在

 @param _path 文件完整路径

 @return 是否存在
 */
+ (BOOL)fileExistsAtPath:(NSString*)_path;

/**
 检查文件是否存在
 
 @param filePath 文件所在目录
 @param fileName 文件名称
 
 @return 是否存在
 */
+(BOOL)checkFileExsiteAtPath:(NSString *)filePath fileName:(NSString*)fileName;


/**
 获取路径下的所有文件  递归调用子文件夹

 @param path 文件路径

 @return 所有文件
 */
+(NSArray*)filesAtPath:(NSString *)path;


/**
 获取路径下的所有文件 不递归调用

 @param path 文件路径

 @return 所有子文件
 */
+(NSArray *)contentsOfDirectoryAtPath:(NSString *)path;




@end
