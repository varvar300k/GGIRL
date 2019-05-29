//
//  AppDelegate.swift
//  GGIRL
//
//  Created by VARVAR on 11.02.2019.
//  Copyright © 2019 GoodGame. All rights reserved.
//

import UIKit
import AVFoundation
import HaishinKit
import Logboard

let logger = Logboard.with("ru.goodgame.GGIRL")

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    private lazy var rootController: UINavigationController = UINavigationController()
    
    private lazy var appCoordinator: AppCoordinator = {
        return AppCoordinator(router: RouterImpl(rootController: self.rootController), coordinatorFactory: CoordinatorFactoryImpl())
    }()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        setupAudioSession()
        
        window = UIWindow()
        window?.rootViewController = rootController
        appCoordinator.start()
        window?.makeKeyAndVisible()
        
        RxReachability.shared.startMonitor()
        
        return true
    }
    
    func setupAudioSession() {
        let session = AVAudioSession.sharedInstance()
        do {
            try session.setPreferredSampleRate(44_100)
            
            if #available(iOS 10.0, *) {
                try session.setCategory(.playAndRecord, mode: .default, options: [.defaultToSpeaker, .allowBluetooth])
            } else {
                session.perform(NSSelectorFromString("setCategory:withOptions:error:"), with: AVAudioSession.Category.playAndRecord, with: [AVAudioSession.CategoryOptions.allowBluetooth])
                try? session.setMode(.default)
            }
            try session.setActive(true)
        } catch {
            logger.error(error.localizedDescription)
        }
    }
    
    var orientationLock = UIInterfaceOrientationMask.all
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return self.orientationLock
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
    }

    func applicationWillTerminate(_ application: UIApplication) {
    }

}
