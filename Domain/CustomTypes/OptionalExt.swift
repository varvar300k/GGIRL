//
//  Extensions.swift
//  Domain
//
//  Created by VARVAR on 26.02.2019.
//  Copyright © 2019 GoodGame. All rights reserved.
//


extension Optional {
    func or(_ other: Optional) -> Optional {
        switch self {
        case .none: return other
        case .some: return self
        }
    }
}

extension Optional {
    func resolve(with error: @autoclosure () -> Error) throws -> Wrapped {
        switch self {
        case .none: throw error()
        case .some(let wrapped): return wrapped
        }
    }
}
