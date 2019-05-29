//
//  NormalTraitsViewController.swift
//  GGIRL
//
//  Created by VARVAR on 18.02.2019.
//  Copyright © 2019 GoodGame. All rights reserved.
//

import Foundation
import UIKit

class NormalTraitsViewController: UIViewController {
    override public var traitCollection: UITraitCollection {
        return UIScreen.main.bounds.height > UIScreen.main.bounds.width ? UITraitCollection(traitsFrom:[UITraitCollection(horizontalSizeClass: .compact), UITraitCollection(verticalSizeClass: .regular)]) : UITraitCollection(traitsFrom:[UITraitCollection(horizontalSizeClass: .regular), UITraitCollection(verticalSizeClass: .compact)])
    }
}
