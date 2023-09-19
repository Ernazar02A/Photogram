//
//  extention + UIColor.swift
//  FinallyApp
//
//  Created by Ernazar on 20/9/23.
//

import UIKit

extension UIColor {
    static func setColor(lightColor: UIColor, darkColor: UIColor) -> UIColor {
        return UIColor { (traitCollection) -> UIColor in
            return traitCollection.userInterfaceStyle == .dark ? darkColor : lightColor
        }
    }
}
