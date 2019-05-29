//
//  UseCaseProvider.swift
//  NetworkPlatform
//
//  Created by VARVAR on 15.04.2019.
//  Copyright © 2019 GoodGame. All rights reserved.
//

import Foundation
import Domain

public final class UseCaseProvider: Domain.UseCaseProvider {
    
    private let networkProvider: NetworkProvider
    
    public init() {
        networkProvider = NetworkProvider()
    }
    
    public func makeAuthUseCase() -> Domain.AuthUseCase {
        return AuthUseCase(network: networkProvider.makeAuthNetwork())
    }
    
    public func makeUserUseCase() -> Domain.UserUseCase {
        return UserUseCase(network: networkProvider.makeUserNetwork())
    }
    
    public func makeChannelUseCase() -> Domain.ChannelUseCase {
        return ChannelUseCase(network: networkProvider.makeChannelNetwork())
    }
}
