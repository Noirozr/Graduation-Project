
//
//  AlgorithmViewController.swift
//  Material
//
//  Created by Noirozr on 16/3/15.
//  Copyright © 2016年 Yongjia Liu. All rights reserved.
//

import UIKit
import SQLite

class AlgorithmViewController: MATBaseViewController {

    private var _collectionView: UICollectionView!
    private var _itemDataArray: [AlgorithmCellData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Algorithm"
        self.addNavRightBtnWithImageName("rate_btn_normal", highlightedName: "rate_btn_pressed")
        for item in sortData {
            let cellItem = AlgorithmCellData(backgroundColor: UIColor.fcb_colorWithHexString("2B76FD"), title: item)
            _itemDataArray.append(cellItem)
        }
        
        p_constructSubviews()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    override func navRightBtnClicked() {
        let nextVC = RateViewController()
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
    //MARK: - Private Methods
    private func p_constructSubviews() {
        let layout = AlgorithmCollectionViewLayout()
        
        let collectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: layout)
        self.view.addSubview(collectionView)
        collectionView.snp_makeConstraints() { (make) -> Void in
            make.edges.equalTo(self.view).inset(UIEdgeInsetsMake(MATConstant.NavigationBarHeight, 0, 0, 0))
        }
        collectionView.backgroundColor = UIColor.clearColor()
        collectionView.registerClass(AlgorithmCollectionViewCell.self, forCellWithReuseIdentifier: "AlgorithmCollectionViewCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        
        _collectionView = collectionView
    }

}

//MARK: - Extension UICollectionViewDelegate, UICollectionViewDataSource
extension AlgorithmViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sortData.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("AlgorithmCollectionViewCell", forIndexPath: indexPath) as! AlgorithmCollectionViewCell
        cell.layer.borderColor = UIColor.whiteColor().CGColor
        cell.layer.borderWidth = 2
        cell.layer.cornerRadius = 15
        cell.refreshContentByData(_itemDataArray[indexPath.row])
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let nextVC = ALCViewController()
        do {
            guard let path = NSBundle.mainBundle().pathForResource("MATDB", ofType: "sqlite") else {
                print("path wrong")
                return 
            }
            let db = try Connection(path)
            let table = Table("Algorithm")
            
            let id = Expression<Int64>("ColumnId")
            let content = Expression<String?>("Content")
            
            let columnId = Int64(indexPath.row + 1)
            let results = table.filter(id == columnId)
            guard let result = db.pluck(results) else {
                return
            }
            
            nextVC.rowId = indexPath.row
            nextVC.algorithmDescription = result[content]
            
        } catch {
            print(error)
        }
        nextVC.title = sortData[indexPath.row]
        nextVC.name = sortData[indexPath.row]
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
}