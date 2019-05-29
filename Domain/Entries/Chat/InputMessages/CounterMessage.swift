//
//  CounterMessage.swift
//  Domain
//
//  Created by VARVAR on 28.02.2019.
//  Copyright © 2019 GoodGame. All rights reserved.
//

public struct CounterMessage: Decodable {
    public var count: Int
    
    enum CodingKeys: String, CodingKey {
        case data
        case count
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let nestedContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .data)
        self.count = (try? nestedContainer.decode(Int.self, forKey: .count)) ?? 0
    }
}
