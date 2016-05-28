//
//  RateViewController.swift
//  Material
//
//  Created by Noirozr on 16/4/18.
//  Copyright © 2016年 Yongjia Liu. All rights reserved.
//

import UIKit
import PNChartSwift

class RateViewController: MATBaseViewController {
    
    private var _barChart: PNBarChart?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Rate"
        p_constructSubviews()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:- Private Methods
    private func p_constructSubviews() {
        let segmentedArray = ["Memory", "Best", "Average", "Worst"]
        let segmentedControl = UISegmentedControl(items: segmentedArray)
        self.view.addSubview(segmentedControl)
        segmentedControl.snp_makeConstraints() { (make) -> Void in
            make.top.equalTo(self.view).offset(MATConstant.NavigationBarHeight + 15)
            make.leading.equalTo(self.view).offset(20)
            make.trailing.equalTo(self.view).offset(-20)
            make.height.equalTo(30)
        }
        
        let tipsLabel = UILabel()
        self.view.addSubview(tipsLabel)
        tipsLabel.snp_makeConstraints() { (make) -> Void in
            make.top.equalTo(segmentedControl.snp_bottom).offset(10)
            make.leading.equalTo(self.view).offset(20)
            make.trailing.equalTo(self.view).offset(-20)
            make.height.equalTo(70)
        }
        
        
        let contentView = UIView()
        self.view.addSubview(contentView)
        contentView.snp_makeConstraints() { (make) -> Void in
            make.top.equalTo(tipsLabel.snp_bottom).offset(10)
            make.leading.equalTo(self.view).offset(10)
            make.trailing.equalTo(self.view).offset(-10)
            make.bottom.equalTo(self.view).offset(-50)
        }
        
        let barChart = PNBarChart(frame: CGRectMake(0, 0, self.view.frame.size.width - 30, 200))
        contentView.addSubview(barChart)
        barChart.snp_makeConstraints() { (make) -> Void in
            make.center.equalTo(contentView)
            make.height.equalTo(400)
            make.width.equalTo(400)
        }
        
        segmentedControl.momentary = false
        //segmentedControl.selectedSegmentIndex = 1
        segmentedControl.addTarget(self, action: #selector(RateViewController.rateHandle), forControlEvents: .ValueChanged)
        
        tipsLabel.text = "Attention: 部分数值非常量，此处仅采用常数值作直观参考。变量 N 取 3。触摸上方选择对比内容。"
        tipsLabel.numberOfLines = 0
        
        barChart.xLabels = sortData
        barChart.yValues = Best
        barChart.backgroundColor = UIColor.clearColor()
        barChart.strokeChart()
        
        _barChart = barChart
        _barChart?.hidden = true

    }
    
    func rateHandle(seg: UISegmentedControl) {
        let index = seg.selectedSegmentIndex
        _barChart?.hidden = false
        guard let barChart = _barChart else {
            return
        }
        switch index {
        case 0:
            barChart.yValues = Memory
            barChart.strokeChart()
        case 1:
            barChart.yValues = Best
            barChart.strokeChart()
        case 2:
            //barChart.updateChartData(Average)
            barChart.yValues = Average
            barChart.strokeChart()
        case 3:
            barChart.yValues = Worst
            barChart.strokeChart()
        default:
            print("select wrong")
        }
    }
    
    private func p_rateByMemory() {
        
    }
    
    private func p_rateByWorst() {
        
    }
    
    

}
