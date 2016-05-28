//
//  MATBaseViewController.swift
//  Material
//
//  Created by Noirozr on 16/2/5.
//  Copyright © 2016年 Yongjia Liu. All rights reserved.
//

import UIKit

class MATBaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        automaticallyAdjustsScrollViewInsets = false
        view.backgroundColor = UIColor.fcb_colorWithHexString("efeff4")
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addNavLeftBtnWithImageName(normalName: String, highlightedName: String?){
        navigationItem.leftBarButtonItem = p_createNavBtnItemWithImage(true, normalName: normalName, highlightedName: highlightedName)
    }
    
    func addNavRightBtnWithImageName(normalName: String, highlightedName: String?){
        navigationItem.rightBarButtonItem = p_createNavBtnItemWithImage(false, normalName: normalName, highlightedName: highlightedName)
    }
    
    // MARK: - Events
    func navLeftBtnClicked() {
        navigationController?.popViewControllerAnimated(true)
    }
    
    func navRightBtnClicked() {
        
    }
    
    // MARK: Private Methods
    private func p_createNavBtnItemWithImage(isLeft: Bool, normalName: String, highlightedName: String? = nil) -> UIBarButtonItem {
        
        let btn = UIButton(frame: CGRectMake(0, 0, 50, 44))
        btn.contentHorizontalAlignment = isLeft ? .Left : .Right
        btn.setImage(UIImage(named: normalName), forState: .Normal)
        if highlightedName != nil {
            btn.setImage(UIImage(named: highlightedName!), forState: UIControlState.Highlighted)
        }
        btn.addTarget(self, action: isLeft ? #selector(MATBaseViewController.navLeftBtnClicked) : #selector(MATBaseViewController.navRightBtnClicked), forControlEvents: .TouchUpInside)
        
        return UIBarButtonItem(customView: btn)
    }

}

extension MATBaseViewController {
    var floatingTipMsgViewOffsetY: CGFloat {
        
        return MATConstant.NavigationBarHeight
    }
    
    func showFloatingTipMessage(msg: String) {
        let tipViewHeight: CGFloat = 33
        
        // view hierarchy
        let tipMsgView = UIView()
        view.addSubview(tipMsgView)
        tipMsgView.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(self.view).offset(self.floatingTipMsgViewOffsetY)
            make.left.equalTo(self.view)
            make.right.equalTo(self.view)
            make.height.equalTo(tipViewHeight)
        }
        
        // -
        let textView = UIView()
        tipMsgView.addSubview(textView)
        textView.snp_makeConstraints { (make) -> Void in
            make.edges.equalTo(tipMsgView)
        }
        
        // --
        let label = UILabel()
        textView.addSubview(label)
        label.snp_makeConstraints { (make) -> Void in
            make.edges.equalTo(textView).inset(UIEdgeInsetsMake(0, 20, 0, 20))
        }
        
        
        // view config
        tipMsgView.clipsToBounds = true
        
        textView.backgroundColor = UIColor.fcb_colorWithHexString("2B79FB", alpha: 0.8)
        
        label.backgroundColor = UIColor.clearColor()
        label.textColor = UIColor.whiteColor()
        label.textAlignment = .Center
        label.font = UIFont.systemFontOfSize(13)
        label.text = msg
        
        
        // add show animation
        let showAnimation = CABasicAnimation(keyPath: "position.y")
        showAnimation.fromValue = -tipViewHeight
        showAnimation.toValue = 0
        showAnimation.additive = true
        showAnimation.duration = 0.2
        showAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        textView.layer.addAnimation(showAnimation, forKey: "showAnimation")
        
        
        // auto remove tip view
        let duration: NSTimeInterval = 2
        let delay = dispatch_time(DISPATCH_TIME_NOW,
                                  Int64(duration * Double(NSEC_PER_SEC)))
        dispatch_after(delay, dispatch_get_main_queue()) { () -> Void in
            
            textView.alpha = 0
            
            CATransaction.begin()
            
            let yAnimation = CABasicAnimation(keyPath: "position.y")
            yAnimation.fromValue = 0
            yAnimation.toValue = -tipViewHeight
            yAnimation.additive = true
            yAnimation.duration = 0.2
            yAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
            
            let alphaAnimation = CABasicAnimation(keyPath: "opacity")
            alphaAnimation.fromValue = 1
            alphaAnimation.toValue = 0
            alphaAnimation.additive = true
            alphaAnimation.duration = 0.2
            alphaAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
            
            let hideAnimationGroup = CAAnimationGroup()
            hideAnimationGroup.animations = [yAnimation, alphaAnimation]
            hideAnimationGroup.duration = 0.2
            
            CATransaction.setCompletionBlock({ () -> Void in
                tipMsgView.removeFromSuperview()
                
            })
            
            textView.layer.addAnimation(hideAnimationGroup, forKey: "hideAnimation")
        }
    }
}

