//
//  UIStoryboard.swift
//  gg4
//
//  Created by VARVAR on 08.02.2019.
//  Copyright © 2019 GoodGame. All rights reserved.
//

import Foundation
import UIKit

extension UIStoryboard {
    
    static func initViewController<T: UIViewController>(withType type: T.Type) -> T {
        let storyboard = UIStoryboard(name: T.className, bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: T.className) as! T
    }
    
    static func initViewController<T: UIViewController>(name: String = "Main", withType type: T.Type) -> T {
        let storyboard = UIStoryboard(name: name, bundle: Bundle.main)
        return storyboard.instantiateViewController(withIdentifier: T.className) as! T
    }
    
}
