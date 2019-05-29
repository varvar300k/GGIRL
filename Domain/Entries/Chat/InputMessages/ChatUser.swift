//
//  ChatUser.swift
//  Domain
//
//  Created by VARVAR on 25.02.2019.
//  Copyright © 2019 GoodGame. All rights reserved.
//

public struct ChatUser: Decodable {
    public var name: String
    public var icon: String?
    public var hideIcon: Int?
    public var color: String?
    public var mobile: Int?
    public var rights: Int?
    public var payments: Int?
    public var premium: Int?
    public var staff: Int?
    public var currentRoom: Int?
    
    var premiums: [Int]?
    var allPayments: [Int:Int]?
    
    enum CodingKeys: String, CodingKey {
        case name = "user_name"
        case icon
        case hideIcon
        case color
        case mobile
        case rights = "user_rights"
        case payments
        case premium
        case premiums
        case staff
        case currentRoom
        case paymentsAll
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.icon = try? container.decode(String.self, forKey: .icon)
        self.hideIcon = try? container.decode(Int.self, forKey: .hideIcon)
        self.color = try? container.decode(String.self, forKey: .color)
        self.mobile = try? container.decode(Int.self, forKey: .mobile)
        self.rights = try? container.decode(Int.self, forKey: .rights)
        self.premium = try? container.decode(Int.self, forKey: .premium)
        self.staff = try? container.decode(Int.self, forKey: .staff)
        self.payments = try? container.decode(Int.self, forKey: .payments)
        
        if let _allPayments = try? container.decode([String:Int].self, forKey: .paymentsAll) {
            var convertedDict = [Int: Int]()
            _allPayments.forEach { (key, value) in
                convertedDict[Int(key)!] = value
            }
            self.allPayments = convertedDict
        }
        
        if let prems = try? container.decode([String].self, forKey: .premium) {
            self.premiums = prems.map { Int($0)! }
        }
    }
    
    public init(userName: String) {
        self.name = userName
    }
    
}

extension ChatUser: Equatable {
    public static func == (lhs: ChatUser, rhs: ChatUser) -> Bool {
        return lhs.name == rhs.name &&
            lhs.premium == rhs.premium &&
            lhs.rights == rhs.rights &&
            lhs.payments == rhs.payments &&
            lhs.allPayments == rhs.allPayments
    }
}
