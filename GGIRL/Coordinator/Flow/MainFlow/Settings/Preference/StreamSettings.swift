//
//  StreamSettings.swift
//  GGIRL
//
//  Created by VARVAR on 05.04.2019.
//  Copyright © 2019 GoodGame. All rights reserved.
//

struct StreamerSettings {
    
    enum StreamState: Int {
        case offline = 0
        case online = 1
        case connecting = 2
    }
    
    var streamKey: String? {
        get {
            let keychain = Keychain(service: "ru.goodgame.GGIRL")
            return keychain["streamkey"]
        }
        set(key) {
            let keychain = Keychain(service: "ru.goodgame.GGIRL")
            keychain["streamkey"] = key
        }
    }
    
    var streamId: Int {
        return UserController.shared.user.channelId
    }
    
    var targetURL: String {
        return "rtmp://msk.goodgame.ru:1940/live"
    }
    
    var status: StreamState = .offline
    
}
