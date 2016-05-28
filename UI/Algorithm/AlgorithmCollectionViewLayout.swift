//
//  AlgorithmCollectionViewLayout.swift
//  Material
//
//  Created by Noirozr on 16/4/4.
//  Copyright © 2016年 Yongjia Liu. All rights reserved.
//

import UIKit

class AlgorithmCollectionViewLayout: UICollectionViewFlowLayout {
    
    override func prepareLayout() {
        super.prepareLayout()
        
        let height: CGFloat = 148
        self.itemSize.height = height
        self.itemSize.width = (self.collectionView?.frame.size.width ?? UIScreen.mainScreen().bounds.width) - 30
        
        self.sectionInset = UIEdgeInsetsMake(15, 15, 0, 15)
        
        let minimumLineSpacing: CGFloat = 15
        self.minimumInteritemSpacing = minimumLineSpacing
        
        self.scrollDirection = .Vertical
        
    }
}
