//
//  DSContentViewController.swift
//  Material
//
//  Created by Noirozr on 16/4/5.
//  Copyright © 2016年 Yongjia Liu. All rights reserved.
//

import UIKit
import WebKit

class DSContentViewController: MATBaseViewController {
    
    var rowId: Int?
    var url: String?
    fileprivate var _collectionView: UICollectionView!
    fileprivate var _itemDataArray: [DSCCellData] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.addNavRightBtnWithImageName("check_btn_normal", highlightedName: "check_btn_pressed")
        let cellItem1 = DSCCellData(backgroundColor: UIColor.fcb_colorWithHexString("2B76FD"), title: "Animation")
        _itemDataArray.append(cellItem1)
        let cellItem2 = DSCCellData(backgroundColor: UIColor.fcb_colorWithHexString("2B76FD"), title: "Details")
        _itemDataArray.append(cellItem2)
        p_constructSubviews()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func navRightBtnClicked() {
        let alert = UIAlertController(title: "注意", message: "是否已经完成学习", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "取消", style: UIAlertActionStyle.destructive, handler: nil)
        alert.addAction(cancelAction)
        let okAction = UIAlertAction(title: "确认", style: UIAlertActionStyle.default) { (action) in
            guard var data = UserDefaults.standard.object(forKey: "DSP") as? [Int], let id = self.rowId else {
                return
            }
            
            data[id] = 1
            UserDefaults.standard.set(data, forKey: "DSP")
        }
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    //MARK: - Private Methods
    fileprivate func p_constructSubviews() {
        let layout = AlCCollectionViewLayout()
        
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        self.view.addSubview(collectionView)
        collectionView.snp_makeConstraints() { (make) -> Void in
            make.top.equalTo(self.view).offset(MATConstant.NavigationBarHeight + 20)
            make.leading.equalTo(self.view).offset(10)
            make.trailing.equalTo(self.view).offset(-10)
            make.bottom.equalTo(self.view).offset(-10)
        }
        collectionView.backgroundColor = UIColor.clear
        collectionView.register(DSCCollectionViewCell.self, forCellWithReuseIdentifier: "DSCCollectionViewCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        
        _collectionView = collectionView
    }
}
//MARK: - Extension UICollectionViewDatasource, UICollectionViewDelegate
extension DSContentViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return _itemDataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DSCCollectionViewCell", for: indexPath) as! DSCCollectionViewCell
        cell.layer.borderColor = UIColor.white.cgColor
        cell.layer.borderWidth = 2
        cell.layer.cornerRadius = 15
        cell.refreshContentByData(_itemDataArray[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            let alert = UIAlertController(title: "注意", message: "访问的内容由 VisualGo 提供，需要网络连接，是否继续？", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "取消", style: UIAlertActionStyle.destructive, handler: nil)
            alert.addAction(cancelAction)
            let okAction = UIAlertAction(title: "确认", style: UIAlertActionStyle.default) { (action) in
                let nextVC = DSAnimationViewController()
                nextVC.rowId = self.rowId
                nextVC.animatedUrl = self.url
                self.navigationController?.pushViewController(nextVC, animated: true)
            }
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
           
        case 1:
            let nextVC = DSDetailViewController()
            nextVC.rowId = self.rowId
            navigationController?.pushViewController(nextVC, animated: true)
        default:
            self.showFloatingTipMessage("Something wrong!")
        }
    }
}



//MARK: - DSCCollectionViewCell
struct DSCCellData {
    var backgroundColor: UIColor
    var title: String
}

class DSCCollectionViewCell: UICollectionViewCell {
    
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
    func refreshContentByData(_ data: DSCCellData) {
        backgroundColor = data.backgroundColor
        ktitleLabel.text = data.title
    }
    
}
