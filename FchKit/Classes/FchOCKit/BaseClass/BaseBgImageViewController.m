//
//  BaseBgImageViewController.m
//  KT
//
//  Created by bai on 2018/9/29.
//  Copyright © 2018年 北京仙指信息技术有限公司. All rights reserved.
//

#import "BaseBgImageViewController.h"

@interface BaseBgImageViewController ()

@property (nonatomic,strong) UIImageView *bgImage;
@end

@implementation BaseBgImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.bgImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bg_dafault"]];
    self.bgImage.frame = self.view.bounds;
    [self.view addSubview:self.bgImage];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
