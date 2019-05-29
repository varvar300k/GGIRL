//
//  AppUtility.swift
//  GGIRL
//
//  Created by Alexey on 22/05/2019.
//  Copyright © 2019 GoodGame. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

struct AppUtility {
    
    struct Orientation {
        
        static var current: UIDeviceOrientation = .portrait
        
        static var isLandscape: Bool {
            get {
                return UIDevice.current.orientation.isValidInterfaceOrientation
                    ? UIDevice.current.orientation.isLandscape
                    : UIApplication.shared.statusBarOrientation.isLandscape
            }
        }
        
        static var isPortrait: Bool {
            get {
                return UIDevice.current.orientation.isValidInterfaceOrientation
                    ? UIDevice.current.orientation.isPortrait
                    : UIApplication.shared.statusBarOrientation.isLandscape
            }
        }
        
        static func lockOrientation(_ orientation: UIInterfaceOrientationMask) {
            if let delegate = UIApplication.shared.delegate as? AppDelegate {
                delegate.orientationLock = orientation
            }
        }
        
        static func lockOrientation(_ orientation: UIInterfaceOrientationMask, andRotateTo rotateOrientation:UIInterfaceOrientation) {
            self.lockOrientation(orientation)
            UIDevice.current.setValue(rotateOrientation.rawValue, forKey: "orientation")
            UINavigationController.attemptRotationToDeviceOrientation()
        }
    }
}

extension UIDeviceOrientation {
    var interfaceOrientation: UIInterfaceOrientation {
        get {
            switch self {
            case .portrait:
                return .portrait
            case .portraitUpsideDown:
                return .portraitUpsideDown
            case .landscapeRight:
                return .landscapeLeft
            case .landscapeLeft:
                return .landscapeRight
            default:
                return .unknown
            }
        }
    }
}

extension UIInterfaceOrientation {
    var orientationMask: UIInterfaceOrientationMask {
        get {
            switch self {
            case .portrait:
                return .portrait
            case .portraitUpsideDown:
                return .portraitUpsideDown
            case .landscapeLeft:
                return .landscapeLeft
            case .landscapeRight:
                return .landscapeRight
            default:
                return .all
            }
        }
    }
}

extension AVCaptureVideoOrientation {
    init(intefraceOrientation: UIInterfaceOrientation) {
        switch intefraceOrientation {
        case .portrait:
            self = .portrait
        case .portraitUpsideDown:
            self = .portraitUpsideDown
        case .landscapeRight:
            self = .landscapeRight
        case .landscapeLeft:
            self = .landscapeLeft
        default:
            self = .portrait
        }
    }
    var intefraceOrientation: UIInterfaceOrientation {
        get {
            switch self {
            case .portrait:
                return .portrait
            case .portraitUpsideDown:
                return .portraitUpsideDown
            case .landscapeRight:
                return .landscapeRight
            case .landscapeLeft:
                return .landscapeLeft
            @unknown default:
                fatalError()
            }
        }
    }
}
