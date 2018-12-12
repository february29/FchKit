//
//  UIDevice+BHardware.h
//  Bchart
//
//  Created by bai on 16/6/6.
//  Copyright © 2016年 bai.xianzhi. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger,BDEVICETYPE) {
    
    BDEVICETYPE_UNKNOWN,
    BDEVICETYPE_IPHONE,
    BDEVICETYPE_IPHONE_35,
    BDEVICETYPE_IPHONE_40,
    BDEVICETYPE_IPHONE_47,
    BDEVICETYPE_IPHONE_55,
    
    BDEVICETYPE_IPOD_35,
    BDEVICETYPE_IPOD_40,
    
    
    
    BDEVICETYPE_IPAD,
    BDEVICETYPE_IPAD_79,
    BDEVICETYPE_IPAD_97,
    BDEVICETYPE_IPAD_129
    
};


typedef NS_ENUM(NSUInteger, BDEVICE) {
    NOT_AVAILABLE,
    
    IPAD_VIR,
    IPHONE_VIR,
    
    IPHONE_2G,
    IPHONE_3G,
    IPHONE_3GS,
    
    IPHONE_4,
    IPHONE_4_CDMA,
    IPHONE_4S,
    
    IPHONE_5,
    IPHONE_5_CDMA_GSM,
    IPHONE_5C,
    IPHONE_5C_CDMA_GSM,
    IPHONE_5S,
    IPHONE_5S_CDMA_GSM,
    
    IPHONE_6,
    IPHONE_6_PLUS,
    IPHONE_6S,
    IPHONE_6S_PLUS,
    IPHONE_SE,
    
    IPOD_TOUCH_1G,
    IPOD_TOUCH_2G,
    IPOD_TOUCH_3G,
    IPOD_TOUCH_4G,
    IPOD_TOUCH_5G,
    IPOD_TOUCH_6G,
    
    IPAD,
    IPAD_2,
    IPAD_2_WIFI,
    IPAD_2_CDMA,
    IPAD_3,
    IPAD_3G,
    IPAD_3_WIFI,
    IPAD_3_WIFI_CDMA,
    IPAD_4,
    IPAD_4_WIFI,
    IPAD_4_GSM_CDMA,
    
    IPAD_MINI,
    IPAD_MINI_WIFI,
    IPAD_MINI_WIFI_CDMA,
    IPAD_MINI_RETINA_WIFI,
    IPAD_MINI_RETINA_WIFI_CDMA,
    IPAD_MINI_3_WIFI,
    IPAD_MINI_3_WIFI_CELLULAR,
    IPAD_MINI_3_WIFI_CELLULAR_CN,
    IPAD_MINI_4_WIFI,
    IPAD_MINI_4_WIFI_CELLULAR,
    
    IPAD_MINI_RETINA_WIFI_CELLULAR_CN,
    
    IPAD_AIR_WIFI,
    IPAD_AIR_WIFI_GSM,
    IPAD_AIR_WIFI_CDMA,
    IPAD_AIR_2_WIFI,
    IPAD_AIR_2_WIFI_CELLULAR,
    
    IPAD_PRO_97_WIFI,
    IPAD_PRO_97_WIFI_CELLULAR,
    
    IPAD_PRO_129_WIFI,
    IPAD_PRO_129_WIFI_CELLULAR,
    
    SIMULATOR,
    
    HARDWARE_MAX
};


@interface UIDevice (BHardware)
+ (NSString *)b_platform;
+ (BDEVICE)b_platformDevice;
+(BDEVICETYPE)b_deviceType;

+ (NSString *)b_macAddress;

//Return the current device CPU frequency
+ (NSUInteger)b_cpuFrequency;
// Return the current device BUS frequency
+ (NSUInteger)b_busFrequency;
//current device RAM size
+ (NSUInteger)b_ramSize;
//Return the current device CPU number
+ (NSUInteger)b_cpuNumber;
//Return the current device total memory

/// 获取iOS系统的版本号
+ (NSString *)b_systemVersion;
/// 判断当前系统是否有摄像头
+ (BOOL)b_hasCamera;
/// 获取手机内存总量, 返回的是字节数
+ (NSUInteger)b_totalMemoryBytes;
/// 获取手机可用内存, 返回的是字节数
+ (NSUInteger)b_freeMemoryBytes;

/// 获取手机硬盘空闲空间, 返回的是字节数
+ (long long)b_freeDiskSpaceBytes;
/// 获取手机硬盘总空间, 返回的是字节数
+ (long long)b_totalDiskSpaceBytes;
@end
