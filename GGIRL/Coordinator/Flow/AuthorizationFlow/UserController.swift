//
//  UserController.swift
//  GGIRL
//
//  Created by VARVAR on 18.02.2019.
//  Copyright © 2019 GoodGame. All rights reserved.
//

import Foundation
import UIKit
import WebKit
import Domain
import NetworkPlatform
import RxSwift
import RxCocoa

public extension Notification.Name {
    static let loginStatusChanged = Notification.Name("ru.goodgame.GGIRL.auth.changed")
}

class UserController {
    let disposeBag = DisposeBag()
    static var shared = UserController()
    
    public var isUserAuthorized = BehaviorRelay<Bool>(value: false)
    public func userWasAuthorized() -> Bool {
        return token != nil
    }
    
    private init() {
        if token != nil {
            loadUser()
        }
    }
    
    public var user: User = User()
    private var deviceId = UIDevice.current.identifierForVendor!.uuidString
    
    private let authUseCase = UseCaseProvider().makeAuthUseCase()
    private let userUseCase = UseCaseProvider().makeUserUseCase()
    private let channelUseCase = UseCaseProvider().makeChannelUseCase()
    
    lazy var errors: SharedSequence<DriverSharingStrategy, Error> = self.errorTracker.asDriver()
    fileprivate let errorTracker = ErrorTracker()
    
    func login(userId: Int, token: String) {
        clearCookies()
        let data = [
            "user_id": String(userId),
            "token": token,
            "device_id": deviceId
        ]
        
        authUseCase.login(data: data)
            .asObservable()
            .subscribe(onNext: { response in
                self.token = response.api_token
                self.loadUser()
            }).disposed(by: disposeBag)
    }
    
    func logout() {
        token = nil
        Preference.shared.stream.streamKey = nil
        user.clearUser()
        clearCookies()
        self.isUserAuthorized.accept(false)
    }
    
    private func loadUser() {
        userUseCase.load(params: ["device_id" : deviceId, "api_token": token!])
            .asObservable()
            .subscribe(onNext: { user in
                self.user = user
                self.loadStreamKey()
            }).disposed(by: disposeBag)
    }
    
    private func loadStreamKey() {
        channelUseCase.load(params: ["channel" : String(user.channel!.id!)])
            .asObservable()
            .subscribe(onNext: {channel in
                Preference.shared.stream.streamKey = channel.streamKey
                self.user.channel?.key = channel.key
                self.user.channel?.title = channel.title
                self.user.channel?.game = channel.game
                self.user.channel?.streamKey = channel.streamKey
                self.isUserAuthorized.accept(true)
            }).disposed(by: disposeBag)
    }
    
    private func clearCookies() {
        let dataStore = WKWebsiteDataStore.default()
        dataStore.fetchDataRecords(ofTypes: WKWebsiteDataStore.allWebsiteDataTypes()) { (records) in
            for record in records {
                if record.displayName.contains("goodgame") {
                    dataStore.removeData(ofTypes: WKWebsiteDataStore.allWebsiteDataTypes(), for: [record], completionHandler: {
                        print("Deleted: " + record.displayName);
                    })
                }
            }
        }
    }
    
    private var token: String? {
        get {
            let keychain = Keychain(service: "ru.goodgame.GGIRL")
            return keychain["token"]
        }
        set(newToken) {
            let keychain = Keychain(service: "ru.goodgame.GGIRL")
            keychain["token"] = newToken
        }
    }
    
}
