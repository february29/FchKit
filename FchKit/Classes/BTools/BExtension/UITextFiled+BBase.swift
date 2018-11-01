//
//  UITextFiled+Base.swift
//  Fch_Contact
//
//  Created by bai on 2017/11/6.
//  Copyright © 2017年 北京仙指信息技术有限公司. All rights reserved.
//

import UIKit

extension UITextField{
    
    func addOffsetView(value:Float){
        let vOffset = UIView(frame: CGRect(x: 0, y: 0, width: CGFloat(value), height: self.frame.size.height))
        self.leftViewMode = .always
        self.leftView = vOffset
    }
    
    func addOffsetLabel(width:Float,txt:NSMutableAttributedString) {
            let vOffset = UILabel(frame: CGRect(x: 0, y: 0, width: CGFloat(width), height: self.frame.size.height))
            vOffset.attributedText = txt
            self.leftViewMode = .always
            self.leftView = vOffset
    }
}

