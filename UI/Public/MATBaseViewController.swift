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
    
    func addNavLeftBtnWithImageName(_ normalName: String, highlightedName: String?){
        navigationItem.leftBarButtonItem = p_createNavBtnItemWithImage(true, normalName: normalName, highlightedName: highlightedName)
    }
    
    func addNavRightBtnWithImageName(_ normalName: String, highlightedName: String?){
        navigationItem.rightBarButtonItem = p_createNavBtnItemWithImage(false, normalName: normalName, highlightedName: highlightedName)
    }
    
    // MARK: - Events
    func navLeftBtnClicked() {
        navigationController?.popViewController(animated: true)
    }
    
    func navRightBtnClicked() {
        
    }
    
    // MARK: Private Methods
    fileprivate func p_createNavBtnItemWithImage(_ isLeft: Bool, normalName: String, highlightedName: String? = nil) -> UIBarButtonItem {
        
        let btn = UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: 44))
        btn.contentHorizontalAlignment = isLeft ? .left : .right
        btn.setImage(UIImage(named: normalName), for: UIControlState())
        if highlightedName != nil {
            btn.setImage(UIImage(named: highlightedName!), for: UIControlState.highlighted)
        }
        btn.addTarget(self, action: isLeft ? #selector(MATBaseViewController.navLeftBtnClicked) : #selector(MATBaseViewController.navRightBtnClicked), for: .touchUpInside)
        
        return UIBarButtonItem(customView: btn)
    }

}

extension MATBaseViewController {
    var floatingTipMsgViewOffsetY: CGFloat {
        
        return MATConstant.NavigationBarHeight
    }
    
    func showFloatingTipMessage(_ msg: String) {
        let tipViewHeight: CGFloat = 33
        
        // view hierarchy
        let tipMsgView = UIView()
        view.addSubview(tipMsgView)
        tipMsgView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.view).offset(self.floatingTipMsgViewOffsetY)
            make.left.equalTo(self.view)
            make.right.equalTo(self.view)
            make.height.equalTo(tipViewHeight)
        }
        
        // -
        let textView = UIView()
        tipMsgView.addSubview(textView)
        textView.snp.makeConstraints { (make) -> Void in
            make.edges.equalTo(tipMsgView)
        }
        
        // --
        let label = UILabel()
        textView.addSubview(label)
        label.snp.makeConstraints { (make) -> Void in
            make.edges.equalTo(textView).inset(UIEdgeInsetsMake(0, 20, 0, 20))
        }
        
        
        // view config
        tipMsgView.clipsToBounds = true
        
        textView.backgroundColor = UIColor.fcb_colorWithHexString("2B79FB", alpha: 0.8)
        
        label.backgroundColor = UIColor.clear
        label.textColor = UIColor.white
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 13)
        label.text = msg
        
        
        // add show animation
        let showAnimation = CABasicAnimation(keyPath: "position.y")
        showAnimation.fromValue = -tipViewHeight
        showAnimation.toValue = 0
        showAnimation.isAdditive = true
        showAnimation.duration = 0.2
        showAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        textView.layer.add(showAnimation, forKey: "showAnimation")
        
        
        // auto remove tip view
        let duration: TimeInterval = 2
        let delay = DispatchTime.now() + Double(Int64(duration * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
        DispatchQueue.main.asyncAfter(deadline: delay) { () -> Void in
            
            textView.alpha = 0
            
            CATransaction.begin()
            
            let yAnimation = CABasicAnimation(keyPath: "position.y")
            yAnimation.fromValue = 0
            yAnimation.toValue = -tipViewHeight
            yAnimation.isAdditive = true
            yAnimation.duration = 0.2
            yAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
            
            let alphaAnimation = CABasicAnimation(keyPath: "opacity")
            alphaAnimation.fromValue = 1
            alphaAnimation.toValue = 0
            alphaAnimation.isAdditive = true
            alphaAnimation.duration = 0.2
            alphaAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
            
            let hideAnimationGroup = CAAnimationGroup()
            hideAnimationGroup.animations = [yAnimation, alphaAnimation]
            hideAnimationGroup.duration = 0.2
            
            CATransaction.setCompletionBlock({ () -> Void in
                tipMsgView.removeFromSuperview()
                
            })
            
            textView.layer.add(hideAnimationGroup, forKey: "hideAnimation")
        }
    }
}

