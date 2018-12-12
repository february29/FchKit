//
//  BaseTableViewController.m
//  KT
//
//  Created by bai on 2018/10/23.
//  Copyright © 2018年 北京仙指信息技术有限公司. All rights reserved.
//

#import "BaseTableViewController.h"

@interface BaseTableViewController ()

@end

@implementation BaseTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}


-(BaseTableView *)mTableView{
    
    if (!_mTableView) {
        _mTableView = [[BaseTableView alloc]initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStyleGrouped];
        _mTableView.separatorColor = [UIColor clearColor];
        _mTableView.delegate = self;
        _mTableView.dataSource = self;
        _mTableView.rowHeight  = UITableViewAutomaticDimension;
        _mTableView.estimatedRowHeight = 44;
        _mTableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 10)];
        
        _mTableView.showsHorizontalScrollIndicator  = NO;
        _mTableView.showsVerticalScrollIndicator = NO;
        
    }
    
    return _mTableView;
    
    
}


@end
