//
//  DSPViewController.swift
//  Material
//
//  Created by Noirozr on 16/4/4.
//  Copyright © 2016年 Yongjia Liu. All rights reserved.
//

import UIKit
import PNChart

class DSPViewController: MATBaseViewController {
    
    private var current = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Current Progress"
        p_constructSubviews()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Private Methods
    private func p_constructSubviews() {
        let titleLabel = UILabel()
        self.view.addSubview(titleLabel)
        titleLabel.snp_makeConstraints() { (make) -> Void in
            make.top.equalTo(self.view).offset(MATConstant.NavigationBarHeight + 15)
            make.leading.equalTo(self.view).offset(15)
            make.trailing.equalTo(self.view).offset(-15)
            make.height.equalTo(63)
        }
        
        titleLabel.text = "Current Data Structures Learning Progress"
        titleLabel.textAlignment = .Center
        titleLabel.textColor = UIColor.fcb_colorWithHexString("2B76FD")
        titleLabel.backgroundColor = UIColor.clearColor()
        titleLabel.font = UIFont.systemFontOfSize(20)
        
        guard let data = NSUserDefaults.standardUserDefaults().objectForKey("DSP") as? [Int] else {
            return
        }
        
        for item in data {
            if (item > 0) {
                current = current + 1
            }
        }
        let circleChart = PNCircleChart(frame: CGRectMake(0, 0, self.view.frame.size.width - 30, 200), total: 8, current: self.current, clockwise: false, shadow: false, shadowColor: UIColor.whiteColor())
        self.view.addSubview(circleChart)
        circleChart.snp_makeConstraints() { (make) -> Void in
            make.top.equalTo(titleLabel.snp_bottom).offset(15)
            make.leading.equalTo(self.view).offset(15)
            make.trailing.equalTo(self.view).offset(-15)
            make.height.equalTo(200)
        }
        

        
        circleChart.backgroundColor = UIColor.clearColor()
        circleChart.strokeColor = UIColor.fcb_colorWithHexString("2B76FD")
        circleChart.strokeChart()
    }
    

}
