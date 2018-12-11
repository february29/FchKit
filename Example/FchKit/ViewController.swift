//
//  ViewController.swift
//  FchKit
//
//  Created by february29 on 10/31/2018.
//  Copyright (c) 2018 february29. All rights reserved.
//

import UIKit
import FchKit
import BAlert

class ViewController: UIViewController {
    
    let scrollerView: BAutoHeightScrollView = {
        let temp = BAutoHeightScrollView();
        return temp
    }()
    
    let checkbox: BCheckBox = {
        let temp = BCheckBox();
        temp.setCheckImage(onImage:UIImage(named: "login_check_on")!, offImage: UIImage(named: "login_check")!);
        temp.title = "ffdfasdf"
        temp.newCount = "2";
        temp.clickBlock = {(_,_)in
            print("click")
        }
        return temp
    }()
    
    let rightViewTF: BRightViewTextField = {
        let temp = BRightViewTextField();
        temp.rightImageView.image = UIImage(named: "login_check_on");
        temp.layer.borderWidth = 1;
        temp.layer.borderColor = UIColor.blue.cgColor;
      
        temp.rightImageView.snp.remakeConstraints({ (make) in
            make.centerY.equalTo(temp);
            make.right.equalTo(temp);
            make.width.height.equalTo(20);
            
        })
        temp.clickBlock = {(textField)in
            print("click")
            
//            let view = BPromptView(title: "客服哦", message: "法拉利短裤", okBtnTitle: "我知道了", cancelBtnTitle: nil, image: nil)
            let view = BPromptView(title: "客服哦", message: "法拉利短裤", okBtnTitle: "我知道了", cancelBtnTitle: "取消", image: nil)
            view.okButtonClickBlock = {()in
                BAlert.sharedInstance.hide(view: view);
            }
        
//            view.frame = CGRect(x: 0, y: 0, width: 350, height: 300);
            BAlert.sharedInstance.normalShow(view: view)
            
        }
        
        return temp;
    }()
    
    let inforView: BInfoView = {
        let temp = BInfoView.init(style: BInfoViewStyle.BInfoViewHorizontal);
//        let temp = BInfoView.init(style: BInfoViewStyle.BInfoViewvertical);
        
        temp.promptLabel.text = "name:"
        temp.infoLabel.text = "999000\ndd99hjjfkk-----------------------------------kkkkkkk";
        return temp ;
    }()
    
    let placeHolderTextView: BPlaceHolderTextView = {
        let temp = BPlaceHolderTextView();
        temp.layer.borderWidth = 1;
        temp.layer.borderColor = UIColor.blue.cgColor;
        temp.font = UIFont.systemFont(ofSize: 14);
        temp.placeholder = "请输入内容";
        return temp ;
    }()
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
//        print(Date().toString())
        
//        BDateTool.sharedInstance.timeIntervalSince1970FromDate(date: <#T##Date#>)
        
//        BStringTool.trimNil(str: <#T##String?#>)
        
    

        self.view.addSubview(self.scrollerView);
        
        self.scrollerView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view);
        }
        
        
        
        let tf = UITextField();
        tf.setPlaceHolder(placeHolder: "ddd", color: UIColor.purple);
        self.scrollerView.contentView.addSubview(tf);
        tf.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.scrollerView.contentView);
            make.top.equalTo(self.scrollerView.contentView).offset(100);
            make.width.equalTo(100);
            make.height.equalTo(40);
        }
        
        
       
        self.scrollerView.contentView.addSubview(self.checkbox)
        self.checkbox.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.scrollerView.contentView);
            make.top.equalTo(self.scrollerView.contentView).offset(200);
            make.width.equalTo(100);
            make.height.equalTo(40);
        }
        
        self.scrollerView.contentView.addSubview(self.rightViewTF);
        self.rightViewTF.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.scrollerView.contentView);
            make.top.equalTo(self.checkbox.snp.bottom).offset(20);
            make.width.equalTo(100);
            make.height.equalTo(40);
        }
        
        
        self.scrollerView.contentView.addSubview(self.inforView);
        self.inforView.snp.makeConstraints { (make) in
            
            make.top.equalTo(self.rightViewTF.snp.bottom).offset(20);
            make.left.equalTo(self.scrollerView.contentView).offset(20);
            make.right.equalTo(self.scrollerView.contentView).offset(-20);
            make.bottom.equalTo(self.inforView.infoLabel);
           
        }
        
        self.scrollerView.contentView.addSubview(self.placeHolderTextView);
        self.placeHolderTextView.snp.makeConstraints { (make) in
            
            make.top.equalTo(self.inforView.snp.bottom).offset(20);
            make.left.equalTo(self.scrollerView.contentView).offset(20);
            make.right.equalTo(self.scrollerView.contentView).offset(-20);
            make.height.equalTo(200);
            
        }
        
        
        
        
        
        
        self.scrollerView.setBottomView(view:self.placeHolderTextView);
        
        
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    
    
    
    
    

}

