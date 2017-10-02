//
//  UIColor.swift
//  AHOnline
//
//  Created by Ara Hakobyan on 7/9/16.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

import UIKit

extension UIColor {
    
    open class var xaki_: UIColor {
        let color = UIColor(red: 255/255,   green: 102/255, blue: 51/255,   alpha: 1)
        return color
    }
    
    open class var red_: UIColor {
        let color = UIColor(red: 240/255,   green: 30/255,  blue: 30/255,   alpha: 1)
        return color
    }
    
    open class var blue_: UIColor {
        let color = UIColor(red: 24/255,    green: 75/255,  blue: 152/255,  alpha: 1)
        return color
    }
    
    open class var green_: UIColor {
        let color = UIColor(red: 65/255,    green: 117/255, blue: 5/255,    alpha: 1)
        return color
    }
    
    open class var gray_: UIColor {
        let color = UIColor(red: 150/255,   green: 150/255, blue: 150/255,    alpha: 1)
        return color
    }
    
    open class var blue_light: UIColor {
        let color = UIColor(red: 51/255,    green: 204/255, blue: 255/255,  alpha: 1)
        return color
    }
    
    open class var red_light: UIColor {
        let color = UIColor(red: 232/255,   green: 114/255, blue: 114/255,  alpha: 1)
        return color
    }
    
    open class var red_233: UIColor {
        let color = UIColor(red: 233/255,   green: 110/255, blue: 110/255,  alpha: 1)
        return color
    }
    
    open class var black_59: UIColor {
        let color = UIColor(red: 59/255,    green: 59/255,  blue: 59/255,   alpha: 1)
        return color
    }
    
    open class var gray_164: UIColor {
        let color = UIColor(red: 164/255,   green: 164/255, blue: 164/255,  alpha: 1)
        return color
    }
    
    open class var gray_199: UIColor {
        let color = UIColor(red: 199/255,   green: 199/255, blue: 199/255,  alpha: 1)
        return color
    }
    
    open class var gray_200: UIColor {
        let color = UIColor(red: 200/255,   green: 200/255, blue: 200/255,  alpha: 1)
        return color
    }
    
    open class var gray_239: UIColor {
        let color = UIColor(red: 239/255,   green: 239/255, blue: 239/255,  alpha: 1)
        return color
    }
}

extension UIColor {
    
    convenience init(hex: String) {
        let scanner = Scanner(string: hex)
        scanner.scanLocation = 0
        
        var rgbValue: UInt64 = 0
        
        scanner.scanHexInt64(&rgbValue)
        
        let r = (rgbValue & 0xff0000) >> 16
        let g = (rgbValue & 0xff00) >> 8
        let b = rgbValue & 0xff
        
        self.init(
            red: CGFloat(r) / 0xff,
            green: CGFloat(g) / 0xff,
            blue: CGFloat(b) / 0xff, alpha: 1
        )
    }
}
