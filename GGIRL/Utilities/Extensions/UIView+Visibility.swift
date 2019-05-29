//
//  UIView+Visibility.swift
//  GGIRL
//
//  Created by VARVAR on 04.03.2019.
//  Copyright © 2019 GoodGame. All rights reserved.
//

import UIKit
extension UIView {
    var isVisible: Bool {
        get {
            return !self.isHidden
        }
        set {
            self.isHidden = !newValue
        }
    }
}
