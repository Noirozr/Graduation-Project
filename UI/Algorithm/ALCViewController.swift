//
//  ALCViewController.swift
//  Material
//
//  Created by Noirozr on 16/4/5.
//  Copyright © 2016年 Yongjia Liu. All rights reserved.
//

import UIKit

class ALCViewController: MATBaseViewController {
    
    var rowId: Int?
    var name: String?
    var algorithmDescription: String?
    
    private var _collectionView: UICollectionView!
    private var _itemDataArray: [AlCCellData] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.addNavRightBtnWithImageName("check_btn_normal", highlightedName: "check_btn_pressed")
        
        let cellItem1 = AlCCellData(backgroundColor: UIColor.fcb_colorWithHexString("2B76FD"), title: "Animation")
        _itemDataArray.append(cellItem1)
        let cellItem2 = AlCCellData(backgroundColor: UIColor.fcb_colorWithHexString("2B76FD"), title: "Details")
        _itemDataArray.append(cellItem2)
        let cellItem3 = AlCCellData(backgroundColor: UIColor.fcb_colorWithHexString("2B76FD"), title: "Image")
        _itemDataArray.append(cellItem3)
        
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
            guard var data = NSUserDefaults.standardUserDefaults().objectForKey("ASP") as? [Int], let id = self.rowId else {
                return
            }
            
            data[id] = 1
            NSUserDefaults.standardUserDefaults().setObject(data, forKey: "ASP")
        }
        alert.addAction(okAction)
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    //MARK: - Private Methods
    private func p_constructSubviews() {
        let titleLabel = UILabel()
        self.view.addSubview(titleLabel)
        titleLabel.snp_makeConstraints() { (make) -> Void in
            make.top.equalTo(self.view).offset(MATConstant.NavigationBarHeight + 15)
            make.leading.equalTo(self.view).offset(5)
            make.trailing.equalTo(self.view).offset(-5)
            make.height.equalTo(30)
        }
        let descripLabel = UILabel()
        self.view.addSubview(descripLabel)
        descripLabel.snp_makeConstraints() { (make) -> Void in
            make.top.equalTo(titleLabel.snp_bottom).offset(1)
            make.leading.equalTo(self.view).offset(10)
            make.trailing.equalTo(self.view).offset(-10)
            make.height.equalTo(150)
        }
        let layout = AlCCollectionViewLayout()
        
        let collectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: layout)
        self.view.addSubview(collectionView)
        collectionView.snp_makeConstraints() { (make) -> Void in
            make.top.equalTo(descripLabel.snp_bottom).offset(10)
            make.leading.equalTo(self.view).offset(10)
            make.trailing.equalTo(self.view).offset(-10)
            make.bottom.equalTo(self.view).offset(-10)
        }
        collectionView.backgroundColor = UIColor.clearColor()
        collectionView.registerClass(AlCCollectionViewCell.self, forCellWithReuseIdentifier: "AlCCollectionViewCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        
        _collectionView = collectionView
        
        titleLabel.text = name
        titleLabel.font = UIFont.systemFontOfSize(35)
        descripLabel.text = algorithmDescription
        descripLabel.lineBreakMode = .ByTruncatingTail
        descripLabel.numberOfLines = 0
    }
    
}

//MARK: - Extension UICollectionViewDatasource, UICollectionViewDelegate
extension ALCViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("AlCCollectionViewCell", forIndexPath: indexPath) as! AlCCollectionViewCell
        cell.layer.borderColor = UIColor.whiteColor().CGColor
        cell.layer.borderWidth = 2
        cell.layer.cornerRadius = 15
        cell.refreshContentByData(_itemDataArray[indexPath.row])
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        switch indexPath.row {
        case 0:
            let nextVC = ALAnimationViewController()
            nextVC.rowId = self.rowId
            guard let id = self.rowId else {
                return
            }
            switch id {
            case 0:
                nextVC.dataArray = bubbleSortData
            case 1:
                nextVC.dataArray = quickSortData
            case 2:
                nextVC.dataArray = insertionSortData
            case 3:
                nextVC.dataArray = selectionSortData
            case 4:
                nextVC.dataArray = heapSortData
            default:
                self.showFloatingTipMessage("Something woring")
            }
            navigationController?.pushViewController(nextVC, animated: true)
        case 1:
            let nextVC = ALCodeViewController()
            nextVC.rowId = self.rowId
            navigationController?.pushViewController(nextVC, animated: true)
        case 2:
            let nextVC = ALImageViewController()
            nextVC.rowId = self.rowId
            navigationController?.pushViewController(nextVC, animated: true)
        default:
            self.showFloatingTipMessage("Something wrong!")
        }
    }
}

//MARK: - AlCCollectionViewLayout
class AlCCollectionViewLayout: UICollectionViewFlowLayout {
    
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

//MARK: - AlCCollectionViewCell
struct AlCCellData {
    var backgroundColor: UIColor
    var title: String
}

class AlCCollectionViewCell: UICollectionViewCell {
    
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
    func refreshContentByData(data: AlCCellData) {
        backgroundColor = data.backgroundColor
        ktitleLabel.text = data.title
    }
    
}
