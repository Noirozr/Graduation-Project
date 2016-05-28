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
    private var _collectionView: UICollectionView!
    private var _itemDataArray: [DSCCellData] = []

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
        let alert = UIAlertController(title: "注意", message: "是否已经完成学习", preferredStyle: .Alert)
        let cancelAction = UIAlertAction(title: "取消", style: UIAlertActionStyle.Destructive, handler: nil)
        alert.addAction(cancelAction)
        let okAction = UIAlertAction(title: "确认", style: UIAlertActionStyle.Default) { (action) in
            guard var data = NSUserDefaults.standardUserDefaults().objectForKey("DSP") as? [Int], let id = self.rowId else {
                return
            }
            
            data[id] = 1
            NSUserDefaults.standardUserDefaults().setObject(data, forKey: "DSP")
        }
        alert.addAction(okAction)
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    //MARK: - Private Methods
    private func p_constructSubviews() {
        let layout = AlCCollectionViewLayout()
        
        let collectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: layout)
        self.view.addSubview(collectionView)
        collectionView.snp_makeConstraints() { (make) -> Void in
            make.top.equalTo(self.view).offset(MATConstant.NavigationBarHeight + 20)
            make.leading.equalTo(self.view).offset(10)
            make.trailing.equalTo(self.view).offset(-10)
            make.bottom.equalTo(self.view).offset(-10)
        }
        collectionView.backgroundColor = UIColor.clearColor()
        collectionView.registerClass(DSCCollectionViewCell.self, forCellWithReuseIdentifier: "DSCCollectionViewCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        
        _collectionView = collectionView
    }
}
//MARK: - Extension UICollectionViewDatasource, UICollectionViewDelegate
extension DSContentViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return _itemDataArray.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("DSCCollectionViewCell", forIndexPath: indexPath) as! DSCCollectionViewCell
        cell.layer.borderColor = UIColor.whiteColor().CGColor
        cell.layer.borderWidth = 2
        cell.layer.cornerRadius = 15
        cell.refreshContentByData(_itemDataArray[indexPath.row])
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        switch indexPath.row {
        case 0:
            let alert = UIAlertController(title: "注意", message: "访问的内容由 VisualGo 提供，需要网络连接，是否继续？", preferredStyle: .Alert)
            let cancelAction = UIAlertAction(title: "取消", style: UIAlertActionStyle.Destructive, handler: nil)
            alert.addAction(cancelAction)
            let okAction = UIAlertAction(title: "确认", style: UIAlertActionStyle.Default) { (action) in
                let nextVC = DSAnimationViewController()
                nextVC.rowId = self.rowId
                nextVC.animatedUrl = self.url
                self.navigationController?.pushViewController(nextVC, animated: true)
            }
            alert.addAction(okAction)
            self.presentViewController(alert, animated: true, completion: nil)
           
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
    func refreshContentByData(data: DSCCellData) {
        backgroundColor = data.backgroundColor
        ktitleLabel.text = data.title
    }
    
}