//
//  String+BMD5.swift
//  Fch_Contact
//
//  Created by bai on 2017/11/1.
//  Copyright © 2017年 北京仙指信息技术有限公司. All rights reserved.
//

import Foundation


extension String {
    
    
    /// 是否为空或者只有空格会车
    public var isBlank: Bool {
        let trimmed = trimmingCharacters(in: .whitespacesAndNewlines)
        return trimmed.isEmpty
    }
    
   
    
    /// 去除空格回车
    public func trimmed() -> String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
  
    
    /// 是否是数字
    public func isNumber() -> Bool {
        if let _ = NumberFormatter().number(from: self) {
            return true
        }
        return false
    }
    
    /// 转Int
    public func toInt() -> Int? {
        if let num = NumberFormatter().number(from: self) {
            return num.intValue
        } else {
            return nil
        }
    }
    
    /// 转Double
    public func toDouble() -> Double? {
        if let num = NumberFormatter().number(from: self) {
            return num.doubleValue
        } else {
            return nil
        }
    }
    
    /// 转Float
    public func toFloat() -> Float? {
        if let num = NumberFormatter().number(from: self) {
            return num.floatValue
        } else {
            return nil
        }
    }
    
    /// 转Bool
    public func toBool() -> Bool? {
        let trimmedString = trimmed().lowercased()
        if trimmedString == "true" || trimmedString == "false" {
            return (trimmedString as NSString).boolValue
        }
        return nil
    }
    
    
    
    /// 转NSString
    public var toNSString: NSString { return self as NSString }
    
//    #if os(iOS)
//    
//    /// 粗体NSAttributedString
//    public func bold(fontSize:CGFloat) -> NSAttributedString {
//        
//        let boldString = NSMutableAttributedString(string: self, attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: fontSize)])
//        return boldString
//    }
//    
//    #endif
//    
//    /// 下划线NSAttributedString
//    public func underline() -> NSAttributedString {
//        let underlineString = NSAttributedString(string: self, attributes: [NSAttributedStringKey.underlineStyle: NSUnderlineStyle.styleSingle.rawValue])
//        return underlineString
//    }
//    
//    #if os(iOS)
//    
//    /// 斜体NSAttributedString
//    public func italic(fontSize:CGFloat) -> NSAttributedString {
//        let italicString = NSMutableAttributedString(string: self, attributes: [NSAttributedStringKey.font: UIFont.italicSystemFont(ofSize: fontSize)])
//        return italicString
//    }
//    
//    #endif
//    #if os(iOS) || os(tvOS)
//    /// 颜色NSAttributedString
//    public func color(_ color: UIColor) -> NSAttributedString {
//        let colorString = NSMutableAttributedString(string: self, attributes: [NSAttributedStringKey.foregroundColor: color])
//        return colorString
//    }
//    
//    /// 子字符颜色NSAttributedString
//    public func colorSubString(_ subString: String, color: UIColor) -> NSMutableAttributedString {
//        var start = 0
//        var ranges: [NSRange] = []
//        while true {
//            let range = (self as NSString).range(of: subString, options: NSString.CompareOptions.literal, range: NSRange(location: start, length: (self as NSString).length - start))
//            if range.location == NSNotFound {
//                break
//            } else {
//                ranges.append(range)
//                start = range.location + range.length
//            }
//        }
//        let attrText = NSMutableAttributedString(string: self)
//        for range in ranges {
//            attrText.addAttribute(NSAttributedStringKey.foregroundColor, value: color, range: range)
//        }
//        return attrText
//
//    }
//
//    #endif

    
    public var isPhoneNumber:Bool
    {
        let mobile = "1[34578]([0-9]){9}";//"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$"
        let  CM = "^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$"
        let  CU = "^1(3[0-2]|5[256]|8[56])\\d{8}$"
        let  CT = "^1((33|53|8[09])[0-9]|349)\\d{7}$"
        let regextestmobile = NSPredicate(format: "SELF MATCHES %@",mobile)
        let regextestcm = NSPredicate(format: "SELF MATCHES %@",CM )
        let regextestcu = NSPredicate(format: "SELF MATCHES %@" ,CU)
        let regextestct = NSPredicate(format: "SELF MATCHES %@" ,CT)
        if ((regextestmobile.evaluate(with: self) == true)
            || (regextestcm.evaluate(with: self)  == true)
            || (regextestct.evaluate(with: self) == true)
            || (regextestcu.evaluate(with: self) == true))
        {
            return true
        }
        else
        {
            return false
        }
    }
    public var isTelNumber:Bool
    {
        
        
        if self.isPhoneNumber {
            return true;
        }
        
        
        let tel = "^0(10|2[0-5789]|\\d{3})(-)?\\d{7,8}$";
        
        let regextesttle = NSPredicate(format: "SELF MATCHES %@",tel)
        
        if (regextesttle.evaluate(with: self) == true)
        {
            return true
        }
        else
        {
            return false
        }
    }
    
    
    

    /// md5
//    var md5 : String{
//        let str = self.cString(using: String.Encoding.utf8)
//        let strLen = CC_LONG(self.lengthOfBytes(using: String.Encoding.utf8))
//        let digestLen = Int(CC_MD5_DIGEST_LENGTH)
//        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
//
//        CC_MD5(str!, strLen, result)
//
//        let hash = NSMutableString()
//        for i in 0 ..< digestLen {
//            hash.appendFormat("%02x", result[i])
//        }
//        result.deinitialize()
//
//        return String(format: hash as String)
//    }
    
    var toHexSring:String{
        
        let data = self.data(using: .utf8);
        return (data?.map { String(format: "%02x", $0) }.joined(separator: ""))!
    
    }
    
    var hexToSring:String?{

        var data = Data(capacity: self.count / 2)
        
        let regex = try! NSRegularExpression(pattern: "[0-9a-f]{1,2}", options: .caseInsensitive)
        regex.enumerateMatches(in: self, range: NSMakeRange(0, utf16.count)) { match, flags, stop in
            let byteString = (self as NSString).substring(with: match!.range)
            var num = UInt8(byteString, radix: 16)!
            data.append(&num, count: 1)
        }
        
       
        guard data.count > 0 else { return nil }
        return String.init(data: data, encoding: .utf8);

    }
    
    
    
    
    
}
