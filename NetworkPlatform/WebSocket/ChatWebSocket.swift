//
//  ChatWebSocket.swift
//  NetworkPlatform
//
//  Created by VARVAR on 21.02.2019.
//  Copyright © 2019 GoodGame. All rights reserved.
//

import Starscream
import RxSwift
import RxCocoa
import UIKit
import Domain

public class ChatWebSocket: ChatWebSocketType {
    
    let disposeBag = DisposeBag()
    var socket: WebSocket
    var channelId: String
    
    private var state = BehaviorRelay<SocketState>(value: .disconnected)
    lazy public var socketState = self.state.asObservable()
    private var newMessage = PublishSubject<ChatMessageType>()
    lazy public var receivedMessage = self.newMessage.asObservable()
    
    public init(channelId: String) {
        self.channelId = channelId
        print("[Info] ChatWebSocket: init(channelId: \(channelId))")
        socket = WebSocket(url: URL(string: "wss://chat.goodgame.ru/chat2/")!)
        bindSocket()
    }
    
    public func open() {
        print("[Info] ChatWebSocket: open()")
        state.accept(.connecting)
        socket.connect()
    }
    
    public func close() {
        print("[Info] ChatWebSocket: close()")
        state.accept(.disconnected)
        socket.disconnect()
    }
    
    func bindSocket() {
        socket.rx.response
            .subscribe(onNext: { [weak self] (response: WebSocketEvent) in
                switch response {
                case .connected:
                    self?.state.accept(.connected)
                case .disconnected(_):
                    if self?.state.value != .disconnected {
                        self?.open()
                    }
                case .message(let msg):
                    self?.onMessage(msg: msg)
                default:
                    break
            }
        }).disposed(by: disposeBag)
    }

    private func onMessage(msg: String) {
        let json = Data(msg.utf8)
        guard let messageData = try? JSONDecoder().decode(ChatMessage.self, from: json) else {
            return
        }
        
        switch messageData.type {
        case "welcome":
            self.sendWSMessage(WsMessage.join(channelId: self.channelId))
        case "message", "payment", "premium", "user_ban":
            self.newMessage.onNext(messageData.message!)
        default:
            break
        }
    }
    
    private func sendWSMessage(_ message: WsMessage) {
        guard let messageJson = try? JSONEncoder().encode(message) else {
            return
        }
        let str = String(data: messageJson, encoding: .utf8)
        socket.write(string: str!)
    }
}
