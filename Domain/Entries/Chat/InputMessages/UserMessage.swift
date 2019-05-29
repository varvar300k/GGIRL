//
//  Message.swift
//  Domain
//
//  Created by VARVAR on 21.02.2019.
//  Copyright © 2019 GoodGame. All rights reserved.
//

public struct UserMessage: ChatMessageType, Decodable {
    public var text: String
    public var isForMe: Bool
    public var isPrivate: Bool
    public var user: ChatUser
    
    enum CodingKeys: String, CodingKey {
        case text
        case rawText
        case isPrivate = "private"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        if let text = try? container.decode(String.self, forKey: .rawText) {
            self.text = text
        } else {
            self.text = (try? container.decode(String.self, forKey: .text)) ?? ""
        }
        self.isPrivate = (try? container.decode(Bool.self, forKey: .isPrivate)) ?? false
        self.user = try ChatUser(from: decoder)
        self.isForMe = false
    }
    
    public init(from decoder: Decoder, currentUser: ChatUser?) throws {
        self = try UserMessage(from: decoder)
        if let currentUser = currentUser, currentUser.name != "" {
            if(self.text.range(of: currentUser.name + ", ") != nil) {
                self.isForMe = true
            }
        }
    }
}

extension UserMessage: Equatable {
    public static func == (lhs: UserMessage, rhs: UserMessage) -> Bool {
        return lhs.text == rhs.text &&
            lhs.isForMe == rhs.isForMe &&
            lhs.isPrivate == rhs.isPrivate &&
            lhs.user == rhs.user
    }
}
