//
//  TPRViewController.swift
//  Material
//
//  Created by Noirozr on 16/3/31.
//  Copyright © 2016年 Yongjia Liu. All rights reserved.
//

import UIKit
import YYText
import SafariServices

let scrHeight = UIScreen.main.bounds.height

class TPRViewController: MATBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Third Party Resources"
        
        p_constructSubviews()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: - Private Methods
    fileprivate func p_constructSubviews() {
        
        let algorithmView = UIView()
        self.view.addSubview(algorithmView)
        algorithmView.snp_makeConstraints() { (make) -> Void in
            make.top.equalTo(self.view).offset(MATConstant.NavigationBarHeight + 10)
            make.leading.equalTo(self.view).offset(15)
            make.trailing.equalTo(self.view).offset(-15)
            make.height.equalTo((scrHeight - MATConstant.NavigationBarHeight - 30)/2)
            //scrHeight
        }
        
        let algorithmTitleLabel = YYLabel()
        algorithmView.addSubview(algorithmTitleLabel)
        algorithmTitleLabel.snp_makeConstraints() { (make) -> Void in
            make.top.equalTo(algorithmView)
            make.leading.equalTo(self.view).offset(15)
            make.trailing.equalTo(self.view).offset(-15)
            make.height.equalTo(29)
        }
        
        algorithmView.backgroundColor = UIColor.white
        
        let algorithmIntroductionLabel = UILabel()
        algorithmView.addSubview(algorithmIntroductionLabel)
        algorithmIntroductionLabel.snp_makeConstraints() { (make) -> Void in
            make.top.equalTo(algorithmTitleLabel.snp_bottom)
            make.leading.equalTo(algorithmTitleLabel)
            make.trailing.equalTo(algorithmTitleLabel)
            make.height.equalTo(85)
        }
        
        algorithmTitleLabel.text = "Algorithm Courses"
        algorithmTitleLabel.textColor = UIColor.fcb_colorWithHexString("2B76FD")
        algorithmTitleLabel.font = UIFont.systemFont(ofSize: 26)
        
        algorithmIntroductionLabel.text = "An algorithm is an effective method that can be expressed within a finite amount of space and time and in a well-defined formal language for calculating a function."
        algorithmIntroductionLabel.numberOfLines = 0
        algorithmIntroductionLabel.textColor = UIColor.fcb_colorWithHexString("2B76FD")
        
        let albiView = UIView()
        algorithmView.addSubview(albiView)
        albiView.snp_makeConstraints() { (make) -> Void in
            make.top.equalTo(algorithmIntroductionLabel.snp_bottom).offset(30)
            make.leading.equalTo(algorithmTitleLabel).offset(15)
            make.trailing.equalTo(algorithmTitleLabel).offset(-15)
            make.height.equalTo(43)
        }
        
        let albiLabel = UILabel()
        albiView.addSubview(albiLabel)
        albiLabel.snp_makeConstraints() { (make) -> Void in
            make.centerX.equalTo(albiView)
            make.top.equalTo(albiView)
            make.height.equalTo(albiView)
        }
        
        albiView.backgroundColor = UIColor.fcb_colorWithHexString("2B76FD")
        albiLabel.text = "Source: Bilibili"
        albiLabel.textColor = UIColor.white
        albiLabel.font = UIFont.systemFont(ofSize: 20)
        
        let alBilibiliTap = UITapGestureRecognizer()
        albiView.addGestureRecognizer(alBilibiliTap)
        alBilibiliTap.addTarget(self, action: #selector(TPRViewController.albilibilitapped))
        
        let alitunesuView = UIView()
        algorithmView.addSubview(alitunesuView)
        alitunesuView.snp_makeConstraints() { (make) -> Void in
            make.top.equalTo(albiView.snp_bottom).offset(5)
            make.leading.equalTo(algorithmTitleLabel).offset(15)
            make.trailing.equalTo(algorithmTitleLabel).offset(-15)
            make.height.equalTo(43)
        }
        
        let alitunesuLabel = UILabel()
        alitunesuView.addSubview(alitunesuLabel)
        alitunesuLabel.snp_makeConstraints() { (make) -> Void in
            make.centerX.equalTo(alitunesuView)
            make.top.equalTo(alitunesuView)
            make.height.equalTo(alitunesuView)
        }
        
        alitunesuView.backgroundColor = UIColor.fcb_colorWithHexString("2B76FD")
        alitunesuLabel.text = "Source: iTunes U"
        alitunesuLabel.textColor = UIColor.white
        alitunesuLabel.font = UIFont.systemFont(ofSize: 20)
        
        let alitunesuTap = UITapGestureRecognizer()
        alitunesuView.addGestureRecognizer(alitunesuTap)
        alitunesuTap.addTarget(self, action: #selector(TPRViewController.alitunesuapped))
        
        let alNeteaseView = UIView()
        algorithmView.addSubview(alNeteaseView)
        alNeteaseView.snp_makeConstraints() { (make) -> Void in
            make.top.equalTo(alitunesuView.snp_bottom).offset(5)
            make.leading.equalTo(algorithmTitleLabel).offset(15)
            make.trailing.equalTo(algorithmTitleLabel).offset(-15)
            make.height.equalTo(43)
        }
        
        let alNeteaseLabel = UILabel()
        alNeteaseView.addSubview(alNeteaseLabel)
        alNeteaseLabel.snp_makeConstraints() { (make) -> Void in
            make.centerX.equalTo(alNeteaseView)
            make.top.equalTo(alNeteaseView)
            make.height.equalTo(alNeteaseView)
        }
        
        alNeteaseView.backgroundColor = UIColor.fcb_colorWithHexString("2B76FD")
        alNeteaseLabel.text = "Source: Netease Open Course"
        alNeteaseLabel.textColor = UIColor.white
        alNeteaseLabel.font = UIFont.systemFont(ofSize: 20)
        
        let alNeteaseTap = UITapGestureRecognizer()
        alNeteaseView.addGestureRecognizer(alNeteaseTap)
        alNeteaseTap.addTarget(self, action: #selector(TPRViewController.alneteasetapped))
        
        let DSView = UIView()
        self.view.addSubview(DSView)
        DSView.snp_makeConstraints() { (make) -> Void in
            make.top.equalTo(algorithmView.snp_bottom).offset(10)
            make.leading.equalTo(self.view).offset(15)
            make.trailing.equalTo(self.view).offset(-15)
            make.height.equalTo((scrHeight - MATConstant.NavigationBarHeight - 30)/2)
        }
        
        let DSTitleLabel = YYLabel()
        DSView.addSubview(DSTitleLabel)
        DSTitleLabel.snp_makeConstraints() { (make) -> Void in
            make.top.equalTo(DSView)
            make.leading.equalTo(self.view).offset(15)
            make.trailing.equalTo(self.view).offset(-15)
            make.height.equalTo(29)
        }
        
        let DSIntroductionLabel = UILabel()
        DSView.addSubview(DSIntroductionLabel)
        DSIntroductionLabel.snp_makeConstraints() { (make) -> Void in
            make.top.equalTo(DSTitleLabel.snp_bottom)
            make.leading.equalTo(DSTitleLabel)
            make.trailing.equalTo(DSTitleLabel)
            make.height.equalTo(70)
        }
        
        DSView.backgroundColor = UIColor.white
        
        DSTitleLabel.text = "Data Structures Courses"
        DSTitleLabel.textColor = UIColor.fcb_colorWithHexString("2B76FD")
        DSTitleLabel.font = UIFont.systemFont(ofSize: 26)
        
        DSIntroductionLabel.text = "A data structure is a particular way of organizing data in a computer so that it can be used efficiently."
        DSIntroductionLabel.numberOfLines = 0
        DSIntroductionLabel.textColor = UIColor.fcb_colorWithHexString("2B76FD")
        
        let DSitunesuView = UIView()
        DSView.addSubview(DSitunesuView)
        DSitunesuView.snp_makeConstraints() { (make) -> Void in
            make.top.equalTo(DSIntroductionLabel.snp_bottom).offset(30)
            make.leading.equalTo(DSIntroductionLabel).offset(15)
            make.trailing.equalTo(DSIntroductionLabel).offset(-15)
            make.height.equalTo(43)
        }
        
        let DSitunesuLabel = UILabel()
        DSitunesuView.addSubview(DSitunesuLabel)
        DSitunesuLabel.snp_makeConstraints() { (make) -> Void in
            make.centerX.equalTo(DSitunesuView)
            make.top.equalTo(DSitunesuView)
            make.height.equalTo(DSitunesuView)
        }
        
        DSitunesuView.backgroundColor = UIColor.fcb_colorWithHexString("2B76FD")
        DSitunesuLabel.text = "Source: iTunes U"
        DSitunesuLabel.textColor = UIColor.white
        DSitunesuLabel.font = UIFont.systemFont(ofSize: 20)
        
        let DSitunesuTap = UITapGestureRecognizer()
        DSitunesuView.addGestureRecognizer(DSitunesuTap)
        DSitunesuTap.addTarget(self, action: #selector(TPRViewController.dsitunesuapped))
        
    }
    
    //MARK: - Event
    func albilibilitapped() {
        if (UIApplication.shared.canOpenURL(URL(string: "bilibili://")!)) {
            UIApplication.shared.openURL(URL(string: "bilibili://?av=3372873")!)
        } else {
            let nextVC = SFSafariViewController(url: URL(string: "http://www.bilibili.com/video/av3372873/")!)
            navigationController?.pushViewController(nextVC, animated: true)
        }
        
    }
    
    func alitunesuapped() {
        
        let nextVC = SFSafariViewController(url: URL(string: "https://itunes.apple.com/cn/itunes-u/introduction-to-algorithms/id341597754?mt=10")!)
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
    func alneteasetapped() {
        
        let nextVC = SFSafariViewController(url: URL(string: "http://open.163.com/special/opencourse/algorithms.html")!)
        navigationController?.pushViewController(nextVC, animated: true)
        
    }
    
    func dsitunesuapped() {
        let nextVC = SFSafariViewController(url: URL(string: "https://itunes.apple.com/cn/itunes-u/advanced-data-structures/id735348884?mt=10")!)
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
    
}
