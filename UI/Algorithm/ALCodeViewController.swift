//
//  ALCodeViewController.swift
//  Material
//
//  Created by Noirozr on 16/4/16.
//  Copyright © 2016年 Yongjia Liu. All rights reserved.
//

import UIKit
import WebKit

class ALCodeViewController: MATBaseViewController {
    
    var rowId: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Details"
        p_constructSubviews()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    //MARK: - Private Methods
    fileprivate func p_constructSubviews() {
        let webView = WKWebView(frame: CGRect.zero)
        self.view.addSubview(webView)
        webView.snp_makeConstraints() { (make) -> Void in
            make.edges.equalTo(self.view).inset(UIEdgeInsetsMake(MATConstant.NavigationBarHeight, 0, 0, 0))
        }
        guard let id = self.rowId, let path = Bundle.main.path(forResource: "algorithm_\(id)", ofType: "pdf") else {
            return
        }
        let url = URL(fileURLWithPath: path)
        webView.loadFileURL(url, allowingReadAccessTo: url)
    }

}
