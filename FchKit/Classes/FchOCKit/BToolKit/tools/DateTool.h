//
//  DateTool.h
//  Rail_hrb
//
//  Created by bai on 15/10/14.
//  Copyright © 2015年 bai.xianzhi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DateTool : NSObject
//+(NSDate *)zeroOfDate;
//+(NSDate *)zeroOflonglongDate;
+(NSDate *)preDay:(NSDate *)date;
+(NSDate *)nextDay:(NSDate *)date;

/**
 时间转化  毫秒级
 
 @param longlongdate 时间
 @param formatter 格式
 @return 时间字
 */
+(NSString *)formatDateFromLongLong:(long long ) longlongdate formatter:(NSString *)formatter;

/**
 时间转化  秒级

 @param longlongdate 时间
 @param formatter 格式
 @return 时间字符
 */
+(NSString *)formatDateFromLongLong2:(long long ) longlongdate formatter:(NSString *)formatter;
+(NSString *)formatDateFromDate:(NSDate *) date formatter:(NSString *)formatter;
+(NSString *)formatDateFromObject:(id) date formatter:(NSString *)formatter;

+(long long)longlongDateFromDate:(NSDate *)date;

///获取时间星期
+(NSString*)weekdayStringFromDate:(NSDate*)inputDate;
+(NSString*)weekdayStringFromDate2:(NSDate*)inputDate;
+(NSInteger )weekdayStringFromDate3:(NSDate*)inputDate;

///网络请求头内时间
+(NSDate *)netDateFromGMTString:(NSString *)GMTString;
///2016-03-09 13:46:07
+(NSDate *)dateFromString:(NSString *)dateString;
+(NSDate *)dateFromString:(NSString *)dateString formater:(NSString *)formater;
+(NSDate *)dateFromLongLong:(long long)longlongdate;
///时间间隔
+(NSTimeInterval)TimeInterValFromDate:(NSDate *)fromdate toDate:(NSDate *)todate;

// 计算时间差 
+(NSDateComponents *)componentsValueFromDate:(NSDate *)fromdate toDate:(NSDate *)todate;

///当前时间加 月数
+ (NSDate *)addToDate:(NSDate *)date months:(NSInteger)months;
///当前时间加 星期数
+ (NSDate *)addToDate:(NSDate *)date weeks:(NSInteger)weeks;
///当前时间加 天数
+ (NSDate *)addToDate:(NSDate *)date days:(NSInteger)days;

///当前时间加 小时
+ (NSDate *)addToDate:(NSDate *)date hours:(NSInteger)hours;

// date所在月有多少个星期
+ (NSUInteger)numberOfWeeks:(NSDate *)date;

/// date所在月的第一天日期
+ (NSDate *)firstDayOfMonth:(NSDate *)date;
///date所在月的第一个星期的第一天（通常为上个月某个日期，特殊情况下为当天）
+ (NSDate *)firstWeekDayOfMonth:(NSDate *)date;
///date所在星期的第一天
+ (NSDate *)firstWeekDayOfWeek:(NSDate *)date;
///date所在月份
+(NSInteger)monthOfDay:(NSDate *)date;

+ (BOOL)date:(NSDate *)dateA isTheSameMonthThan:(NSDate *)dateB;
+ (BOOL)date:(NSDate *)dateA isTheSameWeekThan:(NSDate *)dateB;
+(BOOL)date:(NSDate *)dateA isTheSameDayThan:(NSDate *)dateB;

+ (BOOL)date:(NSDate *)dateA isEqualOrBefore:(NSDate *)dateB;
+ (BOOL)date:(NSDate *)dateA isEqualOrAfter:(NSDate *)dateB;
+ (BOOL)date:(NSDate *)date isEqualOrAfter:(NSDate *)startDate andEqualOrBefore:(NSDate *)endDate;

+ (BOOL)isBetweenFromHour:(NSInteger)fromHour FromMinute:(NSInteger)fromMin toHour:(NSInteger)toHour toMinute:(NSInteger)toMin;
+ (NSDate *)getCustomDateWithHour:(NSInteger)hour andMinute:(NSInteger)minute;



@end
