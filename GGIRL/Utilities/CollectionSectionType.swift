//
//  RxSwiftCollectionView.swift
//  gg4
//
//  Created by VARVAR on 06.12.2018.
//  Copyright © 2018 GoodGame. All rights reserved.
//

import RxSwift
import UIKit
import RxDataSources

protocol CollectionSectionType {
    var headerSize: CGSize { get }
    var itemSize: CGSize { get }
    var itemWidth: CGFloat { get }
    var itemHeight: CGFloat { get }
    var inset: UIEdgeInsets { get }
    var minimumLineSpacing: CGFloat { get }
    var minimumInteritemSpacing: CGFloat { get }
    var numberOfItems: Int { get }
}
