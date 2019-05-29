//
//  UIViewController.swift
//  gg4
//
//  Created by VARVAR on 01.02.2019.
//  Copyright © 2019 GoodGame. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    func add(_ child: UIViewController) {
        addChild(child)
        view.addSubview(child.view)
        child.didMove(toParent: self)
    }
    
    func add(child: UIViewController, into: UIView) {
        addChild(child)
        child.view.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        child.view.frame = into.bounds
        into.addSubview(child.view)
        child.didMove(toParent: self)
    }
    
    func remove() {
        guard parent != nil else { return }
        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }
}
