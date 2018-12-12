//
//  UIDevice+BHardware.m
//  Bchart
//
//  Created by bai on 16/6/6.
//  Copyright © 2016年 bai.xianzhi. All rights reserved.
//

#import "UIDevice+BHardware.h"
#include <sys/types.h>
#include <sys/sysctl.h>

#import <sys/socket.h>
#import <sys/param.h>
#import <sys/mount.h>
#import <sys/stat.h>
#import <sys/utsname.h>
#import <net/if.h>
#import <net/if_dl.h>
#import <mach/mach.h>
#import <mach/mach_host.h>
#import <mach/processor_info.h>

@implementation UIDevice (BHardware)

+ (NSString *)b_platform{
    size_t size;
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char *machine = malloc(size);
    sysctlbyname("hw.machine", machine, &size, NULL, 0);
    NSString *platform = [NSString stringWithUTF8String:machine];
    free(machine);
    return platform;
}

+ (BDEVICE )b_platformDevice{
    NSString *platform = [self b_platform];
    
    if ([platform isEqualToString:@"iPhone1,1"])    return IPHONE_2G;
    if ([platform isEqualToString:@"iPhone1,2"])    return IPHONE_3G;
    if ([platform isEqualToString:@"iPhone2,1"])    return IPHONE_3GS;
    if ([platform isEqualToString:@"iPhone3,1"])    return IPHONE_4;
    if ([platform isEqualToString:@"iPhone3,3"])    return IPHONE_4_CDMA;
    if ([platform isEqualToString:@"iPhone4,1"])    return IPHONE_4S;
    if ([platform isEqualToString:@"iPhone5,1"])    return IPHONE_5;
    if ([platform isEqualToString:@"iPhone5,2"])    return IPHONE_5_CDMA_GSM;
    if ([platform isEqualToString:@"iPhone5,3"])    return IPHONE_5C;
    if ([platform isEqualToString:@"iPhone5,4"])    return IPHONE_5C_CDMA_GSM;
    if ([platform isEqualToString:@"iPhone6,1"])    return IPHONE_5S;
    if ([platform isEqualToString:@"iPhone6,2"])    return IPHONE_5S_CDMA_GSM;
    if ([platform isEqualToString:@"iPhone7,1"])    return IPHONE_6_PLUS;
    if ([platform isEqualToString:@"iPhone7,2"])    return IPHONE_6;
    if ([platform isEqualToString:@"iPhone8,1"])    return IPHONE_6S;
    if ([platform isEqualToString:@"iPhone8,2"])    return IPHONE_6S_PLUS;
    if ([platform isEqualToString:@"iPhone8,4"])    return IPHONE_SE;
    
    if ([platform isEqualToString:@"iPod1,1"])      return IPOD_TOUCH_1G;
    if ([platform isEqualToString:@"iPod2,1"])      return IPOD_TOUCH_2G;
    if ([platform isEqualToString:@"iPod3,1"])      return IPOD_TOUCH_3G;
    if ([platform isEqualToString:@"iPod4,1"])      return IPOD_TOUCH_4G;
    if ([platform isEqualToString:@"iPod5,1"])      return IPOD_TOUCH_5G;
    if ([platform isEqualToString:@"iPod7,1"])      return IPOD_TOUCH_6G;
    
    if ([platform isEqualToString:@"iPad1,1"])      return IPAD;
    if ([platform isEqualToString:@"iPad2,1"])      return IPAD_2_WIFI;
    if ([platform isEqualToString:@"iPad2,2"])      return IPAD_2;
    if ([platform isEqualToString:@"iPad2,3"])      return IPAD_2_CDMA;
    if ([platform isEqualToString:@"iPad2,4"])      return IPAD_2_WIFI;
    if ([platform isEqualToString:@"iPad2,5"])      return IPAD_MINI;
    if ([platform isEqualToString:@"iPad2,6"])      return IPAD_MINI;
    if ([platform isEqualToString:@"iPad2,7"])      return IPAD_MINI;
    if ([platform isEqualToString:@"iPad3,1"])      return IPAD_3_WIFI;
    if ([platform isEqualToString:@"iPad3,2"])      return IPAD_3_WIFI_CDMA;
    if ([platform isEqualToString:@"iPad3,3"])      return IPAD_3;
    if ([platform isEqualToString:@"iPad3,4"])      return IPAD_4_WIFI;
    if ([platform isEqualToString:@"iPad3,5"])      return IPAD_4;
    if ([platform isEqualToString:@"iPad3,6"])      return IPAD_4_GSM_CDMA;
    if ([platform isEqualToString:@"iPad4,1"])      return IPAD_AIR_WIFI;
    if ([platform isEqualToString:@"iPad4,2"])      return IPAD_AIR_WIFI_GSM;
    if ([platform isEqualToString:@"iPad4,3"])      return IPAD_AIR_WIFI_CDMA;
    if ([platform isEqualToString:@"iPad4,4"])      return IPAD_MINI_RETINA_WIFI;
    if ([platform isEqualToString:@"iPad4,5"])      return IPAD_MINI_RETINA_WIFI_CDMA;
    if ([platform isEqualToString:@"iPad4,6"])      return IPAD_MINI_RETINA_WIFI_CELLULAR_CN;
    if ([platform isEqualToString:@"iPad4,7"])      return IPAD_MINI_3_WIFI;
    if ([platform isEqualToString:@"iPad4,8"])      return IPAD_MINI_3_WIFI_CELLULAR;
    if ([platform isEqualToString:@"iPad4,9"])      return IPAD_MINI_3_WIFI_CELLULAR_CN;
    if ([platform isEqualToString:@"iPad5,1"])      return IPAD_MINI_4_WIFI;
    if ([platform isEqualToString:@"iPad5,2"])      return IPAD_MINI_4_WIFI_CELLULAR;
    if ([platform isEqualToString:@"iPad5,3"])      return IPAD_AIR_2_WIFI;
    if ([platform isEqualToString:@"iPad5,4"])      return IPAD_AIR_2_WIFI_CELLULAR;
    if ([platform isEqualToString:@"iPad6,3"])      return IPAD_PRO_97_WIFI;
    if ([platform isEqualToString:@"iPad6,4"])      return IPAD_PRO_97_WIFI_CELLULAR;
    if ([platform isEqualToString:@"iPad6,7"])      return IPAD_PRO_129_WIFI;
    if ([platform isEqualToString:@"iPad6,8"])      return IPAD_PRO_129_WIFI_CELLULAR;
    
    if ([platform isEqualToString:@"i386"])  {
        if ([[UIDevice currentDevice].model isEqualToString:@"iPhone"]) {
            return IPHONE_VIR;
        }else if([[UIDevice currentDevice].model isEqualToString:@"iPad"]){
            return IPAD_VIR;
        }else{
            
        }

    }
    if ([platform isEqualToString:@"x86_64"]) {
        if ([[UIDevice currentDevice].model isEqualToString:@"iPhone"]) {
            return IPHONE_VIR;
        }else if([[UIDevice currentDevice].model isEqualToString:@"iPad"]){
            return IPAD_VIR;
        }else{
            
        }

    }
    
    return NOT_AVAILABLE;
}


+(BDEVICETYPE)b_deviceType{
    switch ([self b_platformDevice]) {
            
    //虚拟机不能区分尺寸
        case IPHONE_VIR:
            return BDEVICETYPE_IPHONE;
            break;
        case IPAD_VIR:
            return BDEVICETYPE_IPAD;
            break;

    //IPHONE  3.5
        case IPHONE_2G:
        case IPHONE_3G:
        case IPHONE_3GS:
        case IPHONE_4:
        case IPHONE_4_CDMA:
        case IPHONE_4S:
            return BDEVICETYPE_IPHONE_35;
            break;
             //IPHONE  4.0
        case IPHONE_5:
        case IPHONE_5_CDMA_GSM:
        case IPHONE_5C:
        case IPHONE_5C_CDMA_GSM:
        case IPHONE_5S:
        case IPHONE_5S_CDMA_GSM:
        case IPHONE_SE:
            return BDEVICETYPE_IPHONE_40;
            break;
    //IPHONE  4.7
        case IPHONE_6S:
        case IPHONE_6:
            return BDEVICETYPE_IPHONE_47;
            break;
    //IPHONE  5.5
        case IPHONE_6S_PLUS:
        case IPHONE_6_PLUS:
            return BDEVICETYPE_IPHONE_55;
            break;
     //IPOD TOUCH  3.5
        case IPOD_TOUCH_2G:
        case IPOD_TOUCH_3G:
        case IPOD_TOUCH_4G:
        case IPOD_TOUCH_5G:
            return BDEVICETYPE_IPOD_35;
            break;
    //IPOD TOUCH 4.0
        case IPOD_TOUCH_6G:
            return BDEVICETYPE_IPOD_40;
            break;
            
    //IPAD  7.9
        case IPAD:
        case IPAD_MINI:
        case IPAD_MINI_3_WIFI:
        case IPAD_MINI_3_WIFI_CELLULAR:
        case IPAD_MINI_3_WIFI_CELLULAR_CN:
        case IPAD_MINI_4_WIFI:
        case IPAD_MINI_4_WIFI_CELLULAR:
        case IPAD_MINI_RETINA_WIFI_CELLULAR_CN:
        case IPAD_MINI_RETINA_WIFI:
        case IPAD_MINI_RETINA_WIFI_CDMA:
            return BDEVICETYPE_IPAD_79;
            break;
    //IPHONE  9.7
        case IPAD_2:
        case IPAD_2_WIFI:
        case IPAD_2_CDMA:
        case IPAD_3:
        case IPAD_3_WIFI:
        case IPAD_3_WIFI_CDMA:
        case IPAD_4:
        case IPAD_4_WIFI:
        case IPAD_4_GSM_CDMA:
        case IPAD_PRO_97_WIFI:
        case IPAD_AIR_2_WIFI:
        case IPAD_AIR_2_WIFI_CELLULAR:
            return BDEVICETYPE_IPAD_97;
            break;
    //IPHONE  12.9
        case IPAD_PRO_129_WIFI:
        case IPAD_PRO_129_WIFI_CELLULAR:
            return BDEVICETYPE_IPAD_129;
            break;
        
            
        default:
            return BDEVICETYPE_UNKNOWN;
            break;
            
    }
}

+ (NSString *)b_macAddress {
    int                 mib[6];
    size_t              len;
    char                *buf;
    unsigned char       *ptr;
    struct if_msghdr    *ifm;
    struct sockaddr_dl  *sdl;
    
    mib[0] = CTL_NET;
    mib[1] = AF_ROUTE;
    mib[2] = 0;
    mib[3] = AF_LINK;
    mib[4] = NET_RT_IFLIST;
    
    if((mib[5] = if_nametoindex("en0")) == 0) {
        printf("Error: if_nametoindex error\n");
        return NULL;
    }
    
    if(sysctl(mib, 6, NULL, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 1\n");
        return NULL;
    }
    
    if((buf = malloc(len)) == NULL) {
        printf("Could not allocate memory. Rrror!\n");
        return NULL;
    }
    
    if(sysctl(mib, 6, buf, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 2");
        return NULL;
    }
    
    ifm = (struct if_msghdr *)buf;
    sdl = (struct sockaddr_dl *)(ifm + 1);
    ptr = (unsigned char *)LLADDR(sdl);
    NSString *outstring = [NSString stringWithFormat:@"%02X:%02X:%02X:%02X:%02X:%02X",
                           *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];
    free(buf);
    
    return outstring;
}

+ (NSString *)b_systemVersion
{
    return [[UIDevice currentDevice] systemVersion];
}
+ (BOOL)b_hasCamera
{
    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
}
#pragma mark - sysctl utils

+ (NSUInteger)b_getSysInfo:(uint)typeSpecifier
{
    size_t size = sizeof(int);
    int result;
    int mib[2] = {CTL_HW, typeSpecifier};
    sysctl(mib, 2, &result, &size, NULL, 0);
    return (NSUInteger)result;
}

#pragma mark - memory information
+ (NSUInteger)b_cpuFrequency {
    return [self b_getSysInfo:HW_CPU_FREQ];
}

+ (NSUInteger)b_busFrequency {
    return [self b_getSysInfo:HW_BUS_FREQ];
}

+ (NSUInteger)b_ramSize {
    return [self b_getSysInfo:HW_MEMSIZE];
}

+ (NSUInteger)b_cpuNumber {
    return [self b_getSysInfo:HW_NCPU];
}


+ (NSUInteger)b_totalMemoryBytes
{
    return [self b_getSysInfo:HW_PHYSMEM];
}

+ (NSUInteger)b_freeMemoryBytes
{
    mach_port_t host_port = mach_host_self();
    mach_msg_type_number_t host_size = sizeof(vm_statistics_data_t) / sizeof(integer_t);
    vm_size_t pagesize;
    vm_statistics_data_t vm_stat;
    
    host_page_size(host_port, &pagesize);
    if (host_statistics(host_port, HOST_VM_INFO, (host_info_t)&vm_stat, &host_size) != KERN_SUCCESS) {
        return 0;
    }
    unsigned long mem_free = vm_stat.free_count * pagesize;
    return mem_free;
}

#pragma mark - disk information

+ (long long)b_freeDiskSpaceBytes
{
    struct statfs buf;
    long long freespace;
    freespace = 0;
    if ( statfs("/private/var", &buf) >= 0 ) {
        freespace = (long long)buf.f_bsize * buf.f_bfree;
    }
    return freespace;
}

+ (long long)b_totalDiskSpaceBytes
{
    struct statfs buf;
    long long totalspace;
    totalspace = 0;
    if ( statfs("/private/var", &buf) >= 0 ) {
        totalspace = (long long)buf.f_bsize * buf.f_blocks;
    }
    return totalspace;
}


@end
