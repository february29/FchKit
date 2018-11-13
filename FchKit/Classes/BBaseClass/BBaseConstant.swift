//
//  BBaseConstant.swift
//  Fch_Contact
//
//  Created by bai on 2017/10/31.
//  Copyright © 2017年 北京仙指信息技术有限公司. All rights reserved.
//

import UIKit

/// 屏幕的宽
let BSCREENW = UIScreen.main.bounds.size.width
/// 屏幕的高
let BSCREENH = UIScreen.main.bounds.size.height

let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""

let isPad = UIDevice.current.userInterfaceIdiom == .pad
let isPhone = UIDevice.current.userInterfaceIdiom == .phone

let documentPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first ?? ""

let tempFolderPath = documentPath + "/temp"



typealias BBaseHandler = ()->Void;


func BLocalizedString(key:String) -> String{
    return Bundle.main.localizedString(forKey: key, value: nil, table: nil);

}

/// RGBA的颜色设置
func BRGBColor(r:CGFloat, g:CGFloat, b:CGFloat, a:CGFloat) -> UIColor {
    return UIColor(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: a)
}



/// 背景灰色
func BGlobalGrayColor() -> UIColor {
    return BRGBColor(r: 240, g: 240, b: 240, a: 1)
}

func BGlobalLineGrayColor() -> UIColor {
    return BRGBColor(r: 191, g: 191, b: 191, a: 1)
}

/// 红色
func BGlobalRedColor() -> UIColor {
    return BRGBColor(r: 166, g: 41, b: 40, a: 1.0)
}




