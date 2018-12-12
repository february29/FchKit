//
//  BaseTableViewController.h
//  KT
//
//  Created by bai on 2018/10/23.
//  Copyright © 2018年 北京仙指信息技术有限公司. All rights reserved.
//

#import "BaseViewController.h"
#import "BaseTableView.h"

NS_ASSUME_NONNULL_BEGIN

@interface BaseTableViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) BaseTableView *mTableView;

@end

NS_ASSUME_NONNULL_END
