//
//  BaseDefine.h
//  slwl_yq
//
//  Created by bai on 16/4/20.
//  Copyright © 2016年 bai.xianzhi. All rights reserved.
//

#ifndef BaseDefine_h
#define BaseDefine_h

#define TEXTBLACKCOLOR [UIColor blackColor]

#define COLORWITHRGB(R,G,B,ALPHA) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:ALPHA]
#define KWIDTH [UIScreen mainScreen].bounds.size.width

#define TEXTGREENCOLOR [UIColor colorWithRed:(44 / 255.0) green:(145 / 255.0) blue:(99 / 255.0) alpha:1]
#define TEXTGREENCOLOR2 [UIColor colorWithRed:(46 / 255.0) green:(243 / 255.0) blue:(74 / 255.0) alpha:1]
#define TEXTGREENCOLOR3 [UIColor colorWithRed:112/255.0 green:243/255.0 blue:238/255.0 alpha:1]
#define TEXTGRAYCOLOR [UIColor colorWithWhite:0.25f alpha:1]

#define TEXTLIGTHGRAYCOLOR [UIColor colorWithWhite:0.50f alpha:1]

#define TEXTREDCOLOR [UIColor colorWithRed:228/255.0 green:71/255.0 blue:71/255.0 alpha:1]

#define TEXTBLUECOLOR [UIColor colorWithRed:125/255.0 green:166/255.0 blue:212/255.0 alpha:1]
#define TEXTBLUECOLOR1 [UIColor colorWithRed:209/255.0 green:231/255.0 blue:253/255.0 alpha:1]
#define TEXTBLUECOLOR2 [UIColor colorWithRed:13/255.0 green:99/255.0 blue:165/255.0 alpha:1]
#define TEXTBLUECOLOR3 [UIColor colorWithRed:0/255.0 green:89/255.0 blue:186/255.0 alpha:1]
#define TEXTBLUECOLOR4 [UIColor colorWithRed:80/255.0 green:185/255.0 blue:249/255.0 alpha:1]
#define TEXTBLUECOLOR5 [UIColor colorWithRed:30/255.0 green:189/255.0 blue:255/255.0 alpha:1]
#define TEXTBLUECOLOR6 [UIColor colorWithRed:193/255.0 green:218/255.0 blue:255/255.0 alpha:1]

//#define TEXTBLUECOLOR6 [UIColor colorWithRed:193/255.0 green:118/255.0 blue:255/255.0 alpha:1]

#define TEXTYELLOWCOLOR [UIColor colorWithRed:235/255.0 green:199/255.0 blue:0/255.0 alpha:1]
#define TEXTYELLOWCOLOR2 [UIColor colorWithRed:255/255.0 green:209/255.0 blue:45/255.0 alpha:1]
#define TEXTYELLOWCOLOR3 [UIColor colorWithRed:241/255.0 green:162/255.0 blue:58/255.0 alpha:1]
//#define GLOBLEGRAY [UIColor colorWithWhite:0.50f alpha:1]
#define GLOBLEBACKGREEN [UIColor colorWithRed:56/255.0 green:173/255.0 blue:31/255.0 alpha:1]
#define ALPHABACKGREEN [UIColor colorWithRed:21/255.0 green:49/255.0 blue:82/255.0 alpha:0.7]

#define GLOBLEBACKBLUE [UIColor colorWithRed:38/255.0 green:204/255.0 blue:215/255.0 alpha:1]

//#define GLOBLEBACKBLUE2 [UIColor colorWithRed:69/255.0 green:147/255.0 blue:222/255.0 alpha:1]
#define GLOBLEBACKBLUE2 [UIColor colorWithRed:23/255.0 green:148/255.0 blue:200/255.0 alpha:1]



#define RWBACKBLUE1 [UIColor colorWithRed:23/255.0 green:158/255.0 blue:149/255.0 alpha:1]
#define RWBACKBLUE2 [UIColor colorWithRed:34/255.0 green:158/255.0 blue:196/255.0 alpha:1]
#define RWBACKBLUE3 [UIColor colorWithRed:65/255.0 green:149/255.0 blue:173/255.0 alpha:1]
#define RWBACKBLUE4 [UIColor colorWithRed:35/255.0 green:117/255.0 blue:143/255.0 alpha:1]

#define RWBUTTONBACKBLUE [UIColor colorWithRed:50/255.0 green:61/255.0 blue:106/255.0 alpha:1]
#define RWBACKGREEN [UIColor colorWithRed:23/255.0 green:158/255.0 blue:149/255.0 alpha:1]

#define RWBACKYELLOW [UIColor colorWithRed:234/255.0 green:105/255.0 blue:72/255.0 alpha:1]


#define SREYELLOW [UIColor colorWithRed:249/255.0 green:188/255.0 blue:46/255.0 alpha:1]
#define SRERED [UIColor colorWithRed:255/255.0 green:0/255.0 blue:0/255.0 alpha:1]
#define SREGREEN [UIColor colorWithRed:45/255.0 green:183/255.0 blue:75/255.0 alpha:1]

#define GLOBLEBACKGRAY [UIColor colorWithWhite:0.93f alpha:1]
#define GLOBLEBACKGRAY2 [UIColor colorWithRed:239/255.0 green:243/255.0 blue:246/255.0 alpha:1]

#define GLOBLEBACKPINK [UIColor colorWithRed:250/255.0 green:235/255.0 blue:236/255.0 alpha:1]



#define GLOBLEBACKYELLOW [UIColor colorWithRed:255/255.0 green:175/255.0 blue:0/255.0 alpha:1]
#define GLOBLEBACKRED [UIColor colorWithRed:247/240.0 green:88/255.0 blue:94/255.0 alpha:1]

#define GLOBLENEVBGGRAY [UIColor colorWithRed:241/255.0 green:242/255.0 blue:243/255.0 alpha:1]
#define GLOBLEORANGE [UIColor orangeColor]
//#define TABLESECTIONCOLOR [UIColor colorWithRed:(254 / 255.0) green:(223 / 255.0) blue:(141 / 255.0) alpha:1]



#define MSCW [UIScreen mainScreen].bounds.size.width
#define MSCH [UIScreen mainScreen].bounds.size.height

#define BIsIPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)
#define BTabBarH self.tabBarController.tabBar.frame.size.height


//根据屏幕方向决定宽度高度
#define BSCREEN_WIDTH ((([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortrait) || ([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortraitUpsideDown)) ? [[UIScreen mainScreen] bounds].size.width : [[UIScreen mainScreen] bounds].size.height)
#define BSCREEN_HEIGHT ((([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortrait) || ([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortraitUpsideDown)) ? [[UIScreen mainScreen] bounds].size.height : [[UIScreen mainScreen] bounds].size.width)
//根据屏幕宽度适配文字大小


#define GlobleMarginLeft 6
#define GlobleMarginTop 8



#define FONT_SUPPERLARGE 17
#define FONT_LARGE 16
#define FONT_MIDDLE 15
#define FONT_NORMAL 14
#define FONT_MIDDLENSMALL 13
#define FONT_SMALL 12
#define FONT_SUPERSMALL 11


#define FONTSUPPERLARGE [UIFont systemFontOfSize:FONT_SUPPERLARGE]
#define FONTLARGE [UIFont systemFontOfSize:FONT_LARGE]
#define FONTMIDDLE [UIFont systemFontOfSize:FONT_MIDDLE]
#define FONTNORMAL [UIFont systemFontOfSize:FONT_NORMAL]
#define FONTMIDDLESMALLER [UIFont systemFontOfSize:FONT_MIDDLENSMALL]
#define FONTSMALLER [UIFont systemFontOfSize:FONT_SMALL]
#define FONTSUPERSMALLER [UIFont systemFontOfSize:FONT_SUPERSMALL]



/// 以iPhone6为基准
#define SCALE MAX((MSCW / 375.0),1.0)
#define kScale(value) ceil((MAX((MSCW / 375.0),1.0) * (value)))
/// 默认字体
#define FONT(size)  [UIFont systemFontOfSize:kScale(size)]
/// 粗体
#define BOLDFONT(size)  [UIFont boldSystemFontOfSize:kScale(size)]



//修改正式测试环境地址在SJTNetWorkingChangeHelper 中处理
//=======================正式环境=======================

//外网正式
#define BASE_RUL @"http://124.88.168.158"
#define BASEURL_1 [NSString stringWithFormat:@"%@:%@",BASE_RUL,@"8280"]
#define BASEURL_2 [NSString stringWithFormat:@"%@:%@",BASE_RUL,@"8098"]
#define BASEURL_Risk [NSString stringWithFormat:@"%@/%@",BASEURL_2,@"backend/web"]


//=======================测试=======================
//#define TEST_BASE_RUL @"http://10.10.2.231"
//#define TEST_BASEURL_1 [NSString stringWithFormat:@"%@:%@",TEST_BASE_RUL,@"9180"]
//#define TEST_BASEURL_2 [NSString stringWithFormat:@"%@:%@",TEST_BASE_RUL,@"30002"]
//#define TEST_BASEURL_Risk [NSString stringWithFormat:@"%@/%@",TEST_BASEURL_2,@"backend/web"]

#define TEST_BASE_RUL @"http://10.10.2.232"
#define TEST_BASEURL_1 [NSString stringWithFormat:@"%@:%@",TEST_BASE_RUL,@"8680"]
#define TEST_BASEURL_2 [NSString stringWithFormat:@"%@:%@",TEST_BASE_RUL,@"30002"]
#define TEST_BASEURL_Risk [NSString stringWithFormat:@"%@/%@",TEST_BASEURL_2,@"backend/web"]






#endif /* BaseDefine_h */
