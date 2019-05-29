//
//  HardwareSettings.swift
//  GGIRL
//
//  Created by VARVAR on 05.04.2019.
//  Copyright © 2019 GoodGame. All rights reserved.
//

import AVFoundation
import Foundation

struct HardwareSettings {
    init() {
//        if let _autofocus = UserDefaults.standard.value(forKey: "PreferenceVideoAutofocusDefaultsKey") as? Bool {
//            self.autofocus = _autofocus
//        }
//        if let _exposure = UserDefaults.standard.value(forKey: "PreferenceVideoExposureDefaultsKey") as? Bool {
//            self.exposure = _exposure
//        }
    }
    var autofocus: Bool = true {
        didSet {
            UserDefaults.standard.set(autofocus, forKey: "PreferenceHardwareAutofocusDefaultsKey")
        }
    }
    var exposure: Bool = false {
        didSet {
            UserDefaults.standard.set(exposure, forKey: "PreferenceHardwareExposureDefaultsKey")
        }
    }
    var torch: Bool = true
    var microphone: Bool = true
    var camera: AVCaptureDevice.Position = .back
}
