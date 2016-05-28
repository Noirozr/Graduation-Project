//
//  MainPageViewController.swift
//  Material
//
//  Created by Noirozr on 16/2/5.
//  Copyright © 2016年 Yongjia Liu. All rights reserved.
//

import UIKit

class MainPageViewController: MATBaseViewController {
    
    private var _collectionView: UICollectionView!
    private var _itemDataArray: [MainPageCollectionViewCellData] = []

    override func viewDidLoad() {
        
        super.viewDidLoad()
        addNavLeftBtnWithImageName("info_btn_normal", highlightedName: "info_btn_pressed")
        self.title = "HomePage"
        
        let cellItem1 = MainPageCollectionViewCellData(backgroundColor: UIColor.fcb_colorWithHexString("2B76FD"), iconName: "datastruct_icon", name: "Data Structures")
        _itemDataArray.append(cellItem1)
        let cellItem2 = MainPageCollectionViewCellData(backgroundColor: UIColor.fcb_colorWithHexString("2B76FD"), iconName: "algorithm_icon", name: "Algorithm")
        _itemDataArray.append(cellItem2)
        let cellItem3 = MainPageCollectionViewCellData(backgroundColor: UIColor.fcb_colorWithHexString("2B76FD"), iconName: "account_icon", name: "ME")
        _itemDataArray.append(cellItem3)
        let cellItem4 = MainPageCollectionViewCellData(backgroundColor: UIColor.fcb_colorWithHexString("96160B"), iconName: "3rdpr_icon", name: "Third Party Resources")
        _itemDataArray.append(cellItem4)
        
        p_constructSubviews()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    override func navLeftBtnClicked() {
        let nextVC = AboutViewController()
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
    //MARK: - Private Methods
    private func p_constructSubviews() {
        let layout = MainPageCollectionViewFlowLayout()
        
        let collectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: layout)
        self.view.addSubview(collectionView)
        collectionView.snp_makeConstraints() { (make) -> Void in
            make.edges.equalTo(self.view).inset(UIEdgeInsetsMake(MATConstant.NavigationBarHeight, 0, 0, 0))
        }
        collectionView.backgroundColor = UIColor.clearColor()
        collectionView.registerClass(MainPageCollectionViewCell.self, forCellWithReuseIdentifier: "MainPageCollectionViewCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        
        _collectionView = collectionView
    }
    
}

//MARK: - UICollectionView Extension
extension MainPageViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return _itemDataArray.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("MainPageCollectionViewCell", forIndexPath: indexPath) as! MainPageCollectionViewCell
        cell.refreshContentByData(_itemDataArray[indexPath.row])
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        switch indexPath.row {
        case 0:
            let nextVC = DataStrcuturesViewController()
            self.navigationController?.pushViewController(nextVC, animated: true)
        case 1:
            let nextVC = AlgorithmViewController()
            self.navigationController?.pushViewController(nextVC, animated: true)
        case 2:
            let nextVC = AccountViewController()
            self.navigationController?.pushViewController(nextVC, animated: true)
        case 3:
            let nextVC = TPRViewController()
            self.navigationController?.pushViewController(nextVC, animated: true)
        default:
            let nextVC = AboutViewController()
            navigationController?.pushViewController(nextVC, animated: true)
        }
    }
}


