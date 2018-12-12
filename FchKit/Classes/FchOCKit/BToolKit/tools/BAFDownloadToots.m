//
//  BAFDownloadToots.m
//  Fch_OA
//
//  Created by bai on 2016/12/6.
//  Copyright © 2016年 bai.xianzhi. All rights reserved.
//

#import "BAFDownloadToots.h"
#import <AFNetworking.h>
@implementation BAFDownloadToots


+(void)checkNetWrokStatusWithWIFIBlock:(void(^)())wifiBlock WWANBlock:(void(^)())wwanBlock UnknownBlock:(void(^)())unknownBlock NotReachableBlock:(void(^)()) notReachBlock{
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager manager];
    
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusNotReachable: {
                //                [weakSelf loadMessage:@"网络不可用"];
                NSLog(@"网络不可用");
                if (notReachBlock) {
                    notReachBlock();
                }
                break;
            }
                
            case AFNetworkReachabilityStatusReachableViaWiFi: {
                //                [weakSelf loadMessage:@"Wifi已开启"];
                NSLog(@"Wifi已开启");
                if (wifiBlock) {
                    wifiBlock();
                }
                break;
            }
                
            case AFNetworkReachabilityStatusReachableViaWWAN: {
                //                [weakSelf loadMessage:@"你现在使用的流量"];
                NSLog(@"你现在使用的流量");
                if (wwanBlock) {
                    wwanBlock();
                }
                break;
            }
                
            case AFNetworkReachabilityStatusUnknown: {
                //                [weakSelf loadMessage:@"你现在使用的未知网络"];
                NSLog(@"你现在使用的未知网络");
                if (unknownBlock) {
                    unknownBlock();
                }
                break;
            }
                
            default:
                break;
        }
    }];
    [manager startMonitoring];
}


-(void)downLoadFileFromNetUrl:(NSString *)url toDri:(NSString*)path{
    
}

@end
