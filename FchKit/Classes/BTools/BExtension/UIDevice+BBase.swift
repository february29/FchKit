//
//  UIDevice+BBase.swift
//  Fch_Contact
//
//  Created by bai on 2017/12/1.
//  Copyright © 2017年 北京仙指信息技术有限公司. All rights reserved.
//

import Foundation
import UIKit

extension UIDevice {
    static func isIPhoneX() -> Bool {
        
//        BIsIPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)
//        UIScreen.main.currentMode?.size = CGSize(width: 1125, height: 2436);
        
        if UIScreen.main.bounds.height == 812 {
            return true
        }
        
        return false
    }
    
    static func versionGreatThanOrEqual(version:String) -> Bool{
        let result =  self.current.systemVersion.compare(version);
        
        if result == .orderedAscending{
            return false;
        }else{
            return true;
        }
        
    }
    
}
