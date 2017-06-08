//
//  UIColorExtension.swift
//  Material
//
//  Created by Noirozr on 16/3/1.
//  Copyright © 2016年 Yongjia Liu. All rights reserved.
//

import UIKit

extension UIColor {
    
    /**
    根据十六进制和 alpha 值创建 UIColor
    -parameter stringToConvert: 十六进制文本
    -parameter  alpha:  alpha 值，范围: [0.0, 1.0]
    */
    
    public class func fcb_colorWithHexString(_ stringToConvert: String, alpha: CGFloat) -> UIColor {
        var alpha = alpha
        if (alpha > 1 || alpha < 0) {
            alpha = 0
        }
        
        var convertedString: NSString = stringToConvert as NSString
        convertedString = convertedString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) as NSString
        
        if convertedString.length != 6 {
            return UIColor.white
        }
        
        if convertedString.hasPrefix("0X") {
            convertedString = convertedString.substring(from: 2) as NSString
        }
        
        if convertedString.hasPrefix("#") {
            convertedString = convertedString.substring(from: 1) as NSString
        }
        
        var range = NSMakeRange(0, 2)
        let redColorString: NSString = convertedString.substring(with: range) as NSString
        
        range.location = 2
        let greenColorString: NSString = convertedString.substring(with: range) as NSString
        
        range.location = 4
        let blueColorString: NSString = convertedString.substring(with: range) as NSString
        
        var redColor: UInt32 = 0
        var greenColor: UInt32 = 0
        var blueColor: UInt32 = 0
        
        Scanner(string: redColorString as String).scanHexInt32(&redColor)
        Scanner(string: greenColorString as String).scanHexInt32(&greenColor)
        Scanner(string: blueColorString as String).scanHexInt32(&blueColor)
        
        return UIColor(red: CGFloat(redColor)/255.0, green: CGFloat(greenColor)/255.0, blue: CGFloat(blueColor)/255.0, alpha: alpha)
        
    }
    
    /**
     根据十六进制创建 UIColor
     -parameter stringToConvert: 十六进制文本
     */
    public class func fcb_colorWithHexString(_ stringToConvert: String) -> UIColor {
        return fcb_colorWithHexString(stringToConvert, alpha: 1.0)
    }
    
    
}
