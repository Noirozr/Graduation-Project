//
//  UIViewExtension.swift
//  Material
//
//  Created by Noirozr on 16/3/9.
//  Copyright © 2016年 Yongjia Liu. All rights reserved.
//

import UIKit

extension UIView {
    /**
     删除所有子视图
     */
    public func scf_removeAllSubViews() {
        self.subviews.forEach { (subView) -> () in
            subView.removeFromSuperview()
        }
    }
}