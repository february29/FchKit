//
//  Array+BBase.swift
//  Fch_Contact
//
//  Created by bai on 2017/11/6.
//  Copyright © 2017年 北京仙指信息技术有限公司. All rights reserved.
//

import Foundation

extension Array{
    mutating func exchangeObjectAtIndex(IndexA:Int,atIndexB:Int)
    {
        if IndexA >= self.count || IndexA < 0{
            return
        }
        if atIndexB >= self.count || atIndexB < 0{
            return
        }
        let objA = self[IndexA]
        let objB = self[atIndexB]
        self.replaceObject(obj: objA, adIndex: atIndexB)
        self.replaceObject(obj: objB, adIndex: IndexA)
    }
    
    mutating func replaceObject(obj:Element,adIndex:Int){
        if adIndex >= self.count || adIndex < 0{
            return
        }
        self.remove(at: adIndex)
        self.insert(obj, at: adIndex)
    }
    
    mutating func merge(newArray:Array){
        for obj in newArray
        {
            self.append(obj)
        }
    }
}
