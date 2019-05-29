//
//  Presentable.swift
//  gg4
//
//  Created by VARVAR on 27.12.2018.
//  Copyright © 2018 GoodGame. All rights reserved.
//

import UIKit

protocol Presentable {
    func toPresent() -> UIViewController?
}

extension UIViewController: Presentable {
    func toPresent() -> UIViewController? {
        return self
    }
}
