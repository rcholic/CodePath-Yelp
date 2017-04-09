//
//  CommonSettings.swift
//  Yelp
//
//  Created by Guoliang Wang on 4/9/17.
//  Copyright © 2017 Timothy Lee. All rights reserved.
//

import UIKit

public let checkedImage = UIImage(named: "checked")

public let uncheckedImage = UIImage(named: "unchecked")

public let dropdownImage = UIImage(named: "dropDown")

public let YELP_NAVBAR_TEXT_COLOR: UIColor = .white

public let YELP_RED: UIColor = RGBA(r: 211/255.0, g: 35/255.0, b: 35/255.0, alpha: 1)

public func RGBA(r: CGFloat, g: CGFloat, b: CGFloat, alpha: CGFloat) -> UIColor {
    return UIColor(red: r, green: g, blue: b, alpha: alpha)
}
