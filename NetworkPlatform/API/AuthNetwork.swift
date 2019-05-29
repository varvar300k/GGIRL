//
//  LoginNetwork.swift
//  NetworkPlatform
//
//  Created by VARVAR on 11.04.2019.
//  Copyright © 2019 GoodGame. All rights reserved.
//

import Foundation
import Domain
import RxSwift

public final class AuthNetwork {
    private let network: Network<Auth>
    
    init(network: Network<Auth>) {
        self.network = network
    }
    
    public func login(_ data: [String:Any]) -> Observable<Auth> {
        return network.postItem("api/loginbywebview", data: data)
    }
}
