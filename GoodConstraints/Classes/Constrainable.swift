//
//  Constrainable.swift
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

extension View: Constrainable {
    @discardableResult
    public func prepareForLayout() -> Self {
        translatesAutoresizingMaskIntoConstraints = false
        return self
    }
}

extension LayoutGuide: Constrainable {
    @discardableResult
    public func prepareForLayout() -> Self { return self }
}

public protocol Constrainable {
    var topAnchor: NSLayoutYAxisAnchor { get }
    var bottomAnchor: NSLayoutYAxisAnchor { get }
    var leftAnchor: NSLayoutXAxisAnchor { get }
    var rightAnchor: NSLayoutXAxisAnchor { get }
    var leadingAnchor: NSLayoutXAxisAnchor { get }
    var trailingAnchor: NSLayoutXAxisAnchor { get }
    
    var centerXAnchor: NSLayoutXAxisAnchor { get }
    var centerYAnchor: NSLayoutYAxisAnchor { get }
    
    var widthAnchor: NSLayoutDimension { get }
    var heightAnchor: NSLayoutDimension { get }
    
    @discardableResult
    func prepareForLayout() -> Self
}
