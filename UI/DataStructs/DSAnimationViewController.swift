//
//  DSAnimationViewController.swift
//  Material
//
//  Created by Noirozr on 16/4/27.
//  Copyright © 2016年 Yongjia Liu. All rights reserved.
//

import UIKit
import WebKit
// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func <= <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l <= r
  default:
    return !(rhs < lhs)
  }
}


class DSAnimationViewController: MATBaseViewController {
    
    var rowId: Int?
    var animatedUrl: String?
    
    fileprivate var _webView: WKWebView?
    fileprivate var _trafficLight: UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Animation"
        p_constructSubviews()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {

            if _webView?.estimatedProgress <= 0.5 {
                _trafficLight?.backgroundColor = UIColor.fcb_colorWithHexString("DB4D6D")
                _trafficLight?.layer.cornerRadius = 5
            } else if _webView?.estimatedProgress <= 0.8 {
                _trafficLight?.backgroundColor = UIColor.fcb_colorWithHexString("F75C2F")
                _trafficLight?.layer.cornerRadius = 10
            } else if _webView?.estimatedProgress < 1 {
                _trafficLight?.backgroundColor = UIColor.fcb_colorWithHexString("90B44B")
                _trafficLight?.layer.cornerRadius = 15
            } else {
                let animation = CABasicAnimation(keyPath: "opacity")
                animation.fromValue = 1.0
                animation.toValue = 0.0
                animation.duration = 0.8
                animation.isRemovedOnCompletion = false
                animation.fillMode = kCAFillModeForwards
                _trafficLight?.layer.add(animation, forKey: "opacity")
            }
        }
    }
    
    deinit {
        guard let webView = _webView else {
            return
        }
        webView.removeObserver(self, forKeyPath: "estimatedProgress")
    }
    //MARK: - Private Methods
    fileprivate func p_constructSubviews() {
        
//        let js = "alert('动画效果由 Visualgo 提供。');"
//        let script = WKUserScript(source: js, injectionTime: .AtDocumentEnd, forMainFrameOnly: true)
//        let config = WKWebViewConfiguration()
//        config.userContentController.addUserScript(script)
        
        let webView = WKWebView(frame: CGRect.zero)
        self.view.addSubview(webView)
        webView.snp_makeConstraints() { (make) -> Void in
            make.edges.equalTo(self.view).inset(UIEdgeInsetsMake(MATConstant.NavigationBarHeight, 0, 0, 0))
        }
        
        let trafficLightView = UIView(frame: CGRect.zero)
        self.view.addSubview(trafficLightView)
        trafficLightView.snp_makeConstraints() { (make) -> Void in
            make.center.equalTo(webView.snp_center)
            make.height.equalTo(50)
            make.width.equalTo(50)
        }
        
        trafficLightView.backgroundColor = UIColor.red
        trafficLightView.layer.cornerRadius = 5
        _trafficLight = trafficLightView
        
        
        webView.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil)
        self._webView = webView
        
        guard let url = self.animatedUrl, let address = URL(string: url) else {
            return
        }
        
        let request = URLRequest(url: address)
        webView.load(request)
        print(webView.estimatedProgress)
    }

}
