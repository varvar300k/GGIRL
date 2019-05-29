//
//  SchatViewModel.swift
//  GGIRL
//
//  Created by VARVAR on 20.02.2019.
//  Copyright © 2019 GoodGame. All rights reserved.
//

import RxSwift
import RxCocoa
import Domain
import NetworkPlatform

public protocol ChatViewModelInputs {
    var toggleChatSocket: PublishSubject<Bool> { get }
}

public protocol ChatViewModelOutputs {
    var chatSocketState: PublishRelay<SocketState> { get }
    var receivedMessage: Observable<ChatCellViewModel> { get }
    var viewerCounter: Observable<Int> { get }
}

public protocol ChatViewModel {
    var inputs: ChatViewModelInputs { get }
    var outputs: ChatViewModelOutputs { get }
}
