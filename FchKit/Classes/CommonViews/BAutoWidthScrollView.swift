//
//  BAutoWidthScrollView.swift
//  Fch_Contact
//
//  Created by bai on 2018/9/14.
//  Copyright © 2018年 北京仙指信息技术有限公司. All rights reserved.
//

import UIKit

open class BAutoWidthScrollView: UIScrollView {

    public let contentView = UIView();
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.addSubview(contentView);
        
        contentView.snp.makeConstraints { (make) in
            make.edges.equalTo(self);
            make.height.equalTo(self);
            
        }
        
    }
    
    
    
    public func setRightView(view:UIView,offset:Float = 0)  {
        contentView.snp.remakeConstraints { (make) in
            make.edges.equalTo(self);
            make.height.equalTo(self);
            make.right.equalTo(view).offset(offset);
            
        }
    }
    
    
    public func setwidth(width:CGFloat)  {
        contentView.snp.remakeConstraints { (make) in
            make.edges.equalTo(self);
            make.height.equalTo(self);
            make.width.equalTo(width);
        }
    }
    
    
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
