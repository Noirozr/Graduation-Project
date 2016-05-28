//
//  DataStructuresCollectionViewCell.swift
//  Material
//
//  Created by Noirozr on 16/3/30.
//  Copyright © 2016年 Yongjia Liu. All rights reserved.
//

import UIKit

//MARK: -  cell data structs
struct DataStructuresCellData {
    var backgroundColor: UIColor
    var title: String
}

class DataStructuresCollectionViewCell: UICollectionViewCell {
    
    private let ktitleLabel = UILabel()
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
    private func p_constructSubviews() {
        addSubview(ktitleLabel)
        ktitleLabel.snp_makeConstraints() { (make) -> Void in
            make.center.equalTo(self)
        }
        
        ktitleLabel.backgroundColor = UIColor.clearColor()
        ktitleLabel.font = UIFont(name: "Avenir", size: 20)
        ktitleLabel.textColor = UIColor.whiteColor()
    }
    //MARK: - Public Methods
    func refreshContentByData(data: DataStructuresCellData) {
        backgroundColor = data.backgroundColor
        ktitleLabel.text = data.title
    }
}
