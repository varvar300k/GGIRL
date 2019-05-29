//
//  SettingsVM.swift
//  GGIRL
//
//  Created by VARVAR on 19.02.2019.
//  Copyright © 2019 GoodGame. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class SettingsVM: SettingsViewModel, SettingsViewModelInputs, SettingsViewModelOutputs {
    
    var inputs: SettingsViewModelInputs { return self }
    var tapClose = PublishSubject<Void>()
    var tapLogOut = PublishSubject<Void>()
    
    var outputs: SettingsViewModelOutputs { return self }
    lazy var closeTapped: Observable<Void> = self.tapClose.asObservable()
    lazy var logOutTapped = {
        return self.tapLogOut.asObservable()
            .do(onNext: { () in
                UserController.shared.logout()
            })
    }()
    
    init() {}
}
