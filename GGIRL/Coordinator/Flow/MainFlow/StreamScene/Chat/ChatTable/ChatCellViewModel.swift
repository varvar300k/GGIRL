//
//  ChatItemViewModel.swift
//  GGIRL
//
//  Created by VARVAR on 11.03.2019.
//  Copyright © 2019 GoodGame. All rights reserved.
//

import Domain
import RxDataSources

public struct ChatCellViewModel {
    let attrText: NSAttributedString
    let message: ChatMessageType
    init(with message: ChatMessageType) {
        self.message = message
        self.attrText = ChatUtils.shared.message.makeAttrMessage(message: message)
    }
}

extension ChatCellViewModel: IdentifiableType {
    public typealias Identity = String
    public var identity: String {
        return message.text
    }
}

extension ChatCellViewModel: Equatable {
}

public func == (lhs: ChatCellViewModel, rhs: ChatCellViewModel) -> Bool {
    return lhs.identity == rhs.identity
}
