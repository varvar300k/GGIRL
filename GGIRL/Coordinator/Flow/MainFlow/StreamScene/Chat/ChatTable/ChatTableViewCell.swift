//
//  ChatMessageCellView.swift
//  GGIRL
//
//  Created by VARVAR on 12.03.2019.
//  Copyright © 2019 GoodGame. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ChatTableViewCell: UITableViewCell {
    
    var viewModel: ChatCellViewModel!
    
    func bind(_ viewModel: ChatCellViewModel) {
        self.viewModel = viewModel
        self.messageLabel.attributedText = viewModel.attrText
    }
    
    lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var cellView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.chatMessage
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 8
        return view
    }()
    
    lazy var spaceView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.height(5)
        return view
    }()
    
    func setupView() {
        self.backgroundColor = .clear
        contentView.addSubview(spaceView)
        spaceView.edgesToSuperview(excluding: .top)
        contentView.addSubview(cellView)
        cellView.topToSuperview()
        cellView.leadingToSuperview(offset: 5)
        cellView.trailingToSuperview()
        cellView.bottomToTop(of: spaceView)
        cellView.addSubview(messageLabel)
        messageLabel.edgesToSuperview(insets: UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5))
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
