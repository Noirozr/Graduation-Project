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
    
    public class func fcb_colorWithHexString(stringToConvert: String, var alpha: CGFloat) -> UIColor {
        if (alpha > 1 || alpha < 0) {
            alpha = 0
        }
        
        var convertedString: NSString = stringToConvert
        convertedString = convertedString.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        
        if convertedString.length != 6 {
            return UIColor.whiteColor()
        }
        
        if convertedString.hasPrefix("0X") {
            convertedString = convertedString.substringFromIndex(2)
        }
        
        if convertedString.hasPrefix("#") {
            convertedString = convertedString.substringFromIndex(1)
        }
        
        var range = NSMakeRange(0, 2)
        let redColorString: NSString = convertedString.substringWithRange(range)
        
        range.location = 2
        let greenColorString: NSString = convertedString.substringWithRange(range)
        
        range.location = 4
        let blueColorString: NSString = convertedString.substringWithRange(range)
        
        var redColor: UInt32 = 0
        var greenColor: UInt32 = 0
        var blueColor: UInt32 = 0
        
        NSScanner(string: redColorString as String).scanHexInt(&redColor)
        NSScanner(string: greenColorString as String).scanHexInt(&greenColor)
        NSScanner(string: blueColorString as String).scanHexInt(&blueColor)
        
        return UIColor(red: CGFloat(redColor)/255.0, green: CGFloat(greenColor)/255.0, blue: CGFloat(blueColor)/255.0, alpha: alpha)
        
    }
    
    /**
     根据十六进制创建 UIColor
     -parameter stringToConvert: 十六进制文本
     */
    public class func fcb_colorWithHexString(stringToConvert: String) -> UIColor {
        return fcb_colorWithHexString(stringToConvert, alpha: 1.0)
    }
    
    
}
