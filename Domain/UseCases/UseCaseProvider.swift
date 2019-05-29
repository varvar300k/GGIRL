//
//  UseCaseProvider.swift
//  Domain
//
//  Created by VARVAR on 15.04.2019.
//  Copyright © 2019 GoodGame. All rights reserved.
//

public protocol UseCaseProvider {
    func makeAuthUseCase() -> AuthUseCase
    func makeUserUseCase() -> UserUseCase
    func makeChannelUseCase() -> ChannelUseCase
}
