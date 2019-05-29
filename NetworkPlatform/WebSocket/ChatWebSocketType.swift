//
//  ChatWebSocketTYPE.swift
//  NetworkPlatform
//
//  Created by VARVAR on 22.02.2019.
//  Copyright © 2019 GoodGame. All rights reserved.
//

import RxSwift
import Domain

public protocol ChatWebSocketType {
    var receivedMessage: Observable<ChatMessageType> { get }
    var socketState: Observable<SocketState> { get }
    func open()
    func close()
}
