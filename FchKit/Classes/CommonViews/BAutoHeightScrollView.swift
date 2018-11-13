//
//  BAutoHeightScrollView.swift
//  Fch_Contact
//
//  Created by bai on 2018/4/25.
//  Copyright © 2018年 北京仙指信息技术有限公司. All rights reserved.
//

import UIKit
import SnapKit

class BAutoHeightScrollView: UIScrollView {
    
    let contentView = UIView();
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.addSubview(contentView);
        
        contentView.snp.makeConstraints { (make) in
            make.edges.equalTo(self);
            make.width.equalTo(self);
            
        }
        
    }
    
    
    
    func setBottomView(view:UIView,offset:Float = 0)  {
        contentView.snp.remakeConstraints { (make) in
            make.edges.equalTo(self);
            make.width.equalTo(self);
            make.bottom.equalTo(view).offset(offset);
            
        }
    }
    
    

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
