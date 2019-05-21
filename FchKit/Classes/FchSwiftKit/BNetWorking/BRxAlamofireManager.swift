//
//  BRxNetWorkingManager.swift
//  Fch_Contact
//
//  Created by bai on 2019/1/11.
//  Copyright © 2019 北京仙指信息技术有限公司. All rights reserved.
//

import UIKit
import RxSwift
import Alamofire
import HandyJSON

extension BAlamofireManager{
    
    //-------------------------------rx方法----------------------------------
    
    func RxRequset(url:String,method:HTTPMethod = .get,parameters:[String:Any]? = nil)->Observable<Result<Any>> {
        return Observable.create({ (observer) -> Disposable in
            
            
            let request = self.sessionManager.request( url, method: method, parameters: parameters).responseJSON(completionHandler: { (response) in
                let result = response.result
                switch result {
                case .success:
                    observer.onNext(result)
                    observer.onCompleted()
                case let .failure(error):
                    observer.onError(error)
                }
            });
            
            return Disposables.create() {
                request.cancel()
            }
        }).debug("Http");
    }
    
    func RxRequsetString(url:String,method:HTTPMethod = .get,parameters:[String:Any])->Observable<String> {
        
        
        return Observable.create({ (observer) -> Disposable in
            
            
            let request = self.sessionManager.request( url, method: method, parameters: parameters).responseString(completionHandler: { (response) in
                
                
                let result = response.result
                switch result {
                case let .success(result):
                    observer.onNext(result);
                    observer.onCompleted();
                case let .failure(error):
                    observer.onError(error);
                }
                
            })
            
            return Disposables.create() {
                request.cancel();
            }
        }).debug("Http");
    }
    
}
