//
//  Preference.swift
//  GGIRL
//
//  Created by VARVAR on 13.02.2019.
//  Copyright © 2019 GoodGame. All rights reserved.
//

import Foundation
import UIKit
struct Preference {
    static var shared = Preference()
    var video = VideoSettings()
    var audio = AudioSettings()
    var stream = StreamSettings()
    var hardware = HardwareSettings()
    var chat = ChatSettings()
}
