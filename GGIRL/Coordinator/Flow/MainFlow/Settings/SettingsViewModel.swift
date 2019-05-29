//
//  SettingsViewModel.swift
//  GGIRL
//
//  Created by VARVAR on 19.02.2019.
//  Copyright © 2019 GoodGame. All rights reserved.
//

import RxSwift
import RxCocoa
import HaishinKit

public protocol SettingsViewModelInputs {
    var tapClose: PublishSubject<Void> { get }
    var tapLogOut: PublishSubject<Void> { get }
}

public protocol SettingsViewModelOutputs {
    var closeTapped: Observable<Void> { get }
    var logOutTapped: Observable<Void> { get }
}

public protocol SettingsViewModel {
    var inputs: SettingsViewModelInputs { get }
    var outputs: SettingsViewModelOutputs { get }
}
