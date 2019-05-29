//
//  LoginUseCase.swift
//  NetworkPlatform
//
//  Created by VARVAR on 15.04.2019.
//  Copyright © 2019 GoodGame. All rights reserved.
//

import Foundation
import Domain
import RxSwift

final class AuthUseCase: Domain.AuthUseCase {
    private let network: AuthNetwork
    
    init(network: AuthNetwork) {
        self.network = network
    }
    
    func login(data: [String:Any]) -> Observable<Auth> {
        return network.login(data)
    }
}
