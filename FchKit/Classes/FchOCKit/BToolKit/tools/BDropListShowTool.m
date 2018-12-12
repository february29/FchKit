//
//  BDropListShowTool.m
//  Fch_OA
//
//  Created by bai on 16/8/8.
//  Copyright © 2016年 bai.xianzhi. All rights reserved.
//

#import "BDropListShowTool.h"
#import "BAlertModal.h"
#import "BNetWorkingManager.h"

static const CGFloat MaxTableH = 300;

@interface BDropListShowTool()<UITableViewDataSource,UITableViewDelegate>{
   // UIView *contentView;

    BAlertModal *alertModal;
    
}
@end


@implementation BDropListShowTool

- (instancetype)init
{
    self = [super init];
    if (self) {
        alertModal = [BAlertModal sharedInstance];
        alertModal.backgroundColor = [UIColor clearColor];
       
        self.shuoldSelectedHide = YES;
        self.CellH = 30.0f;
        
       // contentView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
        
        //边框
        [self setBackgroundColor:[UIColor colorWithRed:250/255.0 green:235/255.0 blue:236/255.0 alpha:1]];
       // self.layer.cornerRadius = 3;
//        self.layer.borderColor = [[UIColor colorWithRed:240/255.0 green:206/255.0 blue:204/255.0 alpha:1]CGColor];
         self.layer.borderColor = [[UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1]CGColor];
        self.layer.borderWidth = 1.0f;
        
        //阴影
        
        self.layer.shadowColor = [UIColor whiteColor].CGColor;
        self.layer.shadowOffset = CGSizeMake(0, 0);
        self.layer.shadowOpacity = 1;
        self.layer.shadowRadius = 5;
        //self.layer.shadowPath = [self shadowPath].CGPath;
        
        
        _tableView = [[UITableView alloc]init];
        // tableView.frame = CGRectMake(0, TitleH, self.frame.size.width, self.frame.size.height-TitleH);
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView setBackgroundColor:[UIColor clearColor]];
        [self addSubview:_tableView];

    }
    return self;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (!_dataArray) {
        NSLog(@"plase set dataArray like this pickview.dataArray = ");
        return 0;
    }
    
    return [_dataArray count];
}




-(void)setBgColor:(UIColor *)bgColor{
    _bgColor = bgColor;
    [alertModal setBackgroundColor:bgColor];

}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //用cellConfigBlock进行配置。
    static NSString *CellIdentifier = @"BDropListShowTool";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    cell.backgroundColor=[UIColor clearColor];
    cell.textLabel.numberOfLines = 0;
    
   
    
    
    if (self.cellConfigBlock) {
        self.cellConfigBlock(cell,indexPath.row);
    }else{
       // [cell.textLabel setTextColor:[UIColor greenColor]];
        cell.textLabel.text = [_dataArray objectAtIndex:indexPath.row];
    }
    
    
    
    
    return cell;

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.CellH;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
        [self hide];
    
    
    
    if (self.chooseBlock) {
        self.chooseBlock([_dataArray objectAtIndex:indexPath.row],indexPath.row);
    }
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsMake(0, 15, 0, 15)];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsMake(0, 15, 0, 15)];
    }
}


-(void)layoutSubviews{
    [super layoutSubviews];
    if ([_tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [_tableView setSeparatorInset:UIEdgeInsetsMake(0, 15, 0, 15)];
    }
    
    if ([_tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [_tableView setLayoutMargins:UIEdgeInsetsMake(0, 15, 0, 15)];
    }

      _tableView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
}






-(void)hide{
    
    if (self.shuoldSelectedHide) {
        [alertModal hideAnimated:YES];
    }else{
        [alertModal hideAnimated:YES hideWindow:NO withCompletionBlock:nil];
    }
    
}


-(void)showDropListWithArray:(NSArray *)dataArray sender:(UIView *)sender{
    //取得相对位置
    _dataArray = dataArray;
    UIWindow * window=[[[UIApplication sharedApplication] delegate] window];
    CGRect rect=[sender convertRect: sender.bounds toView:window];
    
    
    float tableH = [dataArray count]*self.CellH;

   // float marginBottom = window.bounds.size.height - rect.origin.y-rect.size.height;
    if (tableH>MaxTableH) {
        tableH = MaxTableH;
    }
    
    self.frame = CGRectMake(rect.origin.x, rect.origin.y+rect.size.height+1, rect.size.width,tableH+1);
    
    
    
    
    
    
    [alertModal showAlerView:self disPlayStyle:BAlertModalViewDropList animated:YES];
    [_tableView reloadData];
}

-(void)showDropListWithArray:(NSArray *)dataArray sender:(UIView *)sender width:(float)width{
    //取得相对位置
    _dataArray = dataArray;
    UIWindow * window=[[[UIApplication sharedApplication] delegate] window];
    CGRect rect=[sender convertRect: sender.bounds toView:window];
    
    
    float tableH = [dataArray count]*self.CellH;
    
    // float marginBottom = window.bounds.size.height - rect.origin.y-rect.size.height;
    if (tableH>MaxTableH) {
        tableH = MaxTableH;
    }
    
    
    
    
    
    
    
    self.frame = CGRectMake(rect.origin.x-width+rect.size.width, rect.origin.y+rect.size.height+1, width,tableH+10);
    
    
    
//    TriangleArrowView *arrowView = [[TriangleArrowView alloc]initWithFrame:CGRectMake(width-(rect.size.width/2)-15/2.0, 0, 15, 10)];
//   
//    //[arrowView setBackgroundColor:[UIColor greenColor]];
//    [self addSubview:arrowView];
    
    _tableView.frame = CGRectMake(0, 10, self.frame.size.width, self.frame.size.height);
    CGRect tablefame = _tableView.frame;
    tablefame.origin.y+=7;
    _tableView.frame=tablefame;
    
    
    
    //边框
    [self setBackgroundColor:[UIColor clearColor]];
    // self.layer.cornerRadius = 3;
    self.layer.borderColor = [[UIColor clearColor]CGColor];
    self.layer.borderWidth = 1.0f;
    
    
    
    //阴影
    
    self.layer.shadowColor = [UIColor clearColor].CGColor;
    self.layer.shadowOffset = CGSizeMake(0, 0);
    self.layer.shadowOpacity = 1;
    self.layer.shadowRadius = 5;
    
    //边框
    [_tableView setBackgroundColor:[UIColor blackColor]];
    _tableView.layer.cornerRadius = 3;
    _tableView.layer.borderColor = [[UIColor clearColor]CGColor];
    _tableView.layer.borderWidth = 1.0f;
    
    
    
    
    
    
    
    [alertModal showAlerView:self disPlayStyle:BAlertModalViewDropList animated:YES];
    [_tableView reloadData];
}


@end
