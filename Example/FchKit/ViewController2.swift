//
//  ViewController2.swift
//  FchKit_Example
//
//  Created by bai on 2019/1/23.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit

class ViewController2: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
//        self.navigationController?.navigationBar.tintColor = UIColor.green;
        self.navigationController?.navigationBar.barTintColor =  UIColor.green;
        let  bar = self.navigationController?.navigationBar
        let item = self.navigationItem
        
        print("aaa");
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
