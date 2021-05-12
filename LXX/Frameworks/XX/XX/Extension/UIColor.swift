//
//  UIColor+Extension.swift
//  TDMVideo
//
//  Created by lben on 2020/5/19.
//  Copyright © 2020 xunlei.com. All rights reserved.
//

#if os(iOS)
    import UIKit

    public extension UIColor {
        ///
        static func hexString(_ hexString: String) -> UIColor {
            return UIColor(hexString: hexString) ?? .red
        }

        convenience init?(hexString: String, transparency: CGFloat = 1) {
            var string = ""
            if hexString.lowercased().hasPrefix("0x") {
                string = hexString.replacingOccurrences(of: "0x", with: "")
            } else if hexString.hasPrefix("#") {
                string = hexString.replacingOccurrences(of: "#", with: "")
            } else {
                string = hexString
            }

            if string.count == 3 { // convert hex to 6 digit format if in short format
                var str = ""
                string.forEach { str.append(String(repeating: String($0), count: 2)) }
                string = str
            }

            guard let hexValue = Int(string, radix: 16) else { return nil }

            var trans = transparency
            if trans < 0 { trans = 0 }
            if trans > 1 { trans = 1 }

            let red = (hexValue >> 16) & 0xFF
            let green = (hexValue >> 8) & 0xFF
            let blue = hexValue & 0xFF
            self.init(red: red, green: green, blue: blue, transparency: trans)
        }

        convenience init?(red: Int, green: Int, blue: Int, transparency: CGFloat = 1) {
            guard red >= 0 && red <= 255 else { return nil }
            guard green >= 0 && green <= 255 else { return nil }
            guard blue >= 0 && blue <= 255 else { return nil }

            var trans = transparency
            if trans < 0 { trans = 0 }
            if trans > 1 { trans = 1 }

            self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: trans)
        }

        convenience init(rgb rgbValue: Int) {
            self.init(rgb: rgbValue, alpha: 1)
        }

        convenience init(rgb rgbValue: Int, alpha: CGFloat) {
            self.init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                      green: CGFloat((rgbValue & 0xFF00) >> 8) / 255.0,
                      blue: CGFloat(rgbValue & 0xFF) / 255,
                      alpha: 1)
        }
    }
#endif
