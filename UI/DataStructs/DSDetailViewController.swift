//
//  DSDetailViewController.swift
//  Material
//
//  Created by Noirozr on 16/4/26.
//  Copyright © 2016年 Yongjia Liu. All rights reserved.
//

import UIKit
import WebKit

class DSDetailViewController: MATBaseViewController {

    var rowId: Int?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Detail"
        p_constructSubviews()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: - Private Methods
    private func p_constructSubviews() {
        let webView = WKWebView(frame: CGRectZero)
        self.view.addSubview(webView)
        webView.snp_makeConstraints() { (make) -> Void in
            make.edges.equalTo(self.view).inset(UIEdgeInsetsMake(MATConstant.NavigationBarHeight, 0, 0, 0))
        }
        guard let id = self.rowId, let path = NSBundle.mainBundle().pathForResource("\(id)", ofType: "pdf") else {
            return
        }
        let url = NSURL(fileURLWithPath: path)
        webView.loadFileURL(url, allowingReadAccessToURL: url)
    }

}
