
//  BaseViewController.h
//
//  Created by bai on 16/2/16.
//  Copyright © 2016年 bai.xianzhi. All rights reserved.


#import <UIKit/UIKit.h>

#import "BaseDefine.h"

#import "GlobleToolDefine.h"





@interface BaseViewController : UIViewController


//@property(nonatomic,retain,getter=jsonsessionManager) AFHTTPSessionManager *jsonsessionManager;


@property (nonatomic, readwrite, retain)  UIButton *leftbtn;
@property (nonatomic, readwrite, retain)  UIButton *rigthtbtn;

-(void)setLeftBtnHidde:(BOOL)hidde;
-(void)setLeftbtnTitle:(NSString *)title;
-(void)setRigthtBtnHidde:(BOOL)hidde;
-(void)setRigthtbtnTitle:(NSString *)title;
-(void)setRigthtbtnImage:(UIImage *)image;
-(void)rightBarButtonAction:(id)sender;

-(void)goBackAction;


@property(nonatomic,readwrite)BOOL hiddeBottmBar;

-(void)setBottomBarBadge:(NSString *)badge atIndext:(int )indext;




-(void)alertViewWithTitle:(NSString *)title  message:(NSString *)massage cancleBlock:(void(^)(void))cancleBlock okBlock:(void(^)(void))okBlock;

-(void)checkAppHasNewVersionWithTag:(NSInteger ) tag;


@end
