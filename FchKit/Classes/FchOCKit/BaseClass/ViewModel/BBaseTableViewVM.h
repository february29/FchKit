//
//  BListViewModel.h
//  Lou_s
//
//  Created by bai on 2017/10/11.
//  Copyright © 2017年 北京仙指信息技术有限公司. All rights reserved.
//

#import "BBaseViewModel.h"
#import "BaseDefine.h"
#import "BNetWorkingManager.h"
#import <MJExtension.h>

@protocol BBaseViewModelDelegate <NSObject>

typedef void(^CompletionHandle)( id responseObject,NSError *error);

@optional
//获取更多
- (void)getMoreDataCompletionHandle:(CompletionHandle)completionHandle;
//刷新
- (void)refreshDataCompletionHandle:(CompletionHandle)completionHandle;
//获取全部数据 无分页功能时
- (void)getDataFromNetCompleteHandle:(CompletionHandle)completionHandle;



@end



@interface BBaseTableViewVM: BBaseViewModel<BBaseViewModelDelegate>
//表格数据
@property (nonatomic,strong) NSMutableArray *dataArray;

@end
