//
//  ____    ___   _        ___  _____  ____  ____  ____
// |    \  /   \ | T      /  _]/ ___/ /    T|    \|    \
// |  o  )Y     Y| |     /  [_(   \_ Y  o  ||  o  )  o  )
// |   _/ |  O  || l___ Y    _]\__  T|     ||   _/|   _/
// |  |   |     ||     T|   [_ /  \ ||  _  ||  |  |  |
// |  |   l     !|     ||     T\    ||  |  ||  |  |  |
// l__j    \___/ l_____jl_____j \___jl__j__jl__j  l__j
//
//
//	Powered by Polesapp.com
//
//
//  RBCustomDatePickerView.h
//
//
//  Created by fangmi-huangchengda on 15/10/21.
//
//


/**
 修改了该框架的现实方式，用工具类 balertviewmodal 显示该view，防止出现工程中有导航栏的问题。
 （1）显示panal的frame 改变 
 （2）修改了取消 确定按钮的 回调 dismiss 由balertviewmodal 控制。
 
 修改了 回调字符转格式
 */

#define HEIGHT [UIScreen mainScreen].bounds.size.height
#define WIDTH [UIScreen mainScreen].bounds.size.width

#import <UIKit/UIKit.h>
#import "MXSCycleScrollView.h"

typedef enum {
    DatePickerDateMode,//年月日
    DatePickerTimeMode,//时分秒
    DatePickerDateTimeMode,//年月日时分秒
    DatePickerMonthDayMode,//月日
    DatePickerHourMinuteMode,//时分
    DatePickerYearMonthMode,//年月
    DatePickerYearMode,//年
    DatePickerYearMonthDayHourMinute//年月日时分
    
}DatePickerMode;

typedef void(^DatePickerCompleteAnimationBlock)(BOOL Complete);
typedef void(^ClickedOkBtn)(NSString *dateTimeStr);


@interface HcdDateTimePickerView : UIView <MXSCycleScrollViewDatasource,MXSCycleScrollViewDelegate>
@property (nonatomic,strong) ClickedOkBtn clickedOkBtn;
@property (nonatomic,strong) ClickedOkBtn clickedCancleBtn;
@property (nonatomic,assign) NSInteger curYear;//当前年
@property (nonatomic,assign) NSInteger curMonth;//当前月
@property (nonatomic,assign) NSInteger curDay;//当前日
@property (nonatomic,assign) NSInteger curHour;//当前小时
@property (nonatomic,assign) NSInteger curMin;//当前分
@property (nonatomic,assign) NSInteger curSecond;//当前秒

@property (nonatomic,assign) DatePickerMode datePickerMode;

-(instancetype)initWithDefaultDatetime:(NSDate*)dateTime;
-(instancetype)initWithDatePickerMode:(DatePickerMode)datePickerMode defaultDateTime:(NSDate*)dateTime;
//-(void) showHcdDateTimePicker;
@end
