//
//  DocTool.m
//  Rail_hrb
//
//  Created by bai on 15/8/6.
//  Copyright (c) 2015年 bai.xianzhi. All rights reserved.
//

#import "DocTool.h"

@implementation DocTool
+(NSString *)docPath{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return documentsDirectory;
}




+(void)createPath:(NSString*)path{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDir = NO;
    BOOL existed = [fileManager fileExistsAtPath:path isDirectory:&isDir];
    if ( !(isDir == YES && existed == YES) )
    {
        [fileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    }
}

+(BOOL)checkFileExsiteAtPath:(NSString *)filePath fileName:(NSString*)fileName{
    NSFileManager *filleManger = [NSFileManager new];
    NSString *pathandname =[NSString stringWithFormat:@"%@/%@",filePath,fileName];
    if ([filleManger fileExistsAtPath:pathandname]) {
        
        return YES;
    }
    return NO;
}

+(NSArray*)filesAtPath:(NSString *)path{
    NSFileManager *filleManger = [NSFileManager defaultManager];
    return [filleManger subpathsAtPath:path];
}


+(NSArray *)contentsOfDirectoryAtPath:(NSString *)path{
   
    NSFileManager *filleManger = [NSFileManager defaultManager];
    NSArray *files =   [filleManger contentsOfDirectoryAtPath:path error:nil];
    NSMutableArray *mutFiles= [[NSMutableArray alloc]initWithArray:files];
   
        return mutFiles;
}


+ (float) fileSizeAtPath:(NSString*) filePath{
    
    
    NSFileManager* manager = [NSFileManager defaultManager];
    
    if ([manager fileExistsAtPath:filePath]){
        
        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
    }
    return 0;
    
}

+(float)folderSizeAtPath:(NSString *)path
{
    NSFileManager *fileManager=[NSFileManager defaultManager];
    float folderSize;
    if ([fileManager fileExistsAtPath:path])
    {
        NSArray *childerFiles=[fileManager subpathsAtPath:path];
        for (NSString *fileName in childerFiles)
        {
            NSString *absolutePath=[path stringByAppendingPathComponent:fileName];
            folderSize += [self fileSizeAtPath:absolutePath];
        }
        
        return folderSize;
    }
    return 0;
}

+(float)cacheSize{
    float cacheSize = 0;
    NSString *cachPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSArray *files = [[NSFileManager defaultManager] subpathsAtPath:cachPath];
    for (NSString *f in files)
    {
        NSString *path = [cachPath stringByAppendingPathComponent:f];
        cacheSize += [self fileSizeAtPath:path];
        NSLog(@"chcheSize:%.1f",cacheSize);
    }
  
    
    return self.cacheSize;
}


+(void)clearCacheWithSuccessBlock:(void (^)())successBlock{
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString *cachPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        NSLog(@"cachPath===%@",cachPath);
        NSArray *files = [[NSFileManager defaultManager] subpathsAtPath:cachPath];
        NSLog(@"files :%lu",(unsigned long)[files count]);
        NSLog(@"file === %@",files);
        for (NSString *p in files)
        {
            NSError *error;
            NSString *path = [cachPath stringByAppendingPathComponent:p];
            if ([[NSFileManager defaultManager] fileExistsAtPath:path])
            {
                [[NSFileManager defaultManager] removeItemAtPath:path error:&error];
            }
        }

        dispatch_async(dispatch_get_main_queue(), ^{
            if (successBlock) {
                successBlock();
            }
        });
    });

    
    
}



+ (BOOL)deleteFileAtPath:(NSString*)_path{
    return [[NSFileManager defaultManager] removeItemAtPath:_path error:nil];
}


+ (BOOL)fileExistsAtPath:(NSString*)_path{
    return [[NSFileManager defaultManager] fileExistsAtPath:_path];
}



//--------------------------------以下方法不常用--------------------------------------
+ (NSString *)homePath{
    return NSHomeDirectory();
}

+(NSString *)appPath{
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSApplicationDirectory, NSUserDomainMask, YES);
    return [paths objectAtIndex:0];
}


+(NSString *)libPrefPath{
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    return [[paths objectAtIndex:0] stringByAppendingFormat:@"/Preference"];
}

+(NSString *)libCachePath{
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    return [[paths objectAtIndex:0] stringByAppendingFormat:@"/Caches"];
}

+(NSString *)tmpPath{
    return [NSHomeDirectory() stringByAppendingFormat:@"/tmp"];
    
}


@end
