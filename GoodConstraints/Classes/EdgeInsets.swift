//
//  EdgeInsets.swift
//  GoodConstraints
//
//  Created by VARVAR on 08.02.2019.
//  Copyright © 2019 GoodGame. All rights reserved.
//

#if os(OSX)
import AppKit
#else
import UIKit
#endif

extension EdgeInsets {
    
    public static func uniform(_ value: CGFloat) -> EdgeInsets {
        return EdgeInsets(top: value, left: value, bottom: value, right: value)
    }
    
    public static func top(_ value: CGFloat) -> EdgeInsets {
        return EdgeInsets(top: value, left: 0, bottom: 0, right: 0)
    }
    
    public static func left(_ value: CGFloat) -> EdgeInsets {
        return EdgeInsets(top: 0, left: value, bottom: 0, right: 0)
    }
    
    public static func bottom(_ value: CGFloat) -> EdgeInsets {
        return EdgeInsets(top: 0, left: 0, bottom: value, right: 0)
    }
    
    public static func right(_ value: CGFloat) -> EdgeInsets {
        return EdgeInsets(top: 0, left: 0, bottom: 0, right: value)
    }
    
    public static func horizontal(_ value: CGFloat) -> EdgeInsets {
        return EdgeInsets(top: 0, left: value, bottom: 0, right: value)
    }
    
    public static func vertical(_ value: CGFloat) -> EdgeInsets {
        return EdgeInsets(top: value, left: 0, bottom: value, right: 0)
    }
}

public func + (lhs: EdgeInsets, rhs: EdgeInsets) -> EdgeInsets {
    return .init(top: lhs.top + rhs.top, left: lhs.left + rhs.left, bottom: lhs.bottom + rhs.bottom, right: lhs.right + rhs.right)
}
