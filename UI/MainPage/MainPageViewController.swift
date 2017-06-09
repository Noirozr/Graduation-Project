//
//  MainPageViewController.swift
//  Material
//
//  Created by Noirozr on 16/2/5.
//  Copyright © 2016年 Yongjia Liu. All rights reserved.
//

import UIKit

class MainPageViewController: MATBaseViewController {
    
    fileprivate var _collectionView: UICollectionView!
    fileprivate var _itemDataArray: [MainPageCollectionViewCellData] = []

    override func viewDidLoad() {
        
        super.viewDidLoad()
        addNavLeftBtnWithImageName("info_btn_normal", highlightedName: "info_btn_pressed")
        self.title = "HomePage"
        
        let cellItem1 = MainPageCollectionViewCellData(backgroundColor: UIColor.fcb_colorWithHexString("2B76FD"), iconName: "datastruct_icon", name: "Browser")
        _itemDataArray.append(cellItem1)
        let cellItem2 = MainPageCollectionViewCellData(backgroundColor: UIColor.fcb_colorWithHexString("2B76FD"), iconName: "algorithm_icon", name: "Courses")
        _itemDataArray.append(cellItem2)
        let cellItem3 = MainPageCollectionViewCellData(backgroundColor: UIColor.fcb_colorWithHexString("2B76FD"), iconName: "account_icon", name: "Social")
        _itemDataArray.append(cellItem3)
        let cellItem4 = MainPageCollectionViewCellData(backgroundColor: UIColor.fcb_colorWithHexString("96160B"), iconName: "3rdpr_icon", name: "Storage")
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
    fileprivate func p_constructSubviews() {
        let layout = MainPageCollectionViewFlowLayout()
        
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        self.view.addSubview(collectionView)
        collectionView.snp.makeConstraints() { (make) -> Void in
            make.edges.equalTo(self.view).inset(UIEdgeInsetsMake(MATConstant.NavigationBarHeight, 0, 0, 0))
        }
        collectionView.backgroundColor = UIColor.clear
        collectionView.register(MainPageCollectionViewCell.self, forCellWithReuseIdentifier: "MainPageCollectionViewCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        
        _collectionView = collectionView
    }
    
}

//MARK: - UICollectionView Extension
extension MainPageViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return _itemDataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainPageCollectionViewCell", for: indexPath) as! MainPageCollectionViewCell
        cell.refreshContentByData(_itemDataArray[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.row {
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


