//
//  ChatSettings.swift
//  GGIRL
//
//  Created by VARVAR on 03.05.2019.
//  Copyright © 2019 GoodGame. All rights reserved.
//

import Foundation

struct ChatSettings {
    enum Speech: String {
        case none = "Не озвучивать"
        case donat = "Только донаты"
        case all = "Все сообщения"
    }
    
    init() {
        if let _speech = UserDefaults.standard.value(forKey: "PreferenceChatSpeechDefaultsKey") as? String {
            self.speech = Speech(rawValue: _speech)!
        }
    }
    
    var speech: Speech = .none {
        didSet {
            UserDefaults.standard.set(speech.rawValue, forKey: "PreferenceChatSpeechDefaultsKey")
        }
    }
}
