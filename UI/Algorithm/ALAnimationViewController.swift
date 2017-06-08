//
//  ALAnimationViewController.swift
//  Material
//
//  Created by Noirozr on 16/4/16.
//  Copyright © 2016年 Yongjia Liu. All rights reserved.
//

import UIKit
import DynamicButton
class ALAnimationViewController: MATBaseViewController {

    var rowId: Int?
    var dataArray: Array<[Int]>?
    
    fileprivate var p_index = 0
    fileprivate var _collectionView: UICollectionView?
    fileprivate var _changeIndex: [Int] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Animation"
        
        p_constructSubviews()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    //MARK: - Private Methods
    fileprivate func p_constructSubviews() {
        let nextButton = DynamicButton(style: .caretRight)
        self.view.addSubview(nextButton)
        nextButton.snp_makeConstraints() { (make) -> Void in
            make.bottom.equalTo(self.view).offset(-10)
            make.centerX.equalTo(self.view).offset(80)
            make.width.equalTo(40)
            make.height.equalTo(40)
        }
        
        let prevButton = DynamicButton(style: .caretLeft)
        self.view.addSubview(prevButton)
        prevButton.snp_makeConstraints() { (make) -> Void in
            make.bottom.equalTo(self.view).offset(-10)
            make.centerX.equalTo(self.view).offset(-80)
            make.width.equalTo(40)
            make.height.equalTo(40)
        }
        
        let layout = AnimeCollectionViewLayout()
        
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        self.view.addSubview(collectionView)
        collectionView.snp_makeConstraints() { (make) -> Void in
            make.top.equalTo(self.view).offset(MATConstant.NavigationBarHeight + 25)
            make.leading.equalTo(self.view).offset(10)
            make.trailing.equalTo(self.view).offset(-10)
            make.bottom.equalTo(nextButton.snp_top).offset(-10)
        }
        
        prevButton.addTarget(self, action: #selector(ALAnimationViewController.prevButtonTapped(_:)), for: .touchUpInside)
        nextButton.addTarget(self, action: #selector(ALAnimationViewController.nextButtonTapped(_:)), for: .touchUpInside)
        
        collectionView.backgroundColor = UIColor.clear
        collectionView.register(AnimeCollectionViewCell.self, forCellWithReuseIdentifier: "AnimeCollectionViewCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        
        _collectionView = collectionView
        
    }
    
    //MARK: - Event
    func nextButtonTapped(_ sender: UIButton) {
        guard let array = self.dataArray else {
            return
        }
        _changeIndex = []
        if p_index == (array.count - 1) {
            p_index = array.count - 1
            self.showFloatingTipMessage("已经没有下一步了。")
        } else {
            let prevArr = array[p_index]
            p_index += 1
            let nextArr = array[p_index]

            for i in 0...(nextArr.count - 1) {
                if prevArr[i] != nextArr [i] {
                    _changeIndex.append(i)
                }
            }
            
            print(_changeIndex)
        }
        _collectionView?.reloadData()
    }
    func prevButtonTapped(_ sender: UIButton) {
        guard let array = self.dataArray else {
            return
        }
        _changeIndex = []
        if p_index == 0 {
            p_index = 0
            self.showFloatingTipMessage("已经没有上一步了。")
        } else {
            let prevArr = array[p_index]
            p_index -= 1
            let nextArr = array[p_index]
            
            for i in 0...(nextArr.count - 1) {
                if prevArr[i] != nextArr [i] {
                    _changeIndex.append(i)
                }
            }
            
        }
        _collectionView?.reloadData()
    }
}

//MARK: - Extension UICollectionViewDatasource, UICollectionViewDelegate
extension ALAnimationViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AnimeCollectionViewCell", for: indexPath) as! AnimeCollectionViewCell
        guard let array = self.dataArray else {
            return cell
        }
        cell.layer.borderColor = UIColor.white.cgColor
        cell.layer.borderWidth = 2
        cell.layer.cornerRadius = 15

        if _changeIndex.contains(indexPath.row) {
            cell.backgroundColor = UIColor.fcb_colorWithHexString("96160B")
        } else {
            cell.backgroundColor = UIColor.fcb_colorWithHexString("2B76FD")
        }
        
        cell.refreshContentByData(array[p_index][indexPath.row])
        return cell
    }
}

//MARK: - AlCCollectionViewLayout
class AnimeCollectionViewLayout: UICollectionViewFlowLayout {
    
    override func prepare() {
        super.prepare()
        
        let height: CGFloat = 100
        self.itemSize.height = height
        self.itemSize.width = (self.collectionView?.frame.size.width ?? UIScreen.main.bounds.width) - 30
        
        self.sectionInset = UIEdgeInsetsMake(15, 15, 0, 15)
        
        let minimumLineSpacing: CGFloat = 15
        self.minimumInteritemSpacing = minimumLineSpacing
        
        self.scrollDirection = .vertical
        
    }
}

//MARK: - AlCCollectionViewCell
struct AnimeCellData {
    var backgroundColor: UIColor
    var title: String
}

class AnimeCollectionViewCell: UICollectionViewCell {
    
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
    func refreshContentByData(_ data: Int) {
        ktitleLabel.text = "\(data)"
    }
    
}

