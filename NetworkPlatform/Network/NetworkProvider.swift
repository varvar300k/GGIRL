//
//  NetworkProvider.swift
//  NetworkPlatform
//
//  Created by VARVAR on 11.04.2019.
//  Copyright © 2019 GoodGame. All rights reserved.
//

import Domain

final class NetworkProvider {
    private let apiEndpoint: String
    
    public init() {
        apiEndpoint = "https://goodgame.ru"
    }
    
    public func makeAuthNetwork() -> AuthNetwork {
        let network = Network<Auth>(apiEndpoint)
        return AuthNetwork(network: network)
    }
    
    public func makeUserNetwork() -> UserNetwork {
        let network = Network<User>(apiEndpoint)
        return UserNetwork(network: network)
    }
    
    public func makeChannelNetwork() -> ChannelNetwork {
        let network = Network<Channel>(apiEndpoint)
        return ChannelNetwork(network: network)
    }
}
