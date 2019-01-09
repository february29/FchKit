//
//  BBaseConstant.swift
//  Fch_Contact
//
//  Created by bai on 2017/10/31.
//  Copyright © 2017年 北京仙指信息技术有限公司. All rights reserved.
//

import UIKit

/// 屏幕的宽
let BAdapterScreenW = UIScreen.main.bounds.size.width
/// 屏幕的高
let BAdapterScreenH = UIScreen.main.bounds.size.height

let BAdapterReference:CGFloat = 375.0;

extension UIFont{
    class func adapterFont(ofSize:CGFloat) -> UIFont {
        return self.systemFont(ofSize: ofSize.adapterValue())
        
    }
    
    class func adapterBlodFont(ofSize:CGFloat) -> UIFont {
        return self.boldSystemFont(ofSize:ofSize.adapterValue())
    }
    
    
    
    
    
}

extension CGFloat {
    func adapterValue() -> CGFloat {
        return self * (BAdapterScreenW / BAdapterReference);
    }
}

extension Float{
    func adapterValue() -> Float {
        return self * Float((BAdapterScreenW / BAdapterReference));
    }
}
extension Double{
    func adapterValue() -> Double {
        return self * Double((BAdapterScreenW / BAdapterReference));
    }
}
extension Int{
    func adapterValue() -> Int {
        return Int(CGFloat(self) * (BAdapterScreenW / BAdapterReference));
    }
}







