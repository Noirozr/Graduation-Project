//
//  AccountViewController.swift
//  Material
//
//  Created by Noirozr on 16/3/15.
//  Copyright © 2016年 Yongjia Liu. All rights reserved.
//

import UIKit

class AccountViewController: MATBaseViewController {
    
    private var _collectionView: UICollectionView!
    private var _itemDataArray: [AccountCellData] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Account"
        
        for item in titleArr {
            let cellItem = AccountCellData(backgroundColor: UIColor.fcb_colorWithHexString("2B76FD"), title: item)
            _itemDataArray.append(cellItem)
        }
        p_constructSubviews()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: - Private Methods
    private func p_constructSubviews() {
        let layout = AccountCollectionViewLayout()
        
        let collectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: layout)
        self.view.addSubview(collectionView)
        collectionView.snp_makeConstraints() { (make) -> Void in
            make.edges.equalTo(self.view).inset(UIEdgeInsetsMake(MATConstant.NavigationBarHeight, 0, 0, 0))
        }
        collectionView.backgroundColor = UIColor.clearColor()
        collectionView.registerClass(AccountCollectionViewCell.self, forCellWithReuseIdentifier: "AccountCollectionViewCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        
        _collectionView = collectionView
    }

}


//MARK: - Extension UICollectionViewDelegate, UICollectionViewDataSource
extension AccountViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return _itemDataArray.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("AccountCollectionViewCell", forIndexPath: indexPath) as! AccountCollectionViewCell
        cell.refreshContentByData(_itemDataArray[indexPath.row])
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        switch indexPath.row {
        case 0:
            let nextVC = DSPViewController()
            navigationController?.pushViewController(nextVC, animated: true)
        case 1:
            let nextVC = ASPViewController()
            navigationController?.pushViewController(nextVC, animated: true)
        case 2:
            let nextVC = TPViewController()
            navigationController?.pushViewController(nextVC, animated: true)
        default:
            showFloatingTipMessage("Oops, something wrong.")
        }
    }
    
}
