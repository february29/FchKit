//
//  BBaseNavigationViewController.swift
//  ReactiveCocoaDemo
//
//  Created by bai on 2017/10/27.
//  Copyright © 2017年 北京仙指信息技术有限公司. All rights reserved.
//

import UIKit

 class BBaseNavigationViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

//        self.navigationBar.setBarTintColor(.navBar)
//        self.navigationBar.setContentColor(.navBarTitle)
        self.navigationBar.isTranslucent = false;
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    

    
}
