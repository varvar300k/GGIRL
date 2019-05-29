//
//  AuthViewModel.swift
//  GGIRL
//
//  Created by VARVAR on 18.02.2019.
//  Copyright © 2019 GoodGame. All rights reserved.
//

import RxSwift
import RxCocoa

public protocol AuthViewModelInputs {
    var tapCustomLogin: PublishRelay<String> { get }
}

public protocol AuthViewModelOutputs {
    var customLoginTapped: Observable<Void> { get }
}

public protocol AuthViewModel {
    var inputs: AuthViewModelInputs { get }
    var outputs: AuthViewModelOutputs { get }
}
