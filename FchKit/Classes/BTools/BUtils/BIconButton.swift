//
//  BIconButton.swift
//  linphone_Fch
//
//  Created by bai on 2018/8/14.
//

import UIKit
import SnapKit

public class BIconButton: UIView {
    
    
    public typealias ClickBlcok = (_ sender:UIView)->()
    
    
    public var clickBlock:ClickBlcok?
    
    public var imageEdgeInsets:UIEdgeInsets?{
        didSet{
            self.iconImageView.snp.remakeConstraints { (make) in
                make.left.equalTo(self).offset(imageEdgeInsets!.left)
                make.right.equalTo(self).offset(-imageEdgeInsets!.right)
                make.top.equalTo(self).offset(imageEdgeInsets!.top)
                make.bottom.equalTo(self).offset(-imageEdgeInsets!.bottom)
            }
        }
    }
    
    
    public var iconImageView:UIImageView = UIImageView();
    public var lable:UILabel = UILabel();
    public var redCountLable = UILabel();
    public var coverBtn = UIButton();
    
    

   
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.addSubview(iconImageView);
        self.addSubview(lable);
        self.addSubview(coverBtn);
        self.addSubview(redCountLable);
        
        
        iconImageView.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(self);
            make.height.equalTo(iconImageView.snp.width);
        }
        
        lable.textAlignment = .center;
        lable.font = UIFont.systemFont(ofSize: UIFont.buttonFontSize);
        lable.snp.makeConstraints { (make) in
            make.centerX.equalTo(iconImageView);
            make.top.equalTo(iconImageView.snp.bottom).offset(5);
            make.bottom.equalTo(self);
        }
        
        redCountLable.layer.cornerRadius = 4;
        redCountLable.layer.masksToBounds = true;
        redCountLable.textAlignment = .center;
        redCountLable.backgroundColor = UIColor.red;
        redCountLable.isHidden = true;
        redCountLable.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(10);
            make.right.equalTo(self).offset(-10);
            make.height.equalTo(8);
            make.width.greaterThanOrEqualTo(8);
        }
        
        coverBtn.addTarget(self, action: #selector(clickAction), for: .touchUpInside);
        coverBtn.snp.makeConstraints { (make) in
            make.edges.equalTo(self);
        }
       
        
        
    }
    
    
    @objc func clickAction()  {
        if self.clickBlock != nil{
            self.clickBlock!(self);
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
