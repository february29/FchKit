//
//  BDateTool.swift
//  Fch_Contact
//
//  Created by bai on 2017/11/22.
//  Copyright © 2017年 北京仙指信息技术有限公司. All rights reserved.
//

import UIKit

public class BDateTool {

    
    public static let sharedInstance = BDateTool();
    private init() { };
    
    
    public func timeIntervalSince1970FromDate(date:Date) -> TimeInterval {
        return date.timeIntervalSince1970*1000;
    }
    
    public func timeIntervalSince1970FromTimeString(timeString:String,formatter:String) -> TimeInterval {
        
        let date = self.dateFromTimeString(timeString: timeString, formatter: formatter);
        return date.timeIntervalSince1970*1000;
    }
    
    
    public func dateFromTimeInterval(timeInterval:TimeInterval) -> Date {
        return Date(timeIntervalSince1970: timeInterval/1000);
    }
    
    public func dateFromTimeString(timeString:String,formatter:String) -> Date {
        let dateformatter = DateFormatter();
        dateformatter.locale = Locale(identifier: "zh_CN") ;
        dateformatter.dateFormat = formatter;
        return dateformatter.date(from: timeString)!.addingTimeInterval(60*60*8);
    }
    
    public func dateFromGMTTimeString(timeString:String) -> Date {
        
        
        let startIndex = timeString.index(timeString.startIndex, offsetBy: 5)
        let endIndex = timeString.index(timeString.endIndex,offsetBy: -4)
        let result = timeString.substring(with: startIndex..<endIndex)
       
        let dateformatter = DateFormatter();
        dateformatter.locale = Locale(identifier: "en_US") ;
        dateformatter.dateFormat = "dd MMM yyyy HH:mm:ss";
        return dateformatter.date(from: result)!.addingTimeInterval(60*60*8);
    }
    
    public func timeStringFromDate(date:Date,formatter:String) -> String {
        let dateformatter = DateFormatter();
        dateformatter.dateFormat = formatter;
        return dateformatter.string(from: date as Date);
    }
    
    public func timeStringFromTimeInterval(timeInterval:TimeInterval,formatter:String) -> String {
        let date = Date(timeIntervalSince1970: timeInterval/1000);
        return self.timeStringFromDate(date: date, formatter: formatter);
    }
    
    
    
    
}
