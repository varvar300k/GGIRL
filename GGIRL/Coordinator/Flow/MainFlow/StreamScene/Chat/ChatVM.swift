//
//  ChatVM.swift
//  GGIRL
//
//  Created by VARVAR on 28.02.2019.
//  Copyright © 2019 GoodGame. All rights reserved.
//

import RxSwift
import RxCocoa
import Domain
import NetworkPlatform

class ChatVM: ChatViewModel, ChatViewModelInputs, ChatViewModelOutputs {
    let disposeBag = DisposeBag()
    private var chatSocket: ChatWebSocketType
    private var counterSocket: CounterWebSocketType
    
    var inputs: ChatViewModelInputs { return self }
    var toggleChatSocket = PublishSubject<Bool>()
    
    var outputs: ChatViewModelOutputs { return self }
    var chatSocketState = PublishRelay<SocketState>()
    
    var receivedMessage: Observable<ChatCellViewModel>
    var viewerCounter: Observable<Int>
    
    init() {
        chatSocket = ChatWebSocket(channelId: String(UserController.shared.user.channel!.id!))
        receivedMessage = chatSocket.receivedMessage.asObservable().map { ChatCellViewModel(with: $0) }
        
        counterSocket = CounterWebSocket(channelId: UserController.shared.user.channel!.id!, userId: UserController.shared.user.id)
        viewerCounter = counterSocket.viewerCounter
        
        chatSocket.socketState
            .subscribe(onNext: {[weak self] state in
                self?.chatSocketState.accept(state)
                if state == .connected {
                    self?.counterSocket.open()
                } else if state == .disconnected {
                    self?.counterSocket.close()
                }
            }).disposed(by: disposeBag)
        
        toggleChatSocket
            .asObservable()
            .subscribe {[weak self] event in
                if let state = event.element {
                    if state {
                        self?.chatSocket.open()
                    } else {
                        self?.chatSocket.close()
                    }
                }
            }.disposed(by: disposeBag)
    }
}
