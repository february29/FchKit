//
//  BCheckBox.swift
//  FchKit
//
//  Created by bai on 2018/11/21.
//

import UIKit

open class BCheckBox: UIView {

    public typealias BCheckBoxClickBlock = (_ sender:BCheckBox,_ isSelected:Bool)-> Void
   
    public var checkButton = UIButton();
    public var titleLabel = UILabel();
    public var newCountLable = UILabel();
    
    /// 点击事件
    public var clickBlock:BCheckBoxClickBlock?
    
    public var title:String?{
        set{
            titleLabel.text = newValue;
        }
        get{
            return titleLabel.text;
        }
    }
    
    public var textFont:UIFont?{
        set{
            titleLabel.font = newValue;
        }
        get{
            return titleLabel.font;
        }
    }
    
    public var textColor:UIColor?{
        set{
            titleLabel.textColor = newValue;
        }
        get{
            return titleLabel.textColor;
        }
    }
    
    public var isSelected:Bool{
        set{
            checkButton.isSelected = newValue;
        }
        get{
            return checkButton.isSelected;
        }
    }
    public var newCount:String?{
        
        set{
            newCountLable.text = newValue;
            if newValue == "0"{
                newCountLable.isHidden = true;
            }else if newValue == "-1"{
                 newCountLable.isHidden = false;
            }else{
                newCountLable.isHidden = false;
            }
            
        }
        get{
            return newCountLable.text;
        }
    }
    
    
    public override init(frame: CGRect) {
        
        super.init(frame: frame);
       
        titleLabel.numberOfLines = 0;
        titleLabel.lineBreakMode = .byCharWrapping;
        titleLabel.isUserInteractionEnabled = true;
        let tap = UITapGestureRecognizer(target: self, action:  #selector(checkButtonAction));
        titleLabel.addGestureRecognizer(tap);
        
        checkButton.addTarget(self, action: #selector(checkButtonAction), for: .touchUpInside)
        
        newCountLable.backgroundColor = UIColor(r: 250, g: 91, b: 10);
        newCountLable.textColor = UIColor.white;
        newCountLable.textAlignment = .center;
        newCountLable.layer.cornerRadius = 5;
        newCountLable.layer.masksToBounds = true;
        newCountLable.font = UIFont.boldSystemFont(ofSize: 8.5);
        newCountLable.isHidden = true;
        
        
        self.addSubview(checkButton);
        self.addSubview(titleLabel);
        self.addSubview(newCountLable);
        
        
        checkButton.snp.makeConstraints { (make) in
            make.left.equalTo(self);
            make.top.equalTo(self);
            make.height.width.equalTo(18);
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(checkButton.snp.right).offset(5);
            make.top.equalTo(self);
            make.right.lessThanOrEqualTo(self);
            make.height.greaterThanOrEqualTo(18);
            
        }
        
        newCountLable.snp.makeConstraints { (make) in
            make.left.equalTo(titleLabel.snp.right);
            make.centerY.equalTo(titleLabel.snp.top);
            make.width.greaterThanOrEqualTo(10)
        }
        
        
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    public func setCheckImage(onImage:UIImage,offImage:UIImage) {
        checkButton.setImage(offImage, for: .normal);
        checkButton.setImage(onImage, for: .selected);
    }
    
    
    @objc func checkButtonAction(sender:UIButton) {
        checkButton.isSelected = !checkButton.isSelected
        if self.clickBlock != nil{
            self.clickBlock!(self,checkButton.isSelected);
        }
    }
    
}
