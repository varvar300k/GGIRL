//
//  СhatView.swift
//  GGIRL
//
//  Created by VARVAR on 07.03.2019.
//  Copyright © 2019 GoodGame. All rights reserved.
//

import Foundation
import UIKit

class ChatView: UIView {
    lazy var chatTableView: ChatTableView = ChatTableView()
    lazy var viewersIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "ic_viewers")
        imageView.height(14)
        imageView.width(14)
        return imageView
    }()
    lazy var viewersCount: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.text = "0"
        label.textColor = .white
        label.height(17)
        return label
    }()
    lazy var setViewersCount = { (_ count: Int) in
        self.viewersCount.text = String(count)
    }
    lazy var handleChatState = {(_ state: Bool) in
        self.chatTableView.isHidden = !state
        self.viewersIcon.isHidden = !state
        self.viewersCount.isHidden = !state
        self.setViewersCount(0)
    }
    
    private func configure() {
        self.addSubview(chatTableView)
        chatTableView.edgesToSuperview(excluding: .trailing)
        chatTableView.widthToSuperview(multiplier: 0.6)
        self.addSubview(viewersCount)
        viewersCount.bottomToSuperview(offset: -15)
        viewersCount.trailingToSuperview(offset: 15)
        self.addSubview(viewersIcon)
        viewersIcon.centerY(to: viewersCount)
        viewersIcon.trailingToLeading(of: viewersCount, offset: -5)
        handleChatState(false)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
