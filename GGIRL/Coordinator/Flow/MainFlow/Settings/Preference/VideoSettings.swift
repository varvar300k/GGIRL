//
//  VideoSettings.swift
//
//
//  Created by VARVAR on 05.04.2019.
//

import AVFoundation
import Foundation
import UIKit

struct VideoSettings {
    
    enum Resolution: String {
        case nHD = "480p"
        case HD = "720p"
        case FHD = "1080p"
        
        var size: (big: Int, small: Int) {
            get {
                switch self {
                case .nHD, .HD:
                    return (1280, 720)
                default:
                    return (1920, 1080)
                }
            }
        }
        
        var preset: AVCaptureSession.Preset.RawValue {
            switch self {
            case .nHD:
                return AVCaptureSession.Preset.vga640x480.rawValue
            case .HD:
                return AVCaptureSession.Preset.hd1280x720.rawValue
            case .FHD:
                return AVCaptureSession.Preset.hd1920x1080.rawValue
            }
        }
    }
        
    init() {
        if let _fps = UserDefaults.standard.value(forKey: "PreferenceVideoFpsDefaultsKey") as? Int {
            self.fps = _fps
        }
        if let _resRawValue = UserDefaults.standard.value(forKey: "PreferenceVideoResolutionDefaultsKey") as? String {
            if let _resolution = Resolution(rawValue: _resRawValue) {
                self.resolution = _resolution
            }
        }
        if let _stabilization = UserDefaults.standard.value(forKey: "PreferenceVideoStabilizationDefaultsKey") as? Int {
            self.stabilization = _stabilization
        }
        if let _bitrate = UserDefaults.standard.value(forKey: "PreferenceVideoBitrateDefaultsKey") as? Int {
            self.bitrate = _bitrate
        }
    }
    
    var fps: Int = 30 {
        didSet {
            UserDefaults.standard.set(fps, forKey: "PreferenceVideoFpsDefaultsKey")
        }
    }
    
    var resolution: Resolution = .nHD {
        didSet {
            UserDefaults.standard.set(resolution.rawValue, forKey: "PreferenceVideoResolutionDefaultsKey")
        }
    }
    
    var stabilization: AVCaptureVideoStabilizationMode.RawValue = AVCaptureVideoStabilizationMode.off.rawValue {
        didSet {
            UserDefaults.standard.set(stabilization, forKey: "PreferenceVideoStabilizationDefaultsKey")
        }
    }
    
    var bitrate: Int = 1024000 {
        didSet {
            UserDefaults.standard.set(bitrate, forKey: "PreferenceVideoBitrateDefaultsKey")
        }
    }
    
    var isOrientationLocked: Bool = false
}

extension AVCaptureVideoStabilizationMode {
    var description: String {
        switch self {
        case .off:
            return "Отключена"
        case .standard:
            return "Стандартная"
        case .cinematic:
            return "Кинематографическая"
        case .auto:
            return "Авто выбор"
        }
    }
}
