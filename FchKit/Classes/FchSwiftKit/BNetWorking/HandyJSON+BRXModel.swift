//
//  HandyJSON+BRXModel.swift
//  Fch_Contact
//
//  Created by bai on 2017/11/6.
//  Copyright © 2017年 北京仙指信息技术有限公司. All rights reserved.
//

import Foundation
import RxSwift
import Alamofire
import HandyJSON

//扩展ObservableType  用户解析json字符串
extension ObservableType where E == String {
    
    
    public func mapModel<T:HandyJSON>(_ type: T.Type,designatedPath: String? = nil) -> Observable<T?> {
        return flatMap { response -> Observable<T?> in
            
            return Observable<T?>.just(JSONDeserializer<T>.deserializeFrom(json: response, designatedPath: designatedPath));
            
        }
    }
    
    
    public func mapModelArray<T:HandyJSON>(_ type: T.Type,designatedPath: String? = nil) -> Observable<[T?]> {
        return flatMap { response -> Observable<[T?]> in
            
            return Observable<[T?]>.just(JSONDeserializer<T>.deserializeModelArrayFrom(json: response, designatedPath: designatedPath)!);
            
        }
    }
}



extension ObservableType where E == Any {
    
    
    public func mapModel<T:HandyJSON>(_ type: T.Type,designatedPath: String? = nil) -> Observable<T?> {
        return flatMap { response -> Observable<T?> in
            
            
            return Observable<T?>.just(JSONDeserializer<T>.deserializeFrom(dict: response as? NSDictionary, designatedPath: designatedPath));
            
        }
    }
    
    
    
}
