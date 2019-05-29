//
//  ChatSection.swift
//  GGIRL
//
//  Created by VARVAR on 19.03.2019.
//  Copyright © 2019 GoodGame. All rights reserved.
//

import Foundation
import Domain
import RxDataSources

struct ChatSection {
    var items: [Item]
}

extension ChatSection: AnimatableSectionModelType {
    typealias Item = ChatCellViewModel
    
    var identity: String {
        return "chat"
    }
    
    init(original: ChatSection, items: [ChatCellViewModel]) {
        self = original
        self.items = items
    }
    
}
