//
//  StreamViewModel.swift
//  GGIRL
//
//  Created by VARVAR on 19.02.2019.
//  Copyright © 2019 GoodGame. All rights reserved.
//

import RxSwift
import RxCocoa
import HaishinKit

public protocol StreamViewModelInputs {
    var tapSettings: PublishSubject<Void> { get }
}

public protocol StreamViewModelOutputs {
    var settingsTapped: Observable<Void> { get }
}

public protocol StreamViewModel {
    var inputs: StreamViewModelInputs { get }
    var outputs: StreamViewModelOutputs { get }
}
