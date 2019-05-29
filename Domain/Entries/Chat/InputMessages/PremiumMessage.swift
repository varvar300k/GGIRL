//
//  PremiumMessage.swift
//  Domain
//
//  Created by VARVAR on 28.02.2019.
//  Copyright © 2019 GoodGame. All rights reserved.
//

public struct PremiumMessage: ChatMessageType, Decodable {
    public var text: String
    
    enum CodingKeys: String, CodingKey {
        case userName
        case payment
        case resub
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let userName = (try? container.decode(String.self, forKey: .userName)) ?? ""
        let resub = Int(try container.decode(String.self, forKey: .resub))!
        var type: Int?
        if let payment = try? container.decode(String.self, forKey: .payment) {
            type = Int(payment)!
        }
        if let payment = try? container.decode(Int.self, forKey: .payment) {
            type = payment
        }
        switch type {
        case 1:
            if resub <= 1 {
                self.text = userName + " подписался на премиум"
            } else {
                self.text = userName + " переподписан " + String(resub) + " месяца"
            }
        case 2:
            if resub <= 1 {
                self.text = userName + " активировал премиум"
            } else {
                self.text = userName + " активирует премиум " + String(resub) + " месяца"
            }
        default:
            self.text = userName
        }
    }
    
}
