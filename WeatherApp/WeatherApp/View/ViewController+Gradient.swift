//
//  ViewController+Gradient.swift
//  WeatherApp
//
//  Created by Giray Uçar on 14.05.2021.
//

import Foundation
import UIKit

extension UIViewController {
    func createGradientLayer() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.view.bounds
        gradientLayer.colors = [hexStringToUIColor(hex: "#bdc3c7").cgColor , hexStringToUIColor(hex: "#bdc3c7").cgColor ,hexStringToUIColor(hex: "#2c3e50").cgColor]
        self.view.layer.addSublayer(gradientLayer)
    }
    
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }

        if ((cString.count) != 6) {
            return UIColor.gray
        }

        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)

        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
}
