//
//  StreamVM.swift
//  GGIRL
//
//  Created by VARVAR on 19.02.2019.
//  Copyright © 2019 GoodGame. All rights reserved.
//

import RxSwift
import RxCocoa
import HaishinKit
import Domain
import NetworkPlatform

class StreamVM: StreamViewModel, StreamViewModelInputs, StreamViewModelOutputs {
    
    let disposeBag = DisposeBag()
    
    var inputs: StreamViewModelInputs { return self }
    var tapSettings = PublishSubject<Void>()
    
    var outputs: StreamViewModelOutputs { return self }
    lazy var settingsTapped = self.tapSettings.asObservable()
    
    init() {}
}
