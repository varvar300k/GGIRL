//
//  Login .swift
//  Domain
//
//  Created by VARVAR on 11.04.2019.
//  Copyright © 2019 GoodGame. All rights reserved.
//

public struct Auth: Codable {
    public var id: Int?
    public var token: String?
    public var api_token: String?
    
    private enum CodingKeys: String, CodingKey {
        case id
        case token
        case api_token
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try? container.decode(Int.self, forKey: .id)
        self.token = try? container.decode(String.self, forKey: .token)
        self.api_token = try? container.decode(String.self, forKey: .api_token)
    }
    
}
