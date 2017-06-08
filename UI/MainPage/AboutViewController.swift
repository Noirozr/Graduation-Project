//
//  AboutViewController.swift
//  Material
//
//  Created by Noirozr on 16/3/29.
//  Copyright © 2016年 Yongjia Liu. All rights reserved.
//

import UIKit
import MessageUI

class AboutViewController: MATBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "About"
        
        p_constructSubviews()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: - Private Methods
    fileprivate func p_constructSubviews() {
        
        let imageView = UIImageView()
        imageView.image = UIImage(named: "icon")
        self.view.addSubview(imageView)
        imageView.snp.makeConstraints() { (make) -> Void in
            make.centerX.equalTo(self.view)
            make.top.equalTo(self.view).offset(MATConstant.NavigationBarHeight + 60)
        }
        
        let rightLabel = UILabel()
        self.view.addSubview(rightLabel)
        rightLabel.snp.makeConstraints() { (make) -> Void in
            make.top.equalTo(imageView.snp.bottom).offset(15)
            make.leading.equalTo(self.view).offset(30)
            make.trailing.equalTo(self.view).offset(-30)
            make.centerX.equalTo(self.view)
        }
        
        let feedBackView = UIView()
        self.view.addSubview(feedBackView)
        feedBackView.snp.makeConstraints() { (make) -> Void in
            make.bottom.equalTo(self.view).offset(-20)
            make.width.equalTo(self.view)
            make.height.equalTo(43)
        }
        
        let feedBackLabel = UILabel()
        feedBackView.addSubview(feedBackLabel)
        feedBackLabel.snp.makeConstraints() { (make) -> Void in
            make.centerX.equalTo(feedBackView)
            make.top.equalTo(feedBackView)
            make.height.equalTo(feedBackView)
        }
        
        let shareView = UIView()
        self.view.addSubview(shareView)
        shareView.snp.makeConstraints() { (make) -> Void in
            make.bottom.equalTo(feedBackView.snp.top).offset(-10)
            make.width.equalTo(self.view)
            make.height.equalTo(43)
        }
        
        let shareLabel = UILabel()
        shareView.addSubview(shareLabel)
        shareLabel.snp.makeConstraints() { (make) -> Void in
            make.centerX.equalTo(shareView)
            make.top.equalTo(shareView)
            make.height.equalTo(shareView)
        }
        
        rightLabel.text = "Copyright © Yongjia Liu. All rights reserved. \nThis application is provided for education purposes only, and is intended for personal, non-commercial use. Product specifications are subject to change without notice.\n"
        rightLabel.numberOfLines = 0
        rightLabel.textColor = UIColor.black
        rightLabel.font = UIFont.systemFont(ofSize: 18)
        
        feedBackView.backgroundColor = UIColor.clear
        feedBackLabel.text = "FeedBack"
        feedBackLabel.textColor = UIColor.fcb_colorWithHexString("2B79FB")
        feedBackLabel.font = UIFont.systemFont(ofSize: 20)
        
        let feedbackTap = UITapGestureRecognizer()
        feedBackView.addGestureRecognizer(feedbackTap)
        feedbackTap.addTarget(self, action: #selector(AboutViewController.feedBack))
        
        shareView.backgroundColor = UIColor.clear
        shareLabel.text = "Share"
        shareLabel.textColor = UIColor.fcb_colorWithHexString("2B79FB")
        shareLabel.font = UIFont.systemFont(ofSize: 20)
        
        let shareTap = UITapGestureRecognizer()
        shareView.addGestureRecognizer(shareTap)
        shareTap.addTarget(self, action: #selector(AboutViewController.share))
    }
    
    //MARK: - Events
    func feedBack() {
        let alert = UIAlertController(title: "Feedback", message: "选择反馈方式", preferredStyle: .alert)
        let mailAction = UIAlertAction(title: "邮箱", style: .default){ (action) in
            if MFMailComposeViewController.canSendMail() {
                let mailComposeVC = MFMailComposeViewController()
                mailComposeVC.mailComposeDelegate = self
                mailComposeVC.setToRecipients(["noirozr@icloud.com"])
                mailComposeVC.setSubject("应用反馈")
                self.present(mailComposeVC, animated: true, completion: nil)
            } else {
                self.showFloatingTipMessage("设备还没有添加邮件账户")
            }
            
        }
        let weChatAction = UIAlertAction(title: "微信", style: .default) { (action) in
            let pasteBoard = UIPasteboard.general
            pasteBoard.string = "1074199235"
            self.showFloatingTipMessage("已复制 L.Y.J 的微信到剪切板")
        }
        let cancelAction = UIAlertAction(title: "取消", style: .cancel) { (_) in }
        alert.addAction(mailAction)
        alert.addAction(weChatAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    func share() {
        let textToShare = "I am learning Data Structures and Algorithm with Material on iOS"
        let activityItems = [textToShare]
        let shareActivityViewController = UIActivityViewController(activityItems: activityItems, applicationActivities: [])
        self.navigationController?.present(shareActivityViewController, animated: true) {
            self.showFloatingTipMessage("Executing")
        }
    }

}

//MARK: - MFMailComposeViewControllerDelegate
extension AboutViewController: MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
}
