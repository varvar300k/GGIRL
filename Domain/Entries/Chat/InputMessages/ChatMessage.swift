//
//  Chat.swift
//  Domain
//
//  Created by VARVAR on 27.02.2019.
//  Copyright © 2019 GoodGame. All rights reserved.
//

public struct ChatMessage: Decodable {
    public var type: String
    public var message: ChatMessageType?
    
    enum CodingKeys: String, CodingKey {
        case type
        case data
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        type = try container.decode(String.self, forKey: .type)
        switch type {
        case "message":
            message = try container.decode(UserMessage.self, forKey: .data)
        case "payment":
            message = try container.decode(DonatMessage.self, forKey: .data)
        case "premium":
            message = try container.decode(PremiumMessage.self, forKey: .data)
        case "user_ban":
            message = try container.decode(BanMessage.self, forKey: .data)
        default:
            message = nil
        }
    }
}
