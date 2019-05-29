//
//  CounterWebSocketType.swift
//  NetworkPlatform
//
//  Created by VARVAR on 28.02.2019.
//  Copyright © 2019 GoodGame. All rights reserved.
//

import RxSwift
import Domain

public protocol CounterWebSocketType {
    var viewerCounter: Observable<Int> { get }
    func open()
    func close()
}
