////
////  Decorator.swift
////  gg4
////
////  Created by VARVAR on 19.12.2018.
////  Copyright © 2018 GoodGame. All rights reserved.
////
//
//import Foundation
//typealias Decoration<T> = (T) -> Void
//struct Decorator<T> {
//    let object: T
//    func apply(_ decorations: Decoration<T>...) -> Void {
//        decorations.forEach({ $0(object) })
//    }
//}
//protocol DecoratorCompatible {
//    associatedtype DecoratorCompatibleType
//    var decorator: Decorator<DecoratorCompatibleType> { get }
//}
//extension DecoratorCompatible {
//    var decorator: Decorator<Self> {
//        return Decorator(object: self)
//    }
//}
//
////ex. extension UILabel: DecoratorCompatible {}
///*
// let labelNormal = UILabel()
// labelNormal.decorator.apply(Style.fontNormal, Style.corners(rounded: false))
// let labelTitle = UILabel()
// labelNormal.decorator.apply(Style.fontTitle, Style.corners(rounded: true))
//*/
