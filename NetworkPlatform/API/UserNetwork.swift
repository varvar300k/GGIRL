//
//  UserNetwork.swift
//  NetworkPlatform
//
//  Created by VARVAR on 11.04.2019.
//  Copyright © 2019 GoodGame. All rights reserved.
//

import Foundation
import Domain
import RxSwift

public final class UserNetwork {
    private let network: Network<User>
    
    init(network: Network<User>) {
        self.network = network
    }
    public func load(_ parameters: Parameters) -> Observable<User> {
        return network.getItem("api/4/user", parameters: parameters)
    }
}
