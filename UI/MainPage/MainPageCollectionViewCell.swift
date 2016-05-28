//
//  MainPageCollectionViewCell.swift
//  Material
//
//  Created by Noirozr on 16/3/1.
//  Copyright © 2016年 Yongjia Liu. All rights reserved.
//

import UIKit
import SnapKit

//MARK: - Cell data struct
struct MainPageCollectionViewCellData {
    var backgroundColor: UIColor
    var iconName: String
    var name: String
}

class MainPageCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Private Properties
    private let kNameLabel = UILabel()
    private let kImageView = UIImageView()
    
    override var highlighted: Bool {
        didSet {
            backgroundColor = backgroundColor?.colorWithAlphaComponent(highlighted ? 0.7 : 1.0)
        }
    }
    
    //MARK: - Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        p_constructSubviews()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        p_constructSubviews()
    }
    //MARK: - Public Methods
    func refreshContentByData(data: MainPageCollectionViewCellData) {
        backgroundColor = data.backgroundColor
        kNameLabel.text = data.name
        kImageView.image = UIImage(named: data.iconName)
    }

    //MARK: - Private Methods
    private func p_constructSubviews() {
        
        addSubview(kImageView)
        kImageView.snp_makeConstraints() { (make) -> Void in
            make.top.equalTo(self).offset(40)
            make.centerX.equalTo(self)
        }
        
        addSubview(kNameLabel)
        kNameLabel.snp_makeConstraints() { (make) -> Void in
            make.bottom.equalTo(self).offset(-30)
            make.centerX.equalTo(self)
        }
        
        kNameLabel.backgroundColor = UIColor.clearColor()
        kNameLabel.textColor = UIColor.whiteColor()
        kNameLabel.font = UIFont(name: "Avenir", size: 20)
        
        self.layer.cornerRadius = 5
    }
}
