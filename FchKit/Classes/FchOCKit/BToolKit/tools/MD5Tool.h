//
//  MD5Tool.h
//  Rail_hrb
//
//  Created by bai on 15/10/12.
//  Copyright © 2015年 bai.xianzhi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MD5Tool : NSObject
+(NSString*) md5:(NSString*) str;
+(NSString *)file_md5:(NSString*) path;
+(NSString *)md5HexDigest:(NSString*)password;
@end
