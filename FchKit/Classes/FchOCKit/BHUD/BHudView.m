//
//  LuosHudView.m
//  Lou_s
//
//  Created by bai on 2017/5/26.
//  Copyright © 2017年 北京仙指信息技术有限公司. All rights reserved.
//

#import "BHudView.h"


#import "BHudContentView.h"
@interface BHudView(){

    
}
@end


@implementation BHudView









+(void)showHudInView:(UIView *_Nullable)supperView{
    
    [self showHudInView:supperView indicatorViewStyle:BHudCircleLoadingIndicatorView];
    
}



+(void)showIndicatorInView:(UIView *_Nullable)supperView{
    
    [self showIndicatorInView:supperView indicatorViewStyle:BHudCircleLoadingIndicatorView];
}


+(void)showHudInView:(UIView *_Nullable)supperView indicatorViewStyle:(BHudIndicatorViewStyle )indicatorViewStyle{

    [self showInView:supperView indicatorViewStyle:indicatorViewStyle hudType:BLoadingAndIndicatorHud];
    
    
}

+(void)showIndicatorInView:(UIView *_Nullable)supperView indicatorViewStyle:(BHudIndicatorViewStyle )indicatorViewStyle{
    
    [self showInView:supperView indicatorViewStyle:indicatorViewStyle hudType:BIndicatorHud];
}


+(void)showInView:(UIView *_Nullable)supperView indicatorViewStyle:(BHudIndicatorViewStyle )indicatorViewStyle hudType:(BHudContentViewType)hudType{
    
    
    [self showInView:supperView indicatorViewStyle:indicatorViewStyle hudType:hudType indicatorProportion:0.4];
    
}


+(void)showInView:(UIView *_Nullable)supperView indicatorViewStyle:(BHudIndicatorViewStyle )indicatorViewStyle hudType:(BHudContentViewType)hudType indicatorProportion:(float)indicatorProportion{
    
    BHudContentView *contentView = [[BHudContentView alloc]initWithFrame:supperView.frame];
    contentView.indicatorViewStyle = indicatorViewStyle;
    contentView.hudType = hudType;
    contentView.indicatorProportion = indicatorProportion;
    
    [supperView addSubview:contentView];
}



+(void)showErrorInView:(UIView *_Nullable)supperView clickBlock:(LuosFailBtnClickBlock _Nullable )clickBlock{
    
    [self hideHudInView:supperView];
    
    BHudContentView *contentView = [[BHudContentView alloc]initWithFrame:supperView.bounds];
    [contentView setBackgroundColor:[UIColor whiteColor]];
    contentView.hudType = BErrorHud;
    contentView.alpha = 0;
    contentView.faildBtnBlock = clickBlock;
    
    
    [supperView addSubview:contentView];
    
    [UIView animateWithDuration:0.25 animations:^{
        contentView.alpha = 1;
    }];

}




+(void)hideHudInView:(UIView *_Nullable)supperView{
    
    for (UIView *view in [supperView subviews]) {
        if ([view isKindOfClass:[BHudContentView class]]) {
            [view removeFromSuperview];
            
        }
    }
    
}

+(void)showCustomHudView:(UIView *_Nullable)view InView:(UIView *_Nullable)supperView{
    BHudContentView *contentView = [[BHudContentView alloc]initWithFrame:supperView.frame];
    contentView.indicatorViewStyle = BHudCustomView;
    contentView.customView = view;
    contentView.hudType = BIndicatorHud;
    
    
    [supperView addSubview:contentView];
    
    
}


@end
