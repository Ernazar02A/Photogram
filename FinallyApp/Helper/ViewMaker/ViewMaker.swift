//
//  ViewMaker.swift
//  FinallyApp
//
//  Created by Ernazar on 20/9/23.
//

import UIKit

class ViewMaker {
    static let shared = ViewMaker()
    
    func makeLabel(text: String = "", font: UIFont = .systemFont(ofSize: 16, weight: .regular), numberOfLines: Int = 0, alignment: NSTextAlignment = .left, opacity: Float = 1.0) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = font
        label.textColor = UIColor.setColor(lightColor: .black, darkColor: .white)
        label.layer.opacity = opacity
        label.numberOfLines = numberOfLines
        label.textAlignment = alignment
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
}
