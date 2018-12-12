//
//  BDropListShowTool.h
//  Fch_OA
//
//  Created by bai on 16/8/8.
//  Copyright © 2016年 bai.xianzhi. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void (^BDropListChooseBlock)( id selectData ,int postion);
typedef void(^BDropListCellConfigBlock)(id cell , int postion);


@interface BDropListShowTool : UIView <UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,retain,readwrite)UITableView *tableView;
@property(nonatomic,strong)NSArray * dataArray;
@property(nonatomic,readwrite) CGFloat CellH;

@property(nonatomic,retain,readwrite)UIColor *bgColor;


//@property(nonatomic,weak) id<BPickerDelegate> delegate;
@property(nonatomic,copy)BDropListChooseBlock chooseBlock;
@property(nonatomic,copy)BDropListCellConfigBlock cellConfigBlock;

@property(nonatomic,readwrite)BOOL shuoldSelectedHide;

-(void)showDropListWithArray:(NSArray *)dataArray sender:(UIView *)sender;

-(void)showDropListWithArray:(NSArray *)dataArray sender:(UIView *)sender width:(float)width;


-(void)hide;
@end
