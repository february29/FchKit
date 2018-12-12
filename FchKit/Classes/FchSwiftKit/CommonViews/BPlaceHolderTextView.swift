//
//  BPlaceHolderTextView.swift
//  FchKit
//
//  Created by bai on 2018/11/26.
//

import UIKit

public class BPlaceHolderTextView: UITextView {
    
    
    
    public let placeHolderLabel: UILabel = {
        let temp = UILabel();
        temp.lineBreakMode = .byWordWrapping;
        
        temp.numberOfLines = 0;
        
        
        temp.backgroundColor = UIColor.clear;
        temp.alpha = 0;
        temp.tag = 999;
        return temp;
    }()
    
    public override var text: String!{
        set{
            super.text = newValue;
            self.textChanged();
        }
        get{
            return super.text;
        }
    }
    
    
    
    
    
    public var placeholder:String?{
        set{
            placeHolderLabel.text = newValue;
            if self.text.count == 0 && newValue?.count ?? 0 > 0{
                self.viewWithTag(999)?.alpha = 1;
            }else{
                self.viewWithTag(999)?.alpha = 0;
            }
        }
        get{
            return placeHolderLabel.text;
        }
    }
    
    public var placeholderColor:UIColor?{
        set{
            placeHolderLabel.textColor = newValue;
        }
        get{
            return placeHolderLabel.textColor;
        }
    }
    
    public var placeholderFont:UIFont?{
        set{
            placeHolderLabel.font = newValue;
            
        }
        get{
            return placeHolderLabel.font;
        }
    }
    
    public override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame,textContainer:textContainer);
        self.placeholder = "";
        self.placeholderColor = UIColor.lightGray;
        self.placeholderFont = UIFont.systemFont(ofSize: 14);
        
        
        
        self.addSubview(self.placeHolderLabel);
        self.placeHolderLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(8);
            make.top.equalTo(self).offset(8);
            make.right.equalTo(self).offset(-8);
        }
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(textChanged), name: UITextView.textDidChangeNotification, object: nil)
        
    }
    
    @objc func textChanged() {
        if self.placeholder?.count == 0 {
            return;
        }
        if self.text.count == 0{
            self.viewWithTag(999)?.alpha = 1;
        }else{
            self.viewWithTag(999)?.alpha = 0;
        }
    }
    
    

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
}
