//
//  ClassName.swift
//  gg4ios
//
//  Created by VARVAR on 30.11.2018.
//  Copyright © 2018 GoodGame. All rights reserved.
//

import Foundation
public protocol ClassNameProtocol {
    static var className: String { get }
    var className: String { get }
}

public extension ClassNameProtocol {
    static var className: String {
        return String(describing: self)
    }
    
    var className: String {
        return type(of: self).className
    }
}

extension NSObject: ClassNameProtocol {}
