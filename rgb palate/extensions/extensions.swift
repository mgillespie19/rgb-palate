//
//  extensions.swift
//  rgb palate
//
//  Created by Max Gillespie on 12/1/18.
//  Copyright © 2018 Max Gillespie. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
}
