//
//  BBaseTableViewCell.swift
//  Fch_Contact
//
//  Created by bai on 2017/11/30.
//  Copyright © 2017年 北京仙指信息技术有限公司. All rights reserved.
//

import UIKit

class BBaseTableViewCell: UITableViewCell {

    
   
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        self.selectionStyle = .none;
        
    }

}
