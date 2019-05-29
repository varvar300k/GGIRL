//
//  Channel.swift
//  Domain
//
//  Created by VARVAR on 17.04.2019.
//  Copyright © 2019 GoodGame. All rights reserved.
//

public struct Channel: Codable {
    public var id: String?
    public var key: String?
    public var title: String?
    public var game: String?
    public var streamKey: String?
    
    private enum CodingKeys: String, CodingKey {
        case id
        case key
        case title
        case game
        case streamKey = "stream_key"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try? container.decode(String.self, forKey: .id)
        self.key = try? container.decode(String.self, forKey: .key)
        self.title = try? container.decode(String.self, forKey: .title)
        self.game = try? container.decode(String.self, forKey: .game)
        self.streamKey = try? container.decode(String.self, forKey: .streamKey)
    }

    public func settingsRequestData() -> [String:Any] {
        return ["channel": Int(id!)!,"data": ["key":key,"title": title ?? "IRL","game": "IRL","stream_key":streamKey]]
    }
}
