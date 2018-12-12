//
//  BKeybordReturnTool.m
//  slwl_yq
//
//  Created by bai on 16/5/9.
//  Copyright © 2016年 bai.xianzhi. All rights reserved.
//

#import "BKeybordReturnHandler.h"


NSString *const KBTextField                =   @"KBTextField";
NSString *const KBTextFieldDelegate        =   @"KBTextFieldDelegate";
NSString *const KBTextFieldReturnKeyType   =   @"KBTextFieldReturnKeyType";

@interface BKeybordReturnHandler()<UITextFieldDelegate>{
    NSMutableSet *textFieldInfoCache;
   

}


@end
@implementation BKeybordReturnHandler
@synthesize textFields;

- (instancetype)init
{
    self = [self initWithViewController:nil];
    return self;
}


-(nonnull instancetype)initWithViewController:(nullable UIViewController*)controller{
    self = [super init];
    
    if (self)
    {
        textFieldInfoCache = [[NSMutableSet alloc] init];
         textFields = [[NSMutableArray alloc] init];
        if (controller) {
            [self addResponderFromView:controller.view];
        }
        
    }
    
    return self;
}

//-(nonnull instancetype)initWithView:(nullable UIView*)view{
//    self = [super init];
//    
//    if (self)
//    {
//        textFieldInfoCache = [[NSMutableSet alloc] init];
//        textFields = [[NSMutableArray alloc] init];
//        [self addResponderFromView:view];
//    }
//    
//    return self;
//}


-(nonnull instancetype)initWithTextFields:(nullable NSArray*)theTextFields{
    self = [self initWithViewController:nil];
    for (UITextField *textField in theTextFields) {
        [self addTextFieldView:textField];
    }
    return self;


}

-(NSDictionary*)textFieldCachedInfo:(UITextField*)textField
{
    for (NSDictionary *infoDict in textFieldInfoCache)
        if ([infoDict objectForKey:KBTextField] == textField)  return infoDict;
    
    return nil;
}


-(void)addTextFieldView:(UITextField*)textField{
    
    
    [textFields addObject:textField];
    
    
    NSMutableDictionary *dictInfo = [[NSMutableDictionary alloc] init];
    [dictInfo setObject:textField forKey:KBTextField];
    [dictInfo setObject:[NSNumber numberWithInteger:textField.returnKeyType] forKey:KBTextFieldReturnKeyType];
    
    if (textField.delegate){
        [dictInfo setObject:textField.delegate forKey:KBTextFieldDelegate];
    }
    
    [textField setDelegate:self];
    
    [textFieldInfoCache addObject:dictInfo];
}


#pragma mark - Add/Remove TextFields
-(void)addResponderFromView:(UIView*)view
{
    
    
    //subviews are returning in opposite order. So I sorted it according the frames 'y'.
    NSArray *subViews = [self subViewsSortedArrayByPositionInView:view];
    
    for (UITextField *textField in subViews)
    {
        if ([self BcanBecomeFirstResponder:textField])
        {
           
            [self addTextFieldView:textField];
        }
        else if (textField.subviews.count)
        {
            [self addResponderFromView:textField];
        }
    }

    
  
}


-(NSArray *)subViewsSortedArrayByPositionInView:(UIView *)view{
    
    
    
    return [view.subviews sortedArrayUsingComparator:^NSComparisonResult(UIView *view1, UIView *view2) {
        
        CGFloat x1 = CGRectGetMinX(view1.frame);
        CGFloat y1 = CGRectGetMinY(view1.frame);
        CGFloat x2 = CGRectGetMinX(view2.frame);
        CGFloat y2 = CGRectGetMinY(view2.frame);
        
        if (y1 < y2)  return NSOrderedAscending;
        
        else if (y1 > y2) return NSOrderedDescending;
        
        //Else both y are same so checking for x positions
        else if (x1 < x2)  return NSOrderedAscending;
        
        else if (x1 > x2) return NSOrderedDescending;
        
        else    return NSOrderedSame;
    }];

}


-(BOOL)BcanBecomeFirstResponder:(UIView *)view
{
    
    BOOL _BcanBecomeFirstResponder = ([view canBecomeFirstResponder] && [view isUserInteractionEnabled] && ![view isHidden] && [view alpha]!=0.0);
    
    if (_BcanBecomeFirstResponder == YES)
    {
        if ([self isKindOfClass:[UITextField class]])
        {
            _BcanBecomeFirstResponder = [(UITextField*)self isEnabled];
        }
        else if ([self isKindOfClass:[UITextView class]])
        {
            _BcanBecomeFirstResponder = [(UITextView*)self isEditable];
        }
    }
    
    //[self _setIsAskingCanBecomeFirstResponder:NO];
    
    return _BcanBecomeFirstResponder;
}


//-(id<UITextFieldDelegate>)delegate{
//   return  [textFieldInfoCache objectAtIndex:<#(NSUInteger)#>]
//}
#pragma mark - TextField delegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    
   // self.delegate = [self delegateForTextField:textField];
    if ([self.delegate respondsToSelector:@selector(textFieldShouldBeginEditing:)])
        return [self.delegate textFieldShouldBeginEditing:textField];
    else
        return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
   // [self updateReturnKeyTypeOnTextField:textField];
    //self.delegate = [self delegateForTextField:textField];
    
    if ([self.delegate respondsToSelector:@selector(textFieldDidBeginEditing:)])
        [self.delegate textFieldDidBeginEditing:textField];
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    if ([self.delegate respondsToSelector:@selector(textFieldShouldEndEditing:)])
        return [self.delegate textFieldShouldEndEditing:textField];
    else
        return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if ([self.delegate respondsToSelector:@selector(textFieldDidEndEditing:)])
        [self.delegate textFieldDidEndEditing:textField];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([self.delegate respondsToSelector:@selector(textField:shouldChangeCharactersInRange:replacementString:)])
        return [self.delegate textField:textField shouldChangeCharactersInRange:range replacementString:string];
    else
        return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField
{
    if ([self.delegate respondsToSelector:@selector(textFieldShouldClear:)])
        return [self.delegate textFieldShouldClear:textField];
    else
        return YES;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    BOOL shouldReturn = YES;
    
    if ([self.delegate respondsToSelector:@selector(textFieldShouldReturn:)])
        shouldReturn = [self.delegate textFieldShouldReturn:textField];
    
    if (shouldReturn)
    {
        [self goToNextResponderOrResign:textField];
    }
    
    return shouldReturn;
}

#pragma mark - Goto next or Resign.

-(void)goToNextResponderOrResign:(UIView*)textField
{
    
    //Getting index of current textField.
    NSUInteger index = [textFields indexOfObject:textField];
    
    //If it is not last textField. then it's next object becomeFirstResponder.
    (index != NSNotFound && index < textFields.count-1) ?   [[textFields objectAtIndex:index+1] becomeFirstResponder]  :   [textField resignFirstResponder];
}

-(id<UITextFieldDelegate>)delegateForTextField:(UITextField *)textFiled{
    
    
    NSDictionary *textFieldCacheInfo = [self textFieldCachedInfo:textFiled];
    return [textFieldCacheInfo objectForKey:KBTextFieldDelegate];
}

@end
