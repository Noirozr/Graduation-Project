//
//  MATNavigationViewController.swift
//  Material
//
//  Created by Noirozr on 16/2/5.
//  Copyright © 2016年 Yongjia Liu. All rights reserved.
//

import UIKit

class MATNavigationViewController: UINavigationController {
    
    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle:nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        interactivePopGestureRecognizer?.delegate = self
        delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func pushViewController(viewController: UIViewController, animated: Bool) {
        interactivePopGestureRecognizer?.enabled = false
        super.pushViewController(viewController, animated: animated)
    }
}

extension MATNavigationViewController: UIGestureRecognizerDelegate {
    
    func gestureRecognizerShouldBegin(gestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}

extension MATNavigationViewController: UINavigationControllerDelegate {
    func navigationController(navigationController: UINavigationController, didShowViewController viewController: UIViewController, animated: Bool) {
        interactivePopGestureRecognizer?.enabled = navigationController.viewControllers.count > 1
    }
}