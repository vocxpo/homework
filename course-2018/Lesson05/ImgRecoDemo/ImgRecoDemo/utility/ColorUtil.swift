//
//  ColorUtil.swift
//
//  Created by oopx on 2018/03/12.
//  Copyright © 2018年 oopx. All rights reserved.
//

import UIKit
import Foundation

class ColorUtil {
    static func RGBtoUIColor(r: Int, g: Int, b:Int) -> UIColor {
        return UIColor(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: 1.0)
    }

    static func RGBtoUIColor(r: String, g: String, b:String) -> UIColor {
        return UIColor(red: CGFloat(Int(r)!) / 255, green: CGFloat(Int(g)!) / 255, blue: CGFloat(Int(b)!) / 255, alpha: 1.0)
    }
    
    static func getUIColorFromPhotoColor(photoColor: PhotoColor) -> UIColor {
        return UIColor(red: CGFloat(photoColor.r) / 255, green: CGFloat(photoColor.g) / 255, blue: CGFloat(photoColor.b) / 255, alpha: 1.0)
    }
}
