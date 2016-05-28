//
//  TPViewController.swift
//  Material
//
//  Created by Noirozr on 16/4/5.
//  Copyright © 2016年 Yongjia Liu. All rights reserved.
//

import UIKit
import PNChart

class TPViewController: MATBaseViewController {
    
    private var p_aValue = 0
    private var p_dValue = 0
    private var p_items: [PNPieChartDataItem] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Total Progress"
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
        
        titleLabel.text = "Current Algorithm Learning Progress"
        titleLabel.textAlignment = .Center
        titleLabel.textColor = UIColor.fcb_colorWithHexString("2B76FD")
        titleLabel.backgroundColor = UIColor.clearColor()
        titleLabel.font = UIFont.systemFontOfSize(20)
        
        guard let aData = NSUserDefaults.standardUserDefaults().objectForKey("ASP") as? [Int],
                let dData = NSUserDefaults.standardUserDefaults().objectForKey("DSP") as? [Int] else {
            return
        }
        
        for item in aData {
            if (item > 0) {
                p_aValue = p_aValue + 1
            }
        }
        
        for item in dData {
            if (item > 0) {
                p_dValue = p_dValue + 1
            }
        }

        let rest = DSTotal + ALTotal - self.p_aValue - self.p_dValue
        
        if p_aValue + p_dValue > 0 {
            self.p_items = [PNPieChartDataItem(value: CGFloat(p_aValue), color: UIColor.fcb_colorWithHexString("2B76FD"), description: "Algorithm"), PNPieChartDataItem(value: CGFloat(p_dValue), color: UIColor.fcb_colorWithHexString("508DBB"), description: "Data Structures"),
                         PNPieChartDataItem(value: CGFloat(rest), color: UIColor.fcb_colorWithHexString("96160B"), description: "Rest")]
        } else {
            self.p_items = [PNPieChartDataItem(value: CGFloat(p_aValue + p_dValue), color: UIColor.fcb_colorWithHexString("2B76FD"), description: "Current"),PNPieChartDataItem(value: CGFloat(rest), color: UIColor.fcb_colorWithHexString("96160B"), description: "Rest")]
        }
        
        let pieChart = PNPieChart(frame: CGRectMake(0, 0, self.view.frame.size.width - 30, 200), items: self.p_items)
        self.view.addSubview(pieChart)
        pieChart.snp_makeConstraints() { (make) -> Void in
            make.top.equalTo(titleLabel.snp_bottom).offset(MATConstant.NavigationBarHeight + 30)
            make.leading.equalTo(self.view).offset(15)
            make.trailing.equalTo(self.view).offset(-15)
            make.height.equalTo(200)
        }
        pieChart.descriptionTextColor = UIColor.fcb_colorWithHexString("1A323E")
        pieChart.descriptionTextFont = UIFont(name: "Avenir", size: 18)
        pieChart.strokeChart()
    }
}
