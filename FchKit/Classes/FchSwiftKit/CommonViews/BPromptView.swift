//
//  BAlertView.swift
//  FchKit
//
//  Created by bai on 2018/11/26.
//

import UIKit

public class BPromptView: UIView {
    
    
    public typealias BPromptViewBlock = ()->Void
    
    public var okButtonClickBlock:BPromptViewBlock?
    public var cancleButtonClickBlock:BPromptViewBlock?
    
    
    lazy public var titleLable: UILabel = {
        let temp  = UILabel();
        temp.font = UIFont.systemFont(ofSize: 18);
        temp.textAlignment = .center;
        temp.text = "提示";
        return temp;
    }()
    lazy public var promptImageView: UIImageView = {
        let temp  = UIImageView();
        return temp;
    }()
    lazy public var infoLable: UILabel = {
        let temp  = UILabel();
        temp.font = UIFont.systemFont(ofSize: 16);
        temp.textAlignment = .center;
        temp.numberOfLines = 0;
        temp.text = "";
        return temp;
    }()
    
    lazy public var lineView: UIView = {
        let temp  = UIView();
        temp.backgroundColor = UIColor(white: 0.93, alpha: 1);
        return temp;
    }()
    
    lazy public var lineView2: UIView = {
        let temp  = UIView();
        temp.backgroundColor = UIColor(white: 0.93, alpha: 1);
        return temp;
    }()
    
    
    lazy public var okButton: UIButton = {
        let temp  = UIButton();
        temp.titleLabel?.font = UIFont.systemFont(ofSize: 17);
        temp.setTitle("确定", for: .normal);
        temp.setTitleColor(UIColor(red: 228/255.0, green: 71/255.0, blue: 71/255.0, alpha: 1), for: .normal);
        temp.addTarget(self, action: #selector(okButtonClick), for: .touchUpInside);
        return temp;
        
    }()
    lazy public var cancelBtn: UIButton = {
        let temp  = UIButton();
        temp.titleLabel?.font = UIFont.systemFont(ofSize: 17);
        temp.setTitle("取消", for: .normal);
        temp.setTitleColor(UIColor(red: 228/255.0, green: 71/255.0, blue: 71/255.0, alpha: 1), for: .normal);
        temp.addTarget(self, action: #selector(cancelButtonClick), for: .touchUpInside);
        return temp;
    }()
    
    
    
    //MARK: 按钮点击
    @objc func okButtonClick() {
        if okButtonClickBlock != nil {
            self.okButtonClickBlock!();
        }
    }
    
    @objc func cancelButtonClick() {
        if cancleButtonClickBlock != nil {
            self.cancleButtonClickBlock!();
        }
    }
    
    //MARK: 构造器
    public override init(frame: CGRect) {
        super.init(frame: frame);
        self.backgroundColor = UIColor.white;
        self.layer.cornerRadius = 7;
        self.layer.masksToBounds = true;
    }
    
    convenience public init(title:String,message:String,okBtnTitle:String,cancelBtnTitle:String?,image:UIImage?) {
        self.init();
        self.addSubview(self.titleLable);
        self.titleLable.snp.makeConstraints { (make) in
            make.top.equalTo(self);
            make.left.equalTo(self).offset(10);
            make.right.equalTo(self).offset(-10);
            make.height.equalTo(45);
        }
        
        if image != nil{
            self.addSubview(self.promptImageView);
            self.promptImageView.snp.makeConstraints { (make) in
                make.top.equalTo(self.titleLable.snp.bottom);
                make.centerX.equalTo(self);
                make.height.width.equalTo(80);
            }
            
        }
        
        self.addSubview(self.infoLable);
        self.infoLable.snp.makeConstraints { (make) in
            
            if image != nil{
                make.top.equalTo(self.promptImageView.snp.bottom).offset(10);
            }else{
                make.top.equalTo(self.titleLable.snp.bottom);
            }
            make.left.equalTo(self).offset(25);
            make.right.equalTo(self).offset(-25);
        }
        
        self.addSubview(self.lineView);
        self.lineView.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.infoLable.snp.bottom).offset(15);
            make.left.equalTo(self);
            make.right.equalTo(self);
            make.height.equalTo(1);
        }
        
        
        self.addSubview(self.okButton)
        self.okButton.snp.makeConstraints { (make) in
            make.top.equalTo(self.lineView.snp.bottom);
            make.right.equalTo(self);
            if (cancelBtnTitle != nil) {
                make.left.equalTo(self.snp.centerX);
            }else{
                make.left.equalTo(self);
            }
            make.height.equalTo(45);
        }
        
       
        if cancelBtnTitle != nil {
            self.addSubview(self.cancelBtn);
            self.cancelBtn.snp.makeConstraints { (make) in
                make.top.equalTo(self.okButton);
                make.left.equalTo(self);
                make.right.equalTo(self.snp.centerX);
                make.height.equalTo(okButton);
            }
            
            self.addSubview(self.lineView2);
            self.lineView2.snp.makeConstraints { (make) in
                make.top.equalTo(self.lineView.snp.bottom);
                make.bottom.equalTo(cancelBtn);
                make.centerX.equalTo(self);
                make.width.equalTo(1);
            }
        }
        
        self.titleLable.text = title;
        self.promptImageView.image = image;
        self.infoLable.text = message;
        self.okButton .setTitle(okBtnTitle, for: .normal);
        self.cancelBtn.setTitle(cancelBtnTitle, for: .normal);
        
        
        self.layoutIfNeeded();

        self.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width*0.75, height: self.okButton.frame.origin.y + self.okButton.frame.size.height)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   
    

}
