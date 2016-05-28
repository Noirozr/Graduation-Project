//
//  DataStructsViewController.swift
//  Material
//
//  Created by Noirozr on 16/3/15.
//  Copyright © 2016年 Yongjia Liu. All rights reserved.
//

import UIKit
import SQLite

class DataStrcuturesViewController: MATBaseViewController {
    
    private var _collectionView: UICollectionView!
    private var _itemDataArray: [DataStructuresCellData] = []


    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Data Structures"
        
        for item in DSData {
            let cellItem = DataStructuresCellData(backgroundColor: UIColor.fcb_colorWithHexString("2B76FD"), title: item)
            _itemDataArray.append(cellItem)
        }
        
        p_constructSubviews()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: - Private Methods
    private func p_constructSubviews() {
        let layout = DataStructuresCollectionViewFlowLayout()
        
        let collectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: layout)
        self.view.addSubview(collectionView)
        collectionView.snp_makeConstraints() { (make) -> Void in
            make.edges.equalTo(self.view).inset(UIEdgeInsetsMake(MATConstant.NavigationBarHeight, 0, 0, 0))
        }
        collectionView.backgroundColor = UIColor.clearColor()
        collectionView.registerClass(DataStructuresCollectionViewCell.self, forCellWithReuseIdentifier: "DataStructuresCollectionViewCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        
        _collectionView = collectionView
    }
    
    
}

//MARK: - Extension UICollectionViewDelegate, UICollectionViewDataSource
extension DataStrcuturesViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return DSData.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("DataStructuresCollectionViewCell", forIndexPath: indexPath) as! DataStructuresCollectionViewCell
        cell.layer.borderColor = UIColor.whiteColor().CGColor
        cell.layer.borderWidth = 2
        cell.layer.cornerRadius = 15
        cell.refreshContentByData(_itemDataArray[indexPath.row])
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let nextVC = DSContentViewController()
        nextVC.rowId = indexPath.row
        switch indexPath.row {
        case 0:
            nextVC.url = arrayUrl
        case 1:
            nextVC.url = stackUrl
        case 2:
            nextVC.url = queueUrl
        case 3:
            nextVC.url = listUrl
        case 4:
            nextVC.url = treeUrl
        case 5:
            nextVC.url = graphUrl
        case 6:
            nextVC.url = heapUrl
        case 7:
            nextVC.url = hashUrl
        default:
            self.showFloatingTipMessage("Something wrong!")
        }
        nextVC.title = DSData[indexPath.row]
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
}
