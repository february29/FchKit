//
//  BInfoView.swift
//  FchKit
//
//  Created by bai on 2018/11/26.
//

import UIKit

public enum BInfoViewStyle{
    case BInfoViewHorizontal;
    case BInfoViewvertical;
    
}

public class BInfoView: UIView {
    
  
    

    public let promptLabel:UILabel = {
        let temp = UILabel();
        temp.font = UIFont.systemFont(ofSize: 14);
        return temp;
    }()
    
   
    public let infoLabel:UILabel = {
        let temp = UILabel();
        temp.numberOfLines = 0;
        temp.lineBreakMode = .byCharWrapping;
        temp.font = UIFont.systemFont(ofSize: 14);
        return temp;
    }()
    
    public var style:BInfoViewStyle?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.addSubview(self.promptLabel);
        self.addSubview(self.infoLabel);
        
    }
    
    convenience public init(style:BInfoViewStyle) {
        self.init();
        self.style = style;
        
        switch style {
        case .BInfoViewvertical:
            self.promptLabel.snp.makeConstraints { (make) in
                make.left.right.equalTo(self);
                make.top.equalTo(self);
            }
            self.infoLabel.snp.makeConstraints { (make) in
                make.left.right.equalTo(promptLabel);
                make.top.equalTo(promptLabel.snp.bottom);
            }
            self.setContentHuggingPriority(.required, for: .vertical);
            self.setContentCompressionResistancePriority(.required, for: .vertical);
            
            
        default:
            self.promptLabel.snp.makeConstraints { (make) in
                make.left.equalTo(self);
                make.top.equalTo(self);
            }
            self.infoLabel.snp.makeConstraints { (make) in
                make.left.equalTo(promptLabel.snp.right);
                make.top.equalTo(promptLabel);
                make.right.equalTo(self);
                make.height.greaterThanOrEqualTo(self.promptLabel);
            }
            self.setContentHuggingPriority(.required, for: .horizontal);
            self.setContentCompressionResistancePriority(.required, for: .horizontal);
        }
        
       
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
