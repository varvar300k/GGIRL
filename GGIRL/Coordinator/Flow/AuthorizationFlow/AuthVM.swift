//
//  AuthVM.swift
//  GGIRL
//
//  Created by VARVAR on 18.02.2019.
//  Copyright © 2019 GoodGame. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class AuthVM: AuthViewModel, AuthViewModelInputs, AuthViewModelOutputs {
    
    var inputs: AuthViewModelInputs { return self }
    var tapCustomLogin = PublishRelay<String>()
    
    var outputs: AuthViewModelOutputs { return self }
    lazy var customLoginTapped = {
        return self.tapCustomLogin.asObservable()
            .do(onNext: { [weak self] key in
                self?.saveSreamKey(key)
            })
            .mapToVoid()
    }()
    
    init() {}
    
    func saveSreamKey(_ key: String) {
        let keychain = Keychain(service: "ru.goodgame.GGIRL")
        keychain["streamkey"] = key
    }
    
}
