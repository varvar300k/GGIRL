//
//  Constraints.swift
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

public typealias Constraint = NSLayoutConstraint
public typealias Constraints = [Constraint]

public enum ConstraintRelation: Int {
    case equal = 0
    case equalOrLess = -1
    case equalOrGreater = 1
}

public extension Collection where Iterator.Element == Constraint {
    
    func activate() {
        
        if let constraints = self as? Constraints {
            Constraint.activate(constraints)
        }
    }
    
    func deActivate() {
        
        if let constraints = self as? Constraints {
            Constraint.deactivate(constraints)
        }
    }
}

#if os(OSX)
public extension Constraint {
    @objc
    func with(_ p: Constraint.Priority) -> Self {
        priority = p
        return self
    }
    
    func set(active: Bool) -> Self {
        isActive = active
        return self
    }
}
#else
public extension Constraint {
    @objc
    func with(_ p: LayoutPriority) -> Self {
        priority = p
        return self
    }
    
    func set(active: Bool) -> Self {
        isActive = active
        return self
    }
}
#endif
