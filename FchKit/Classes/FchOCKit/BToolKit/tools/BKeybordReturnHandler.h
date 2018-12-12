//
//  BKeybordReturnTool.h
//  slwl_yq
//
//  Created by bai on 16/5/9.
//  Copyright © 2016年 bai.xianzhi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface BKeybordReturnHandler : NSObject



 @property(nullable, nonatomic, readwrite) NSMutableArray *textFields;
/**
 Delegate of textField/textView.
 */
@property(nullable, nonatomic, weak) id<UITextFieldDelegate> delegate;


-(nonnull instancetype)initWithViewController:(nullable UIViewController*)controller NS_DESIGNATED_INITIALIZER;

//-(nonnull instancetype)initWithView:(nullable UIView*)view;

-(nonnull instancetype)initWithTextFields:(nullable NSArray*)theTextFields;


-(void)addResponderFromView:(nullable UIView*)view;


@end
