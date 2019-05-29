//
//  Funcs.swift
//  GGIRL
//
//  Created by VARVAR on 21.03.2019.
//  Copyright © 2019 GoodGame. All rights reserved.
//

func + <T>(lhs: [T], rhs: T) -> [T] {
    var copy = lhs
    copy.append(rhs)
    return copy
}
