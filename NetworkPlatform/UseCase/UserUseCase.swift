//
//  UserUseCase.swift
//  NetworkPlatform
//
//  Created by VARVAR on 15.04.2019.
//  Copyright © 2019 GoodGame. All rights reserved.
//

import Foundation
import Domain
import RxSwift

final class UserUseCase: Domain.UserUseCase {
    private let network: UserNetwork
    
    init(network: UserNetwork) {
        self.network = network
    }
    
    func load(params: Parameters) -> Observable<User> {
        return network.load(params)
    }
}
