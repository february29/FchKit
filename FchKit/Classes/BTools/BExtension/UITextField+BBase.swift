//
//  UITextField+BBase.swift
//  FchKit
//
//  Created by bai on 2018/11/21.
//

import UIKit

extension UITextField {

    public func addOffsetView(value:Float){
        let vOffset = UIView(frame: CGRect(x: 0, y: 0, width: CGFloat(value), height: self.frame.size.height))
        self.leftViewMode = .always
        self.leftView = vOffset
    }
    
    public func addOffsetLabel(width:Float,txt:NSMutableAttributedString) {
        let vOffset = UILabel(frame: CGRect(x: 0, y: 0, width: CGFloat(width), height: self.frame.size.height))
        vOffset.attributedText = txt
        self.leftViewMode = .always
        self.leftView = vOffset
    }
    
    public func setPlaceHolder(placeHolder:String,color:UIColor){
        
        let placeholserAttributes = [NSAttributedString.Key.foregroundColor : color,NSAttributedString.Key.font : self.font]
        self.attributedPlaceholder = NSAttributedString(string: placeHolder,attributes: placeholserAttributes as [NSAttributedString.Key : Any]);
        
    }
    
    
    
    
    
   
    
    
    
    
    
    

}
