//
//  DateTool.m
//  Rail_hrb
//
//  Created by bai on 15/10/14.
//  Copyright © 2015年 bai.xianzhi. All rights reserved.
//

#import "DateTool.h"

@implementation DateTool
//+(NSDate *)zeroOfDate
//{
//    NSCalendar *calendar = [NSCalendar currentCalendar];
//    
//    NSUInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
//    NSDateComponents *components = [calendar components:unitFlags fromDate:[NSDate date]];
//
//    [components setHour:0];
//    [components setMinute:0];
//    [components setSecond:0];
//    
//    // components.nanosecond = 0 not available in iOS
//    NSLog(@"datetool%@",components);
//    NSLog(@"datetool%@",[calendar dateFromComponents:components]);
//    NSTimeInterval ts = (long long)[[calendar dateFromComponents:components] timeIntervalSince1970];
//    return [NSDate dateWithTimeIntervalSince1970:ts];
//}
//
//+(NSDate *)zeroOflonglongDate
//{
//    NSCalendar *calendar = [NSCalendar currentCalendar];
//    NSDateComponents *components = [calendar components:NSUIntegerMax fromDate:[NSDate date]];
//    components.hour = 0;
//    components.minute = 0;
//    components.second = 0;
//    
//    // components.nanosecond = 0 not available in iOS
//    NSTimeInterval ts = (double)(int)[[calendar dateFromComponents:components] timeIntervalSince1970];
//    return [NSDate dateWithTimeIntervalSince1970:ts];
//}
+(NSDate *)preDay:(NSDate *)date{
    return [NSDate dateWithTimeInterval:(-24*60*60) sinceDate:date];
}
+(NSDate *)nextDay:(NSDate *)date{
    return [NSDate dateWithTimeInterval:(24*60*60) sinceDate:date];
}
+(NSString *)formatDateFromLongLong:(long long ) longlongdate formatter:(NSString *)formatter{
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:longlongdate/1000];
    
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    dateFormatter.dateFormat = formatter;
    
    return [dateFormatter stringFromDate:date];
}


+(NSString *)formatDateFromLongLong2:(long long ) longlongdate formatter:(NSString *)formatter{
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:longlongdate];
    
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    dateFormatter.dateFormat = formatter;
    
    return [dateFormatter stringFromDate:date];
}

+(long long)longlongDateFromDate:(NSDate *)date{
    return (long long)[date timeIntervalSince1970]*1000;
   
}
+(NSDate *)dateFromLongLong:(long long)longlongdate{
    return  [[NSDate alloc]initWithTimeIntervalSince1970:longlongdate/1000];
}

+(NSString *)formatDateFromDate:(NSDate *) date formatter:(NSString *)formatter{
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    dateFormatter.dateFormat = formatter;
    
    return [dateFormatter stringFromDate:date];
}

+(NSString *)formatDateFromObject:(id) date formatter:(NSString *)formatter{
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    dateFormatter.dateFormat = formatter;
    if ([date isKindOfClass:[NSDate class]]) {
        return [self formatDateFromDate:date formatter:formatter];
    }else if([date isKindOfClass:[NSNumber class]]){
        return [self formatDateFromLongLong:[date longLongValue] formatter:formatter];
    }else{
        return @"";
    }
}

+(NSTimeInterval)TimeInterValFromDate:(NSDate *)fromdate toDate:(NSDate *)todate{
    return  [todate timeIntervalSinceDate:fromdate];
}

+(NSDateComponents *)componentsValueFromDate:(NSDate *)fromdate toDate:(NSDate *)todate{

    // 当前日历
    NSCalendar *calendar = [NSCalendar currentCalendar];
    // 需要对比的时间数据
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth
    | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    // 对比时间差
    NSDateComponents *dateCom = [calendar components:unit fromDate:fromdate toDate:todate options:0];
    
    return dateCom;
}

+(NSDate *)netDateFromGMTString:(NSString *)GMTString{
    NSString *date =GMTString;
    
    date = [date substringFromIndex:5];
    
    date = [date substringToIndex:[date length]-4];
    
    
    
    
    
    NSDateFormatter *dMatter = [[NSDateFormatter alloc] init];
    
    
    
    dMatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    
    [dMatter setDateFormat:@"dd MMM yyyy HH:mm:ss"];
    
    
    
    NSDate *netDate = [[dMatter dateFromString:date] dateByAddingTimeInterval:60*60*8];
    return netDate;
}


+(NSDate *)dateFromString:(NSString *)dateString{
    return  [self dateFromString:dateString formater:@"yyyy-MM-dd HH:mm:ss"];
}

+(NSDate *)dateFromString:(NSString *)dateString formater:(NSString *)formater{
    NSDateFormatter *dMatter = [[NSDateFormatter alloc] init];
    [dMatter setDateFormat:formater];
//    dMatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
   
    NSDate *netDate = [dMatter dateFromString:dateString];
    
//    NSDate *netDate = [[dMatter dateFromString:dateString] dateByAddingTimeInterval:60*60*8];
    return netDate;
    
}

+ (NSCalendar *)calendar
{
    
#ifdef __IPHONE_8_0
      NSCalendar  *_calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
#else
      NSCalendar  * _calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
#endif
        _calendar.timeZone = [NSTimeZone localTimeZone];
        _calendar.locale = [NSLocale currentLocale];
    
    
    return _calendar;
}



+ (NSDate *)addToDate:(NSDate *)date months:(NSInteger)months
{
    NSDateComponents *components = [NSDateComponents new];
    components.month = months;
    return [self.calendar dateByAddingComponents:components toDate:date options:0];
}

+ (NSDate *)addToDate:(NSDate *)date weeks:(NSInteger)weeks
{
    NSDateComponents *components = [NSDateComponents new];
    components.day = 7 * weeks;
    return [[self calendar] dateByAddingComponents:components toDate:date options:0];
}

+ (NSDate *)addToDate:(NSDate *)date days:(NSInteger)days
{
    NSDateComponents *components = [NSDateComponents new];
    components.day = days;
    return [self.calendar dateByAddingComponents:components toDate:date options:0];
}

///当前时间加 小时数
+ (NSDate *)addToDate:(NSDate *)date hours:(NSInteger)hours{

    NSTimeInterval interval = 60 * 60 * hours;
    return [[NSDate alloc]initWithTimeInterval:interval sinceDate:date];
}

#pragma mark - Helpers

+ (NSUInteger)numberOfWeeks:(NSDate *)date
{
    NSDate *firstDay = [self firstDayOfMonth:date];
    NSDate *lastDay = [self lastDayOfMonth:date];
    
    NSDateComponents *componentsA = [self.calendar components:NSCalendarUnitWeekOfYear fromDate:firstDay];
    NSDateComponents *componentsB = [self.calendar components:NSCalendarUnitWeekOfYear fromDate:lastDay];
    
    // weekOfYear may return 53 for the first week of the year
    return (componentsB.weekOfYear - componentsA.weekOfYear + 52 + 1) % 52;
}

+ (NSDate *)firstDayOfMonth:(NSDate *)date
{
    NSDateComponents *componentsCurrentDate = [self.calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitWeekday|NSCalendarUnitWeekOfMonth fromDate:date];
    
    NSDateComponents *componentsNewDate = [NSDateComponents new];
    
    componentsNewDate.year = componentsCurrentDate.year;
    componentsNewDate.month = componentsCurrentDate.month;
    componentsNewDate.weekOfMonth = 1;
    componentsNewDate.day = 1;
    
    return [self.calendar dateFromComponents:componentsNewDate];
}

+ (NSDate *)lastDayOfMonth:(NSDate *)date
{
    NSDateComponents *componentsCurrentDate = [self.calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitWeekday|NSCalendarUnitWeekOfMonth fromDate:date];
    
    NSDateComponents *componentsNewDate = [NSDateComponents new];
    
    componentsNewDate.year = componentsCurrentDate.year;
    componentsNewDate.month = componentsCurrentDate.month + 1;
    componentsNewDate.day = 0;
    
    return [self.calendar dateFromComponents:componentsNewDate];
}

+ (NSDate *)firstWeekDayOfMonth:(NSDate *)date
{
    NSDate *firstDayOfMonth = [self firstDayOfMonth:date];
    return [self firstWeekDayOfWeek:firstDayOfMonth];
}

+ (NSDate *)firstWeekDayOfWeek:(NSDate *)date
{
    NSDateComponents *componentsCurrentDate = [self.calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitWeekday|NSCalendarUnitWeekOfMonth fromDate:date];
    
    NSDateComponents *componentsNewDate = [NSDateComponents new];
    
    componentsNewDate.year = componentsCurrentDate.year;
    componentsNewDate.month = componentsCurrentDate.month;
    componentsNewDate.weekOfMonth = componentsCurrentDate.weekOfMonth;
    componentsNewDate.weekday = self.calendar.firstWeekday;
    
    return [self.calendar dateFromComponents:componentsNewDate];
}

#pragma mark - Comparaison

+ (BOOL)date:(NSDate *)dateA isTheSameMonthThan:(NSDate *)dateB
{
    NSDateComponents *componentsA = [self.calendar components:NSCalendarUnitYear|NSCalendarUnitMonth fromDate:dateA];
    NSDateComponents *componentsB = [self.calendar components:NSCalendarUnitYear|NSCalendarUnitMonth fromDate:dateB];
    
    return componentsA.year == componentsB.year && componentsA.month == componentsB.month;
}

+ (BOOL)date:(NSDate *)dateA isTheSameWeekThan:(NSDate *)dateB
{
    NSDateComponents *componentsA = [self.calendar components:NSCalendarUnitYear|NSCalendarUnitWeekOfYear fromDate:dateA];
    NSDateComponents *componentsB = [self.calendar components:NSCalendarUnitYear|NSCalendarUnitWeekOfYear fromDate:dateB];
    
    return componentsA.year == componentsB.year && componentsA.weekOfYear == componentsB.weekOfYear;
}

+ (BOOL)date:(NSDate *)dateA isTheSameDayThan:(NSDate *)dateB
{
    NSDateComponents *componentsA = [self.calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:dateA];
    NSDateComponents *componentsB = [self.calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:dateB];
    
    return componentsA.year == componentsB.year && componentsA.month == componentsB.month && componentsA.day == componentsB.day;
}

+ (BOOL)date:(NSDate *)dateA isEqualOrBefore:(NSDate *)dateB
{
    if([dateA compare:dateB] == NSOrderedAscending || [self date:dateA isTheSameDayThan:dateB]){
        return YES;
    }
    
    return NO;
}

+ (BOOL)date:(NSDate *)dateA isEqualOrAfter:(NSDate *)dateB
{
    if([dateA compare:dateB] == NSOrderedDescending || [self date:dateA isTheSameDayThan:dateB]){
        return YES;
    }
    
    return NO;
}

+ (BOOL)date:(NSDate *)date isEqualOrAfter:(NSDate *)startDate andEqualOrBefore:(NSDate *)endDate
{
    if([self date:date isEqualOrAfter:startDate] && [self date:date isEqualOrBefore:endDate]){
        return YES;
    }
    
    return NO;
}

+(NSInteger)monthOfDay:(NSDate *)date{
    NSDateComponents *componentsCurrentDate = [self.calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitWeekday|NSCalendarUnitWeekOfMonth fromDate:date];
    return componentsCurrentDate.month;
}




+ (BOOL)isBetweenFromHour:(NSInteger)fromHour FromMinute:(NSInteger)fromMin toHour:(NSInteger)toHour toMinute:(NSInteger)toMin
{
    NSDate *date1 = [self getCustomDateWithHour:fromHour andMinute:fromMin];
    NSDate *date2 = [self getCustomDateWithHour:toHour andMinute:toMin];
    
    NSDate *currentDate = [NSDate date];
    
    if ([currentDate compare:date1]==NSOrderedDescending && [currentDate compare:date2]==NSOrderedAscending)
    {
        NSLog(@"该时间在 %d:%d-%d:%d 之间！", fromHour, fromMin, toHour, toMin);
        return YES;
    }
    return NO;
}

/**
 * @brief 生成当天的某个点（返回的是伦敦时间，可直接与当前时间[NSDate date]比较）
 * @param hour 如hour为“8”，就是上午8:00（本地时间）
 */
+ (NSDate *)getCustomDateWithHour:(NSInteger)hour andMinute:(NSInteger)minute
{
    //获取当前时间
    NSDate *currentDate = [NSDate date];
    NSCalendar *currentCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *currentComps = [[NSDateComponents alloc] init];
    
    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    
    currentComps = [currentCalendar components:unitFlags fromDate:currentDate];
    
    //设置当天的某个点
    NSDateComponents *resultComps = [[NSDateComponents alloc] init];
    [resultComps setYear:[currentComps year]];
    [resultComps setMonth:[currentComps month]];
    [resultComps setDay:[currentComps day]];
    [resultComps setHour:hour];
    [resultComps setMinute:minute];
    
    NSCalendar *resultCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    return [resultCalendar dateFromComponents:resultComps];
}


+(NSString*)weekdayStringFromDate:(NSDate*)inputDate {
    
    NSArray *weekdays = [NSArray arrayWithObjects: [NSNull null], @"星期天", @"星期一", @"星期二", @"星期三", @"星期四", @"星期五", @"星期六", nil];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/SuZhou"];
    
    [calendar setTimeZone: timeZone];
    
    NSCalendarUnit calendarUnit = NSCalendarUnitWeekday;
    
    NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:inputDate];
    
    return [weekdays objectAtIndex:theComponents.weekday];
    
}

+(NSString*)weekdayStringFromDate2:(NSDate*)inputDate {
    
    NSArray *weekdays = [NSArray arrayWithObjects: [NSNull null], @"周日", @"周一", @"周二", @"周三", @"周四", @"周五", @"周六", nil];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/SuZhou"];
    
    [calendar setTimeZone: timeZone];
    
    NSCalendarUnit calendarUnit = NSCalendarUnitWeekday;
    
    NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:inputDate];
    
    return [weekdays objectAtIndex:theComponents.weekday];
    
}

+(NSInteger )weekdayStringFromDate3:(NSDate*)inputDate {
    
    
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/SuZhou"];
    
    [calendar setTimeZone: timeZone];
    
    NSCalendarUnit calendarUnit = NSCalendarUnitWeekday;
    
    NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:inputDate];
    
    return theComponents.weekday;
    
}

@end
