//
//  InsertSpaceLable.swift
//  FchKit
//
//  Created by bai on 2018/11/21.
//

import UIKit

public class InsertSpaceTextField: UITextField {

    override public func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 5, dy: 0);
    }
    
    override public func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 5, dy: 0);
    }
    
    
   

}
