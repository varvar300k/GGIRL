////
////  Style.swift
////  gg4
////
////  Created by VARVAR on 19.12.2018.
////  Copyright © 2018 GoodGame. All rights reserved.
////
//
//import Foundation
//struct Style {
//    static var fontNormal: Decoration<UILabel> {
//        return { (view: UILabel) -> Void in
//            view.font = UIFont.systemFont(ofSize: 14.0)
//        }
//    }
//    static var fontTitle: Decoration<UILabel> {
//        return { (view: UILabel) -> Void in
//            if #available(iOS 8.2, *) {
//                view.font = UIFont.systemFont(ofSize: 17.0, weight: UIFontWeightBold)
//            } else {
//                view.font = UIFont.boldSystemFont(ofSize: 17.0)
//            }
//        }
//    }
//    static func corners(rounded: Bool) -> Decoration<UIView> {
//        return { [rounded] (view: UIView) -> Void in
//            switch rounded {
//            case true:
//                let mask = CAShapeLayer()
//                let size = CGSize(width: 10, height: 10)
//                let rect = view.bounds
//                let path = UIBezierPath(roundedRect: rect, byRoundingCorners: .allCorners, cornerRadii: size)
//                mask.path = path.cgPath
//                view.layer.mask = mask
//            default:
//                view.layer.mask = nil
//            }
//        }
//    }
//}
