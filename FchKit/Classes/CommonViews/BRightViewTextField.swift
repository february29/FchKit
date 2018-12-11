//
//  BRightViewTextField.swift
//  FchKit
//
//  Created by bai on 2018/11/26.
//

import UIKit
import SnapKit

public class BRightViewTextField: UITextField {
    
    
    public typealias BRigthViewTextFieldClickBlock = (_ sender:BRightViewTextField)-> Void
   
    public var clickBlock:BRigthViewTextFieldClickBlock?
    public var coverBtn = UIButton();
    
    /// 默认位置最右端，宽度等于高度
    public var rightImageView = UIImageView();
    

    override public func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 5, dy: 0);
    }
    
    override public func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 5, dy: 0);
    }
    
    
    public override init(frame: CGRect) {
        super.init(frame: frame);
        
        
        coverBtn.addTarget(self, action: #selector(clickAction), for: .touchUpInside)
        
        self.addSubview(rightImageView);
        self.addSubview(coverBtn);
        
        rightImageView.snp.makeConstraints { (make) in
            make.right.equalTo(self);
            make.height.equalTo(self);
            make.width.equalTo(rightImageView.snp.height);
            make.centerY.equalTo(self);
        }
        
        coverBtn.snp.makeConstraints { (make) in
            make.edges.equalTo(self);
        }
        
    }
    
    @objc func clickAction() {
        if self.clickBlock != nil {
            self.clickBlock!(self);
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
