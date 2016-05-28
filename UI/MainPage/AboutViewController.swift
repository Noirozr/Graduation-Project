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
    private func p_constructSubviews() {
        
        let imageView = UIImageView()
        imageView.image = UIImage(named: "icon")
        self.view.addSubview(imageView)
        imageView.snp_makeConstraints() { (make) -> Void in
            make.centerX.equalTo(self.view)
            make.top.equalTo(self.view).offset(MATConstant.NavigationBarHeight + 60)
        }
        
        let rightLabel = UILabel()
        self.view.addSubview(rightLabel)
        rightLabel.snp_makeConstraints() { (make) -> Void in
            make.top.equalTo(imageView.snp_bottom).offset(15)
            make.leading.equalTo(self.view).offset(15)
            make.trailing.equalTo(self.view).offset(-15)
            make.centerX.equalTo(self.view)
        }
        
        let feedBackView = UIView()
        self.view.addSubview(feedBackView)
        feedBackView.snp_makeConstraints() { (make) -> Void in
            make.bottom.equalTo(self.view).offset(-20)
            make.width.equalTo(self.view)
            make.height.equalTo(43)
        }
        
        let feedBackLabel = UILabel()
        feedBackView.addSubview(feedBackLabel)
        feedBackLabel.snp_makeConstraints() { (make) -> Void in
            make.centerX.equalTo(feedBackView)
            make.top.equalTo(feedBackView)
            make.height.equalTo(feedBackView)
        }
        
        let shareView = UIView()
        self.view.addSubview(shareView)
        shareView.snp_makeConstraints() { (make) -> Void in
            make.bottom.equalTo(feedBackView.snp_top).offset(-10)
            make.width.equalTo(self.view)
            make.height.equalTo(43)
        }
        
        let shareLabel = UILabel()
        shareView.addSubview(shareLabel)
        shareLabel.snp_makeConstraints() { (make) -> Void in
            make.centerX.equalTo(shareView)
            make.top.equalTo(shareView)
            make.height.equalTo(shareView)
        }
        
        rightLabel.text = "Copyright © Yongjia Liu. All rights reserved. \nThis application is provided for education purposes only, and is intended for personal, non-commercial use. Product specifications are subject to change without notice.\n  \n此应用程序仅供教育使用，适用于个人和非商业用途。产品规格如有变更，恕不告知。"
        rightLabel.numberOfLines = 0
        rightLabel.textColor = UIColor.blackColor()
        rightLabel.font = UIFont.systemFontOfSize(18)
        
        feedBackView.backgroundColor = UIColor.clearColor()
        feedBackLabel.text = "FeedBack"
        feedBackLabel.textColor = UIColor.fcb_colorWithHexString("2B79FB")
        feedBackLabel.font = UIFont.systemFontOfSize(20)
        
        let feedbackTap = UITapGestureRecognizer()
        feedBackView.addGestureRecognizer(feedbackTap)
        feedbackTap.addTarget(self, action: #selector(AboutViewController.feedBack))
        
        shareView.backgroundColor = UIColor.clearColor()
        shareLabel.text = "Share"
        shareLabel.textColor = UIColor.fcb_colorWithHexString("2B79FB")
        shareLabel.font = UIFont.systemFontOfSize(20)
        
        let shareTap = UITapGestureRecognizer()
        shareView.addGestureRecognizer(shareTap)
        shareTap.addTarget(self, action: #selector(AboutViewController.share))
    }
    
    //MARK: - Events
    func feedBack() {
        let alert = UIAlertController(title: "Feedback", message: "选择反馈方式", preferredStyle: .Alert)
        let mailAction = UIAlertAction(title: "邮箱", style: .Default){ (action) in
            if MFMailComposeViewController.canSendMail() {
                let mailComposeVC = MFMailComposeViewController()
                mailComposeVC.mailComposeDelegate = self
                mailComposeVC.setToRecipients(["noirozr@icloud.com"])
                mailComposeVC.setSubject("应用反馈")
                self.presentViewController(mailComposeVC, animated: true, completion: nil)
            } else {
                self.showFloatingTipMessage("设备还没有添加邮件账户")
            }
            
        }
        let weChatAction = UIAlertAction(title: "微信", style: .Default) { (action) in
            let pasteBoard = UIPasteboard.generalPasteboard()
            pasteBoard.string = "1074199235"
            self.showFloatingTipMessage("已复制 L.Y.J 的微信到剪切板")
        }
        let cancelAction = UIAlertAction(title: "取消", style: .Cancel) { (_) in }
        alert.addAction(mailAction)
        alert.addAction(weChatAction)
        alert.addAction(cancelAction)
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func share() {
        let textToShare = "I am learning Data Structures and Algorithm with Material on iOS"
        let activityItems = [textToShare]
        let shareActivityViewController = UIActivityViewController(activityItems: activityItems, applicationActivities: [])
        self.navigationController?.presentViewController(shareActivityViewController, animated: true) {
            self.showFloatingTipMessage("Executing")
        }
    }

}

//MARK: - MFMailComposeViewControllerDelegate
extension AboutViewController: MFMailComposeViewControllerDelegate {
    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        controller.dismissViewControllerAnimated(true, completion: nil)
    }
}