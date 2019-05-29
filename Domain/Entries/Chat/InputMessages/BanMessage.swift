//
//  BanMessage.swift
//  Domain
//
//  Created by VARVAR on 28.02.2019.
//  Copyright © 2019 GoodGame. All rights reserved.
//

public struct BanMessage: ChatMessageType, Decodable {
    public var text: String
    
    enum CodingKeys: String, CodingKey {
        case userName = "user_name"
        case moderName = "moder_name"
        case duration = "duration"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let userName = (try? container.decode(String.self, forKey: .userName)) ?? ""
        let moderName = (try? container.decode(String.self, forKey: .moderName)) ?? ""
        let duration = (try? container.decode(Int.self, forKey: .duration)) ?? 0
        if duration == 0 {
            self.text = moderName + " разбанил " + userName
        } else {
            self.text = moderName + " забанил " + userName
        }
    }
    
}
