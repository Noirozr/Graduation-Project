//
//  AccountViewController.swift
//  Material
//
//  Created by Noirozr on 16/3/15.
//  Copyright © 2016年 Yongjia Liu. All rights reserved.
//

import UIKit

class AccountViewController: MATBaseViewController {
    
    fileprivate var _collectionView: UICollectionView!
    fileprivate var _itemDataArray: [AccountCellData] = []

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
    fileprivate func p_constructSubviews() {
        let layout = AccountCollectionViewLayout()
        
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        self.view.addSubview(collectionView)
        collectionView.snp_makeConstraints() { (make) -> Void in
            make.edges.equalTo(self.view).inset(UIEdgeInsetsMake(MATConstant.NavigationBarHeight, 0, 0, 0))
        }
        collectionView.backgroundColor = UIColor.clear
        collectionView.register(AccountCollectionViewCell.self, forCellWithReuseIdentifier: "AccountCollectionViewCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        
        _collectionView = collectionView
    }

}


//MARK: - Extension UICollectionViewDelegate, UICollectionViewDataSource
extension AccountViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return _itemDataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AccountCollectionViewCell", for: indexPath) as! AccountCollectionViewCell
        cell.refreshContentByData(_itemDataArray[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
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
