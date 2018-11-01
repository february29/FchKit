//
//  BStringTool.swift
//  linphone_Fch
//
//  Created by bai on 2018/7/13.
//

import UIKit

class BStringTool {
    
    static let sharedInstance = BStringTool();
    private init() { };
    
    class func trimNil(str:String?) -> String{
        return str == nil ? "":str!;
    }

}
