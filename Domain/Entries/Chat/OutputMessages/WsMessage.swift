//
//  WsMessage.swift
//  Domain
//
//  Created by VARVAR on 21.02.2019.
//  Copyright © 2019 GoodGame. All rights reserved.
//

public struct WsMessage: Encodable {
    public var type: String
    public var data: JSONValue
    
    enum CodingKeys: String, CodingKey {
        case type
        case data
    }
}

extension WsMessage {
    public static func join(channelId: String) -> WsMessage {
        let type = "join"
        let data: JSONValue = .object(["channel_id" : .string(channelId)])
        return WsMessage(type: type, data: data)
    }
}

extension WsMessage {
    public static func auth(userId: Int, token: String) -> WsMessage {
        let type = "auth"
        let data: JSONValue = .object([
            "user_id": .int(userId),
            "token": .string(token) ])
        return WsMessage(type: type, data: data)
    }
}

extension WsMessage {
    public static func counter(channel: String, userId: Int) -> WsMessage {
        let type = "viewing"
        let data: JSONValue = .object([
            "channel": .string(channel),
            "userId": .int(userId),
            "platform": .string("iOS") ])
        return WsMessage(type: type, data: data)
    }
}
