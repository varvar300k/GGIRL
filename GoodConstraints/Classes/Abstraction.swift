//
//  Abstraction.swift
//  GoodConstraints
//
//  Created by VARVAR on 08.02.2019.
//  Copyright © 2019 GoodGame. All rights reserved.
//

import Foundation

#if os(OSX)
    import AppKit

    public typealias View = NSView
    public typealias LayoutGuide = NSLayoutGuide
    public typealias ConstraintAxis = NSLayoutConstraint.Orientation
    public typealias LayoutPriority = NSLayoutConstraint.Priority
    public typealias EdgeInsets = NSEdgeInsets
    public extension NSEdgeInsets {
        static var zero = NSEdgeInsetsZero
    }
#else
    import UIKit

    public typealias View = UIView
    public typealias LayoutGuide = UILayoutGuide
    public typealias ConstraintAxis = NSLayoutConstraint.Axis
    public typealias LayoutPriority = UILayoutPriority
    public typealias EdgeInsets = UIEdgeInsets
#endif
