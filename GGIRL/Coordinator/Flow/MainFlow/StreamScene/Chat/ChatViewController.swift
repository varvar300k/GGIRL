//
//  ChatViewController.swift
//  GGIRL
//
//  Created by VARVAR on 20.02.2019.
//  Copyright © 2019 GoodGame. All rights reserved.
//

import UIKit
import Foundation
import RxSwift
import RxCocoa
import RxDataSources

class ChatViewController: CustomViewController<ChatView> {
    
    let disposeBag = DisposeBag()
    private var viewModel: ChatViewModel!
    
    var chatToggle: Bool = false {
        didSet {
            self.viewModel.inputs.toggleChatSocket.onNext(chatToggle)
            DispatchQueue.main.async {
                self.rootView.handleChatState(self.chatToggle)
            }
        }
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = ChatVM()
    }
    
    override func viewDidLoad() {
        setupBindings()
    }
    
    func setupBindings() {
        viewModel.outputs.receivedMessage
            .asObservable()
            .subscribe { [weak self] item in
                if let cellVM = item.element {
                    self?.rootView.chatTableView.newMessage.accept(cellVM)
                }
            }.disposed(by: disposeBag)
        viewModel.outputs.viewerCounter
            .asObservable()
            .observeOn(MainScheduler.instance)
            .subscribe { [weak self] event in
                if let count = event.element {
                    self?.rootView.setViewersCount(count)
                }
            }.disposed(by: disposeBag)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
