//
//  ALImageViewController.swift
//  Material
//
//  Created by Noirozr on 16/4/16.
//  Copyright © 2016年 Yongjia Liu. All rights reserved.
//

import UIKit
import Gifu

class ALImageViewController: MATBaseViewController {
    
    var rowId: Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Image"
        p_constructSubviews()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Private Methods
    fileprivate func p_constructSubviews() {
        let imageView = GIFImageView(frame: CGRect.zero)
        self.view.addSubview(imageView)
        imageView.snp_makeConstraints() { (make) -> Void in
            make.centerX.equalTo(self.view)
            make.top.equalTo(self.view).offset(MATConstant.NavigationBarHeight + 60)
            make.height.equalTo(270)
            make.width.equalTo(270)
        }
        
        let detailLabel = UILabel()
        self.view.addSubview(detailLabel)
        detailLabel.snp_makeConstraints() { (make) -> Void in
            make.top.equalTo(imageView.snp_bottom).offset(15)
            make.height.equalTo(30)
            make.width.equalTo(self.view)
        }
        
        detailLabel.text = "from WIKIPEDIA"
        detailLabel.textAlignment = .center
        detailLabel.font = UIFont.systemFont(ofSize: 24)
        detailLabel.textColor = UIColor.black
        guard let id = self.rowId else {
            return
        }
        imageView.animate(withGIFNamed: "\(id).gif")
    }
}
