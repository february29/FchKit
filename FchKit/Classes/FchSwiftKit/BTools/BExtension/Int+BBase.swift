//
//  Int+BBase.swift
//  AFNetworking
//
//  Created by bai on 2019/5/31.
//

import UIKit

extension Int {
    
    public static func randomIntNumber(lower: Int = 0,upper: Int = Int(UInt32.max)) -> Int {
        return lower + Int(arc4random_uniform(UInt32(upper - lower)))
    }

}
