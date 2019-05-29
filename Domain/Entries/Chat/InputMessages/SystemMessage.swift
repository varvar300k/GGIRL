//
//  SystemMessage.swift
//  Domain
//
//  Created by VARVAR on 28.02.2019.
//  Copyright © 2019 GoodGame. All rights reserved.
//

public struct SystemMessage: ChatMessageType {
    public var text: String
    
    public init(text: String)  {
        self.text = text
    }
    
}
