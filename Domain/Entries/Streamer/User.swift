//
//  User.swift
//  Domain
//
//  Created by VARVAR on 19.02.2019.
//  Copyright © 2019 GoodGame. All rights reserved.
//

public struct User: Decodable {
    public var id: Int
    public var avatar: String
    public var username: String
    public var chatToken: String
    public var channel: Channel?
    
    private enum CodingKeys: String, CodingKey {
        case id
        case avatar
        case username
        case chatToken = "token"
        case channel
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.avatar = try container.decode(String.self, forKey: .avatar)
        self.username = try container.decode(String.self, forKey: .username)
        self.chatToken = try container.decode(String.self, forKey: .chatToken)
        self.channel = try? container.decode(Channel.self, forKey: .channel)
    }
    
    public init() {
        self.id = 0
        self.channel = nil
        self.avatar = ""
        self.username = ""
        self.chatToken = ""
    }
    
    public mutating func clearUser() {
        self.id = 0
        self.channel = nil
        self.avatar = ""
        self.username = ""
        self.chatToken = ""
    }
}

extension User: Equatable {
    public static func == (lhs: User, rhs: User) -> Bool {
        return lhs.id == rhs.id
            && lhs.avatar == rhs.avatar
            && lhs.username == rhs.username
            && lhs.chatToken == rhs.chatToken
    }
}
