//
//  CounterWebSocket.swift
//  NetworkPlatform
//
//  Created by VARVAR on 28.02.2019.
//  Copyright © 2019 GoodGame. All rights reserved.
//

import Starscream
import RxSwift
import RxCocoa
import UIKit
import GoodConstraints
import Domain

public class CounterWebSocket: CounterWebSocketType {
    
    let disposeBag = DisposeBag()
    var socket: WebSocket
    private var channelId: String
    private var userId: Int
    private var state = BehaviorRelay<SocketState>(value: .disconnected)
    private var counterMessage = PublishSubject<Int>()
    lazy public var viewerCounter = self.counterMessage.asObservable()
    
    public init(channelId: String, userId: Int) {
        self.channelId = channelId
        self.userId = userId
        print("[Info] CounterWS: init(channelId: \(channelId), userId: \(userId))")
        socket = WebSocket(url: URL(string: "wss://chat.goodgame.ru/counter/")!)
        bindSocket()
    }
    
    public func open() {
        print("[Info] CounterWebSocket: open()")
        state.accept(.connecting)
        socket.connect()
    }
    
    public func close() {
        print("[Info] CounterWebSocket: close()")
        state.accept(.disconnected)
        socket.disconnect()
    }
    
    func bindSocket() {
        socket.rx.response
            .subscribe(onNext: { [weak self] (response: WebSocketEvent) in
                switch response {
                case .connected:
                    self?.state.accept(.connected)
                    if let `self` = self {
                        `self`.sendWSMessage(WsMessage.counter(channel: `self`.channelId, userId: `self`.userId))
                    }
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
    
    func onMessage(msg: String) {
        let json = Data(msg.utf8)
        guard let message = try? JSONDecoder().decode(CounterMessage.self, from: json) else { return }
        counterMessage.onNext(message.count)
    }
    
    private func sendWSMessage(_ message: WsMessage) {
        guard let messageJson = try? JSONEncoder().encode(message) else {
            return
        }
        let str = String(data: messageJson, encoding: .utf8)
        socket.write(string: str!)
    }
}
