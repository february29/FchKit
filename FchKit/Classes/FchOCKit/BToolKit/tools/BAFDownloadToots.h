//
//  BAFDownloadToots.h
//  Fch_OA
//
//  Created by bai on 2016/12/6.
//  Copyright © 2016年 bai.xianzhi. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface BAFDownloadToots : NSObject

+(void)checkNetWrokStatusWithWIFIBlock:(void(^)())wifiBlock WWANBlock:(void(^)())wwanBlock UnknownBlock:(void(^)())unknownBlock NotReachableBlock:(void(^)()) notReachBlock;

@end
