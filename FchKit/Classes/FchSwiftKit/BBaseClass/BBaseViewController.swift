//
//  BBaseViewController.swift
//  ReactiveCocoaDemo
//
//  Created by bai on 2017/10/27.
//  Copyright © 2017年 北京仙指信息技术有限公司. All rights reserved.
//

import UIKit

import SnapKit



open class BBaseViewController: UIViewController {

    
    public typealias BBaseHandler = ()->Void;
    
//    var leftBtn:UIButton?;
    
    override  open func viewDidLoad() {
        super.viewDidLoad()

        //导航条颜色
        self.view.backgroundColor = UIColor.white;
//        self.navigationController?.navigationBar.barTintColor = UIColor.white;
//        self.navigationController?.navigationBar.isTranslucent = true;
        
        //左侧按钮

//        let leftBtnItem = UIBarButtonItem(image: #imageLiteral(resourceName: "btn_top_back"), style: .plain, target: self, action: #selector(BBaseViewController.back));
////        leftBtnItem.setTintColor(.navBarBtn);
//        self.navigationItem.leftBarButtonItem = leftBtnItem;
        
        
        
    }
    
    
    /// 显示系统提示框
    ///
    /// - Parameters:
    ///   - title: 标题
    ///   - message: 信息
    ///   - preferredStyle: 样式 默认alert
    ///   - cancleTitle: 取消按钮 默认"取消"
    ///   - okTitle: 确定按钮 默认"确定"
    ///   - cancleHandler: 取消回调 默认空
    ///   - OkHandler: 确定回调 默认空
    public func showAlert(title: String?, message: String?, preferredStyle: UIAlertController.Style? = .alert,cancleTitle: String? = "取消",okTitle: String? = "确定", cancleHandler:BBaseHandler? = nil,OkHandler:BBaseHandler? = nil) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: preferredStyle ?? UIAlertController.Style.alert );
        
        //取消按钮必须有
        let cancleAction = UIAlertAction(title: cancleTitle, style: .cancel, handler: { (alertVC) in
            if let cancle = cancleHandler {
                cancle();
            }
        })
        alertVC.addAction(cancleAction);
        
        //确定按钮可有可无
        if let ok = OkHandler {
            let okAction = UIAlertAction(title: okTitle, style: .default, handler: { (alertVC) in
                ok();
            })
            alertVC.addAction(okAction);
        }
        
        self .present(alertVC, animated: true, completion: nil);
    }
    

   
    
    @objc func back() {
        if let nv = self.navigationController {
            nv.popViewController(animated: true);
        }
    }
    

   
}
