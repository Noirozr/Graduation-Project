//
//  AccountCollectionViewCell.swift
//  Material
//
//  Created by Noirozr on 16/4/3.
//  Copyright © 2016年 Yongjia Liu. All rights reserved.
//

import UIKit

//MARK: -  cell data structs
struct AccountCellData {
    var backgroundColor: UIColor
    var title: String
}

class AccountCollectionViewCell: UICollectionViewCell {
    
    fileprivate let ktitleLabel = UILabel()
    //MARK: - Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        p_constructSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        p_constructSubviews()
    }
    //MARK: - Private Method
    fileprivate func p_constructSubviews() {
        addSubview(ktitleLabel)
        ktitleLabel.snp_makeConstraints() { (make) -> Void in
            make.center.equalTo(self)
        }
        
        ktitleLabel.backgroundColor = UIColor.clear
        ktitleLabel.font = UIFont(name: "Avenir", size: 20)
        ktitleLabel.textColor = UIColor.white
    }
    //MARK: - Public Methods
    func refreshContentByData(_ data: AccountCellData) {
        backgroundColor = data.backgroundColor
        ktitleLabel.text = data.title
    }

}
