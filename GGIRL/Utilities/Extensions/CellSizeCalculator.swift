//
//  CellSizeCalculator.swift
//  gg4ios
//
//  Created by VARVAR on 30.11.2018.
//  Copyright © 2018 GoodGame. All rights reserved.
//

import Foundation
import UIKit

enum CellStyleType {
    case list
    case tile
}

enum CollectionCellType {
    case streamOnline(CellStyleType)
    case streamAnons
    case streamOffline
    case game(CellStyleType)
}

protocol CollectionViewAdditionTools {
    func cellSizeCalculator(for type: CollectionCellType) -> CGSize
}

extension CollectionViewAdditionTools {
    func cellSizeCalculator(for type: CollectionCellType) -> CGSize {
        let h, w: Float
        let screenWidth = UIScreen.main.bounds.width
        
        switch type {
        case .game(.tile):
            switch screenWidth {
            case 0..<768:
                w = Float((screenWidth - 24) / 2).rounded(.down)
            case 768..<1024:
                w = Float((screenWidth - 50) / 4).rounded(.down)
            case 1024..<1366:
                w = Float((screenWidth - 60) / 5).rounded(.down)
            default:
                w = Float((screenWidth - 70) / 6).rounded(.down)
            }
            h = w * 1.33
        case .streamOnline(.tile):
            switch screenWidth {
            case 0..<768:
                w = Float(screenWidth - 16).rounded(.down)
            case 768..<1024:
                w = Float((screenWidth - 30)/2).rounded(.down)
            case 1024..<1366:
                w = Float((screenWidth - 40)/3).rounded(.down)
            default:
                w = Float((screenWidth - 50)/4).rounded(.down)
            }
            h = w * (9 / 16)
        default:
            h = 0
            w = 0
        }
        print("~~~ \(screenWidth)")
        print("~~~ \(CGSize(width: CGFloat(w), height: CGFloat(h)))")
        return CGSize(width: CGFloat(w), height: CGFloat(h))
    }
}
