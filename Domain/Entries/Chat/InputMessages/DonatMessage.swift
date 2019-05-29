//
//  DonatMessage.swift
//  Domain
//
//  Created by VARVAR on 27.02.2019.
//  Copyright © 2019 GoodGame. All rights reserved.
//

/*
 [
 "channel_id": 13214,
 "link": , "gift": 0,
 "total": 0,
 "userName": lokki7,
 "title": ,
 "amount": 50.00,
 "message": fffffff,
 "voice":
 ]
*/

public struct DonatMessage: ChatMessageType, Decodable {
    public var text: String
    
    enum CodingKeys: String, CodingKey {
        case userName
        case amount
        case voice
        case message
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let userName = (try? container.decode(String.self, forKey: .userName)) ?? ""
        let amount = (try? container.decode(String.self, forKey: .amount)) ?? "0"
        let voice = (try? container.decode(String.self, forKey: .voice)) ?? ""
        let text = (try? container.decode(String.self, forKey: .message)) ?? ""
        var ret = userName + " поддержал на сумму " + amount
        if voice != "" {
            ret += " с голосовым сообщением"
        } else if text != "" {
            ret += " с сообщением: \"" + text + "\""
        }
        self.text = ret
    }
    
}
