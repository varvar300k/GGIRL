//
//  ChannelNetwork.swift
//  NetworkPlatform
//
//  Created by VARVAR on 17.04.2019.
//  Copyright © 2019 GoodGame. All rights reserved.
//

import Foundation
import Domain
import RxSwift

public final class ChannelNetwork {
    private let network: Network<Channel>
    init(network: Network<Channel>) {
        self.network = network
    }
    public func load(_ parameters: Parameters) -> Observable<Channel> {
        return network.getItem("ajax/channel/settings", parameters: parameters)
    }
    public func setup(_ data: [String:Any]) -> Observable<Channel> {
        return network.postItem("ajax/channel/settings", data: data)
    }
}
