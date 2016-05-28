//
//  DataStructuresCollectionViewFlowLayout.swift
//  Material
//
//  Created by Noirozr on 16/3/30.
//  Copyright © 2016年 Yongjia Liu. All rights reserved.
//

import UIKit

let activeDistance: CGFloat = 158
let zoomFactor = 0.3
let rotate: CGFloat = 35.0
class DataStructuresCollectionViewFlowLayout: UICollectionViewFlowLayout {
    
    override func prepareLayout() {
        super.prepareLayout()
        
        let height: CGFloat = 148
        self.itemSize.height = height
        self.itemSize.width = (self.collectionView?.frame.size.width ?? UIScreen.mainScreen().bounds.width) - 30
        
        self.sectionInset = UIEdgeInsetsMake(15, 15, 0, 15)
        
        let minimumLineSpacing: CGFloat = 0
        self.minimumInteritemSpacing = minimumLineSpacing
        
        self.scrollDirection = .Vertical
        
    }
    
}
