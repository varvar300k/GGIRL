//
//  AudioSettings.swift
//  GGIRL
//
//  Created by VARVAR on 05.04.2019.
//  Copyright © 2019 GoodGame. All rights reserved.
//

import Foundation

struct AudioSettings {
    enum Audiorate: String {
        case low = "Низкая"
        case medium = "Средняя"
        case high = "Высокая"
        case vhigh = "Очень высокая"
        var samplerate: Double {
            switch self {
            case .low:
                return 16_000
            case .medium:
                return 44_100
            case .high:
                return 44_100
            case .vhigh:
                return 48_000
            }
        }
        var bitrate: Int {
            switch self {
            case .low:
                return 65536
            case .medium:
                return 98304
            case .high:
                return 131072
            case .vhigh:
                return 131072
            }
        }
    }
    
    init() {
        if let _rate = UserDefaults.standard.value(forKey: "PreferenceAudiorateDefaultsKey")
            as? String {
            self.rate = Audiorate(rawValue: _rate)!
        }
    }
    
    var rate: Audiorate = .low {
        didSet {
            UserDefaults.standard.set(rate.rawValue, forKey: "PreferenceAudiorateDefaultsKey")
        }
    }
}
