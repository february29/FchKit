//
//  StringTool.m
//  contact
//
//  Created by bai on 15/12/4.
//  Copyright © 2015年 Yaocui. All rights reserved.
//

#import "StringTool.h"

@implementation StringTool
///// 手机号码的有效性判断
//检测是否是手机号码
+(BOOL)isPhoneNumber:(NSString *)phoneNum
{
    
    
    NSString *termiString1 = [phoneNum stringByReplacingOccurrencesOfString:@"-" withString:@""];
    NSString *termiString = [termiString1 stringByReplacingOccurrencesOfString:@"－" withString:@""];
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
   // NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
     NSString * MOBILE = @"^1(3[0-9]|5[0-9]|8[025-9])\\d{8}$";
    /**
     * 中国移动：China Mobile
     * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[2378])\\d)\\d{7}$";
    /**
     * 中国联通：China Unicom
     * 130,131,132,152,155,156,185,186
     */
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    /**
     * 中国电信：China Telecom
     * 133,1349,153,180,189
     */
    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    /**
     * 大陆地区固话及小灵通
     * 区号：010,020,021,022,023,024,025,027,028,029
     * 号码：七位或八位
     */
     NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    NSPredicate *regextestphs = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", PHS];
    
    if (([regextestmobile evaluateWithObject:termiString] == YES)
        || ([regextestcm evaluateWithObject:termiString] == YES)
        || ([regextestct evaluateWithObject:termiString] == YES)
        || ([regextestcu evaluateWithObject:termiString] == YES)
        || ([regextestphs evaluateWithObject:termiString] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}


+(BOOL)isNumber:(NSString *)Num{
    if ([self isPureFloat:Num]||[self isPureInt:Num]) {
        return YES;
    }else{
         return NO;
    }
   
}


+(BOOL)isPureInt:(NSString *)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return [scan scanInt:&val] && [scan isAtEnd];
}

+(BOOL)isPureFloat:(NSString *)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    float val;
    return [scan scanFloat:&val] && [scan isAtEnd];
}

+(NSString *)stringOfObject:(id)Object{
   
    if (!Object) {
        return @"";
    }
    if (Object==[NSNull null]) {
        return  @"";
    }else{
        if ([Object isKindOfClass:[NSString class]]) {
            return [NSString stringWithFormat:@"%@",Object];
        }else if ([Object respondsToSelector:@selector(intValue)]) {
            return [NSString stringWithFormat:@"%d",[Object intValue]];
        }else{
            return @"";
        }
    }
    
}


+(NSString *)stringOfInt:(id)Object{
    if (!Object) {
        return @"";
    }
    if (Object==[NSNull null]) {
        return  @"";
    }else{
        if ([Object respondsToSelector:@selector(intValue)]) {//即使是字符串也走这里
            return [NSString stringWithFormat:@"%d",[Object intValue]];
        }else{
            return @"";
        }
    }

}
+(NSString *)stringOfFloat:(id)Object{
    if (!Object) {
        return @"";
    }
    if (Object==[NSNull null]) {
        return  @"";
    }else{
         if([Object respondsToSelector:@selector(floatValue)]){//即使是字符串也走这里
            return [NSString stringWithFormat:@"%.2f",[Object floatValue]];
        }else{
            return @"";
        }
    }

}

+(NSString *)stringOfFloat2:(id)Object{
    if (!Object) {
        return @"";
    }
    if (Object==[NSNull null]) {
        return  @"";
    }else{
        if([Object respondsToSelector:@selector(floatValue)]){//即使是字符串也走这里
            return [NSString stringWithFormat:@"%.1f",[Object floatValue]];
        }else{
            return @"";
        }
    }

}

+(NSString *)trimingWithOutSpaceAndReturn:(NSString *)trimStr{
    return [trimStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

+(NSAttributedString*)attrStrForPreStr:(NSString *)preStr preColor:(UIColor *)preColor preFont:(UIFont *)preFont behindStr:(NSString*)behindStr behindColor:(UIColor *)behindColor behindFont:(UIFont *)behindFont{
   
  
    NSString *totleStr = [NSString stringWithFormat:@"%@%@",preStr,behindStr];
    NSRange range1 = [totleStr rangeOfString:preStr];
    NSRange range2 = [totleStr rangeOfString:behindStr];
    
    
    NSMutableAttributedString *content = [[NSMutableAttributedString alloc] initWithString:totleStr];

    [content addAttribute:NSForegroundColorAttributeName value:preColor range:range1];
    [content addAttribute:NSFontAttributeName value:preFont range:range1];
   
    
    [content addAttribute:NSForegroundColorAttributeName value:behindColor range:range2];
    [content addAttribute:NSFontAttributeName value:behindFont range:range2];
    return   content;

}



+(CGFloat)widthWithString:(NSString*)string fontSize:(CGFloat)fontSize height:(CGFloat)height
{
    NSDictionary *attrs = @{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]};
    return  [string boundingRectWithSize:CGSizeMake(0, height) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attrs context:nil].size.width;
}
+(CGFloat)heightWithString:(NSString*)string fontSize:(CGFloat)fontSize width:(CGFloat)width
{
    NSDictionary *attrs = @{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]};
    return  [string boundingRectWithSize:CGSizeMake(width, 0) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attrs context:nil].size.height;
}



/*!
 *  检测是否为邮箱
 *
 *  @param emailStr 传入需要检测的字符串
 *
 *  @return 返回检测结果 是或者不是
 */
+ (BOOL)ba_isEmailQualified:(NSString *)emailStr
{
    NSString *pattern = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSRegularExpression *regex = [[NSRegularExpression alloc] initWithPattern:pattern options:0 error:nil];
    NSArray *results = [regex matchesInString:emailStr options:0 range:NSMakeRange(0, emailStr.length)];
    return results.count > 0;
}

/*!
 *  检测用户输入密码是否以字母开头，长度在6-18之间，只能包含字符、数字和下划线。
 *
 *  @param passwordStr 传入需要检测的字符串
 *
 *  @return 返回检测结果 是或者不是
 */
+ (BOOL)ba_isPasswordQualified:(NSString *)passwordStr
{
    //    NSString *pattern = @"^[a-zA-Z]\\w.{5,17}$";
    //    NSRegularExpression *regex = [[NSRegularExpression alloc] initWithPattern:pattern options:0 error:nil];
    //    NSArray *results = [regex matchesInString:passwordStr options:0 range:NSMakeRange(0, passwordStr.length)];
    //    return results.count > 0;
    
    NSString *passWordRegex = @"^[a-zA-Z]\\w.{5,17}$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passWordRegex];
    return [passWordPredicate evaluateWithObject:passwordStr];
}

/*!
 *  验证身份证号（15位或18位数字）【最全的身份证校验，带校验位】
 *  @param idCardNumberStr 传入需要检测的字符串
 *
 *  @return 返回检测结果 是或者不是
 */
+ (BOOL)ba_isIdCardNumberQualified:(NSString *)idCardNumberStr
{
    idCardNumberStr = [idCardNumberStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSInteger length = 0;
    if (!idCardNumberStr)
    {
        return NO;
    }
    else
    {
        length = idCardNumberStr.length;
        if (length != 15 && length !=18)
        {
            return NO;
        }
    }
    /*! 省份代码 */
    NSArray *areasArray =@[@"11", @"12", @"13", @"14", @"15", @"21", @"22", @"23", @"31", @"32", @"33", @"34", @"35", @"36", @"37", @"41", @"42", @"43", @"44", @"45", @"46", @"50", @"51", @"52", @"53", @"54", @"61", @"62", @"63", @"64", @"65", @"71", @"81", @"82", @"91"];
    
    NSString *valueStart2 = [idCardNumberStr substringToIndex:2];
    BOOL areaFlag = NO;
    for (NSString *areaCode in areasArray)
    {
        if ([areaCode isEqualToString:valueStart2])
        {
            areaFlag =YES;
            break;
        }
    }
    if (!areaFlag)
    {
        return NO;
    }
    
    NSRegularExpression *regularExpression;
    NSUInteger numberofMatch;
    
    NSInteger year = 0;
    switch (length)
    {
        case 15:
            year = [idCardNumberStr substringWithRange:NSMakeRange(6,2)].intValue +1900;
            
            if (year % 4 ==0 || (year % 100 ==0 && year % 4 ==0))
            {
                /*! 测试出生日期的合法性 */
                regularExpression = [[NSRegularExpression alloc] initWithPattern:@"^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}$"
                                                                         options:NSRegularExpressionCaseInsensitive
                                                                           error:nil];
            }
            else
            {
                /*! 测试出生日期的合法性 */
                regularExpression = [[NSRegularExpression alloc] initWithPattern:@"^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}$"
                                                                         options:NSRegularExpressionCaseInsensitive
                                                                           error:nil];
            }
            numberofMatch = [regularExpression numberOfMatchesInString:idCardNumberStr
                                                               options:NSMatchingReportProgress
                                                                 range:NSMakeRange(0, idCardNumberStr.length)];
            
            if(numberofMatch > 0)
            {
                return YES;
            }
            else
            {
                return NO;
            }
            break;
        case 18:
            
            year = [idCardNumberStr substringWithRange:NSMakeRange(6,4)].intValue;
            if (year % 4 ==0 || (year % 100 ==0 && year % 4 ==0))
            {
                /*! 测试出生日期的合法性 */
                regularExpression = [[NSRegularExpression alloc] initWithPattern:@"^[1-9][0-9]{5}19[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}[0-9Xx]$"
                                                                         options:NSRegularExpressionCaseInsensitive
                                                                           error:nil];
            }
            else
            {
                /*! 测试出生日期的合法性 */
                regularExpression = [[NSRegularExpression alloc] initWithPattern:@"^[1-9][0-9]{5}19[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}[0-9Xx]$"
                                                                         options:NSRegularExpressionCaseInsensitive
                                                                           error:nil];
            }
            numberofMatch = [regularExpression numberOfMatchesInString:idCardNumberStr
                                                               options:NSMatchingReportProgress
                                                                 range:NSMakeRange(0, idCardNumberStr.length)];
            
            if(numberofMatch > 0)
            {
                NSInteger S = ([idCardNumberStr substringWithRange:NSMakeRange(0,1)].intValue + [idCardNumberStr substringWithRange:NSMakeRange(10,1)].intValue) *7 + ([idCardNumberStr substringWithRange:NSMakeRange(1,1)].intValue + [idCardNumberStr substringWithRange:NSMakeRange(11,1)].intValue) *9 + ([idCardNumberStr substringWithRange:NSMakeRange(2,1)].intValue + [idCardNumberStr substringWithRange:NSMakeRange(12,1)].intValue) *10 + ([idCardNumberStr substringWithRange:NSMakeRange(3,1)].intValue + [idCardNumberStr substringWithRange:NSMakeRange(13,1)].intValue) *5 + ([idCardNumberStr substringWithRange:NSMakeRange(4,1)].intValue + [idCardNumberStr substringWithRange:NSMakeRange(14,1)].intValue) *8 + ([idCardNumberStr substringWithRange:NSMakeRange(5,1)].intValue + [idCardNumberStr substringWithRange:NSMakeRange(15,1)].intValue) *4 + ([idCardNumberStr substringWithRange:NSMakeRange(6,1)].intValue + [idCardNumberStr substringWithRange:NSMakeRange(16,1)].intValue) *2 + [idCardNumberStr substringWithRange:NSMakeRange(7,1)].intValue *1 + [idCardNumberStr substringWithRange:NSMakeRange(8,1)].intValue *6 + [idCardNumberStr substringWithRange:NSMakeRange(9,1)].intValue *3;
                NSInteger Y = S % 11;
                NSString *M = @"F";
                NSString *JYM = @"10X98765432";
                /*! 判断校验位 */
                M = [JYM substringWithRange:NSMakeRange(Y,1)];
                if ([M isEqualToString:[idCardNumberStr substringWithRange:NSMakeRange(17,1)]])
                {
                    /*! 检测ID的校验位 */
                    return YES;
                }
                else
                {
                    return NO;
                }
                
            }
            else
            {
                return NO;
            }
            break;
        default:
            return NO;
            break;
    }
}

/*!
 *  验证IP地址（15位或18位数字）
 *  @param iPAddressStr 传入需要检测的字符串
 *
 *  @return 返回检测结果 是或者不是
 */
+ (BOOL)ba_isIPAddress:(NSString *)iPAddressStr
{
    
    NSString *pattern = @"((2[0-4]\\d|25[0-5]|[01]?\\d\\d?)\\.){3}(2[0-4]\\d|25[0-5]|[01]?\\d\\d?)";
    NSRegularExpression *regex = [[NSRegularExpression alloc] initWithPattern:pattern options:0 error:nil];
    NSArray *results = [regex matchesInString:iPAddressStr options:0 range:NSMakeRange(0, iPAddressStr.length)];
    return results.count > 0;
}

/*!
 *  验证输入的是否全为数字
 *  @param allNumberStr 传入需要检测的字符串
 *
 *  @return 返回检测结果 是或者不是
 */
+ (BOOL)ba_isAllNumber:(NSString *)allNumberStr
{
    NSString *pattern = @"^[0-9]*$";
    NSRegularExpression *regex = [[NSRegularExpression alloc] initWithPattern:pattern options:0 error:nil];
    NSArray *results = [regex matchesInString:allNumberStr options:0 range:NSMakeRange(0, allNumberStr.length)];
    return results.count > 0;
}

/*!
 *  验证由26个英文字母组成的字符串
 *  @param englishAlphabetStr 传入需要检测的字符串
 *
 *  @return 返回检测结果 是或者不是
 */
+ (BOOL)ba_isEnglishAlphabet:(NSString *)englishAlphabetStr
{
    NSString *pattern = @"^[A-Za-z]+$";
    NSRegularExpression *regex = [[NSRegularExpression alloc] initWithPattern:pattern options:0 error:nil];
    NSArray *results = [regex matchesInString:englishAlphabetStr options:0 range:NSMakeRange(0, englishAlphabetStr.length)];
    return results.count > 0;
}

/*!
 *  验证输入的是否是URL地址
 *  @param urlStr 传入需要检测的字符串
 *
 *  @return 返回检测结果 是或者不是
 */
+ (BOOL)ba_isUrl:(NSString *)urlStr
{
    //    NSString* verifyRules=@"^http://([\\w-]+\.)+[\\w-]+(/[\\w-./?%&=]*)?$";
    //    NSPredicate *verifyRulesPre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",verifyRules];
    //    return [verifyRulesPre evaluateWithObject:urlStr];
    
    NSString *pattern = @"\\b(([\\w-]+://?|www[.])[^\\s()<>]+(?:\\([\\w\\d]+\\)|([^[:punct:]\\s]|/)))";
    NSRegularExpression *regex = [[NSRegularExpression alloc] initWithPattern:pattern options:0 error:nil];
    NSArray *results = [regex matchesInString:urlStr options:0 range:NSMakeRange(0, urlStr.length)];
    return results.count > 0;
}

/*!
 *  验证输入的是否是中文
 *  @param chineseStr 传入需要检测的字符串
 *
 *  @return 返回检测结果 是或者不是
 */
+ (BOOL)ba_isChinese:(NSString *)chineseStr
{
    NSString *pattern = @"[\u4e00-\u9fa5]+";
    NSRegularExpression *regex = [[NSRegularExpression alloc] initWithPattern:pattern options:0 error:nil];
    NSArray *results = [regex matchesInString:chineseStr options:0 range:NSMakeRange(0, chineseStr.length)];
    return results.count > 0;
}

/*!
 *  验证输入的是否是高亮显示
 *  @param pattern 传入需要检测的字符串
 *
 *  @return 返回检测结果 是或者不是
 */
+ (BOOL)ba_isNormalText:(NSString *)normalStr WithHighLightText:(NSString *)HighLightStr
{
    NSString *pattern = [NSString stringWithFormat:@"%@",HighLightStr];
    NSRegularExpression *regex = [[NSRegularExpression alloc] initWithPattern:pattern options:0 error:nil];
    NSArray *results = [regex matchesInString:normalStr options:0 range:NSMakeRange(0, normalStr.length)];
    for (NSTextCheckingResult *resltText in results) {
        NSLog(@"----------------%zd",resltText.range.length);
    }
    return results.count > 0;
}

/*!
 *  是否为常用用户名（根据自己需求改）
 *
 *  @param userNameStr userNameStr
 *
 *  @return 返回检测结果 是或者不是（6-20位数字+字母组合）
 */
+ (BOOL)ba_isUserNameInGeneral:(NSString *)userNameStr
{
    NSString* verifyRules = @"^[A-Za-z0-9]{6,20}+$";
    NSPredicate *verifyRulesPre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",verifyRules];
    return [verifyRulesPre evaluateWithObject:userNameStr];
}

/*!
 *  车牌号验证
 *
 *  @param carNumber carNumber
 *
 *  @return 返回检测结果 是或者不是
 */
+ (BOOL)ba_isValidateCarNumber:(NSString *)carNumber
{
    /*! 车牌号:湘K-DE829 香港车牌号码:粤Z-J499港 */
    NSString *carRegex = @"^[\u4e00-\u9fa5]{1}[a-zA-Z]{1}[a-zA-Z_0-9]{4}[a-zA-Z_0-9_\u4e00-\u9fa5]$";
    /*! 其中\u4e00-\u9fa5表示unicode编码中汉字已编码部分，\u9fa5-\u9fff是保留部分，将来可能会添加 */
    NSPredicate *catTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", carRegex];
    return [catTest evaluateWithObject:carNumber];
}

/*!
 *  车型验证
 *
 *  @param CarType CarType
 *
 *  @return 返回检测结果 是或者不是
 */
+ (BOOL)ba_isValidateCarType:(NSString *)CarType
{
    NSString *CarTypeRegex = @"^[\u4E00-\u9FFF]+$";
    NSPredicate *carTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",CarTypeRegex];
    return [carTest evaluateWithObject:CarType];
}

/*!
 *  昵称验证
 *
 *  @param nickname nickname
 *
 *  @return 返回检测结果 是或者不是
 */
+ (BOOL)ba_isValidateNickname:(NSString *)nickname
{
    NSString *nicknameRegex = @"^[\u4e00-\u9fa5]{4,8}$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",nicknameRegex];
    return [passWordPredicate evaluateWithObject:nickname];
}

/*!
 *  邮政编码验证
 */
+ (BOOL)ba_isValidPostalcode:(NSString *)postalcode
{
    NSString *postalRegex = @"^[0-8]\\d{5}(?!\\d)$";
    NSPredicate *postalcodePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",postalRegex];
    
    return [postalcodePredicate evaluateWithObject:postalcode];
}

/*!
 *  工商税号验证
 */
+ (BOOL)ba_isValidTaxNo:(NSString *)taxNo
{
    NSString *taxNoRegex = @"[0-9]\\d{13}([0-9]|X)$";
    NSPredicate *taxNoPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",taxNoRegex];
    
    return [taxNoPredicate evaluateWithObject:taxNo];
}

/*!
 *  Mac地址有效性验证
 */
+ (BOOL)ba_isMacAddress:(NSString *)macAddress
{
    NSString *macAddRegex = @"([A-Fa-f\\d]{2}:){5}[A-Fa-f\\d]{2}";
    NSPredicate *macAddressPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",macAddRegex];
    
    return [macAddressPredicate evaluateWithObject:macAddress];
}

/** 银行卡号有效性问题Luhn算法
 *  现行 16 位银联卡现行卡号开头 6 位是 622126～622925 之间的，7 到 15 位是银行自定义的，
 *  可能是发卡分行，发卡网点，发卡序号，第 16 位是校验码。
 *  16 位卡号校验位采用 Luhm 校验方法计算：
 *  1，将未带校验位的 15 位卡号从右依次编号 1 到 15，位于奇数位号上的数字乘以 2
 *  2，将奇位乘积的个十位全部相加，再加上所有偶数位上的数字
 *  3，将加法和加上校验位能被 10 整除。
 */
+ (BOOL)ba_isBankCardlNumCheck:(NSString *)bankCardlNum
{
    NSString *lastNum = [[bankCardlNum substringFromIndex:(bankCardlNum.length-1)] copy];//取出最后一位
    NSString *forwardNum = [[bankCardlNum substringToIndex:(bankCardlNum.length -1)] copy];//前15或18位
    
    NSMutableArray * forwardArr = [[NSMutableArray alloc] initWithCapacity:0];
    for (int i=0; i<forwardNum.length; i++)
    {
        NSString * subStr = [forwardNum substringWithRange:NSMakeRange(i, 1)];
        [forwardArr addObject:subStr];
    }
    
    NSMutableArray * forwardDescArr = [[NSMutableArray alloc] initWithCapacity:0];
    for (int i = (int)(forwardArr.count-1); i> -1; i--)
    {//前15位或者前18位倒序存进数组
        [forwardDescArr addObject:forwardArr[i]];
    }
    
    NSMutableArray * arrOddNum = [[NSMutableArray alloc] initWithCapacity:0];//奇数位*2的积 < 9
    NSMutableArray * arrOddNum2 = [[NSMutableArray alloc] initWithCapacity:0];//奇数位*2的积 > 9
    NSMutableArray * arrEvenNum = [[NSMutableArray alloc] initWithCapacity:0];//偶数位数组
    
    for (int i=0; i< forwardDescArr.count; i++)
    {
        NSInteger num = [forwardDescArr[i] intValue];
        if (i%2)
        {//偶数位
            [arrEvenNum addObject:[NSNumber numberWithInteger:num]];
        }
        else
        {//奇数位
            if (num * 2 < 9)
            {
                [arrOddNum addObject:[NSNumber numberWithInteger:num * 2]];
            }
            else
            {
                NSInteger decadeNum = (num * 2) / 10;
                NSInteger unitNum = (num * 2) % 10;
                [arrOddNum2 addObject:[NSNumber numberWithInteger:unitNum]];
                [arrOddNum2 addObject:[NSNumber numberWithInteger:decadeNum]];
            }
        }
    }
    
    __block  NSInteger sumOddNumTotal = 0;
    [arrOddNum enumerateObjectsUsingBlock:^(NSNumber * obj, NSUInteger idx, BOOL *stop) {
        sumOddNumTotal += [obj integerValue];
    }];
    
    __block NSInteger sumOddNum2Total = 0;
    [arrOddNum2 enumerateObjectsUsingBlock:^(NSNumber * obj, NSUInteger idx, BOOL *stop) {
        sumOddNum2Total += [obj integerValue];
    }];
    
    __block NSInteger sumEvenNumTotal =0 ;
    [arrEvenNum enumerateObjectsUsingBlock:^(NSNumber * obj, NSUInteger idx, BOOL *stop) {
        sumEvenNumTotal += [obj integerValue];
    }];
    
    NSInteger lastNumber = [lastNum integerValue];
    
    NSInteger luhmTotal = lastNumber + sumEvenNumTotal + sumOddNum2Total + sumOddNumTotal;
    
    return (luhmTotal%10 ==0)?YES:NO;
}

/*! 判断字符串是否是字母或数字 */
+ (BOOL)ba_isLetterOrNumberString:(NSString *)string
{
    NSString *letterOrNumberRegex = @"[A-Z0-9a-z]+";
    NSPredicate *letterOrNumberTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", letterOrNumberRegex];
    return [letterOrNumberTest evaluateWithObject:string];
}




//////// 特殊字符的限制输入，价格金额的有效性判断

//#define myDotNumbers     @"0123456789.\n"
//#define myNumbers          @"0123456789\n"
//-(void) createTextFiled {
//    textfield1_ = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
//    textfield1_.delegate = self;
//    [self addSubview:textfield1_];
//    
//    textfield2_ = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
//    textfield2_.delegate = self;
//    [self addSubview:textfield2_];
//    
//    textfield3_ = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
//    textfield3_.delegate = self;
//    [self addSubview:textfield3_];
//    
//}
//
//-(void)showMyMessage:(NSString*)aInfo {
//    
//    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:aInfo delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//    [alertView show];
//    [alertView release];
//    
//}
//
//- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
//    NSCharacterSet *cs;
//    if ([textField isEqual:textfield1_]) {
//        cs = [[NSCharacterSet characterSetWithCharactersInString:myNumbers] invertedSet];
//        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
//        BOOL basicTest = [string isEqualToString:filtered];
//        if (!basicTest) {
//            [self showMyMessage:@"只能输入数字"];
//            return NO;
//        }
//    }
//    else if ([textField isEqual:textfield2_]) {
//        cs = [[NSCharacterSet characterSetWithCharactersInString:myNumbers] invertedSet];
//        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
//        BOOL basicTest = [string isEqualToString:filtered];
//        if (!basicTest) {
//            [self showMyMessage:@"只能输入数字"];
//            return NO;
//        }
//    }
//    else if ([textField isEqual:textfield3_]) {
//        NSUInteger nDotLoc = [textField.text rangeOfString:@"."].location;
//        if (NSNotFound == nDotLoc && 0 != range.location) {
//            cs = [[NSCharacterSet characterSetWithCharactersInString:myDotNumbers] invertedSet];
//        }
//        else {
//            cs = [[NSCharacterSet characterSetWithCharactersInString:myNumbers] invertedSet];
//        }
//        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
//        BOOL basicTest = [string isEqualToString:filtered];
//        if (!basicTest) {
//            
//            [self showMyMessage:@"只能输入数字和小数点"];
//            return NO;
//        }
//        if (NSNotFound != nDotLoc && range.location > nDotLoc + 3) {
//            [self showMyMessage:@"小数点后最多三位"];
//            return NO;
//        }
//    }
//    return YES;
//}
@end
