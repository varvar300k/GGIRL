//
//  ChannelUseCase.swift
//  NetworkPlatform
//
//  Created by VARVAR on 17.04.2019.
//  Copyright © 2019 GoodGame. All rights reserved.
//

import Foundation
import Domain
import RxSwift

final class ChannelUseCase: Domain.ChannelUseCase {
    private let network: ChannelNetwork
    
    init(network: ChannelNetwork) {
        self.network = network
    }
    
    func load(params: Parameters) -> Observable<Channel> {
        return network.load(params)
    }
    
    func setup(data: [String:Any]) -> Observable<Channel> {
        return network.setup(data)
    }
}
