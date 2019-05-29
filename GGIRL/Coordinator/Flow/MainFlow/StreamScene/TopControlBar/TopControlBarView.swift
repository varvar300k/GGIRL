//
//  TopControlBarView.swift
//  GGIRL
//
//  Created by VARVAR on 01.03.2019.
//  Copyright © 2019 GoodGame. All rights reserved.
//

import Foundation
import UIKit

class TopControlBarView: UIView {
    
    lazy var settingsButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "settings_button")!, for: .normal)
        button.size(CGSize(width: 32, height: 32))
        return button
    }()
    
    lazy var publishButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.setBackgroundImage(UIImage(named: "publish_button")!, for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 16
        button.size(CGSize(width: 32, height: 32))
        return button
    }()
    
    private lazy var stateView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.width(100)
        let icon = UIView()
        view.addSubview(icon)
        icon.size(CGSize(width: 16, height: 16))
        icon.layer.masksToBounds = true
        icon.layer.cornerRadius = 8
        icon.centerYToSuperview()
        icon.leadingToSuperview(offset: 5)
        let label = UILabel()
        view.addSubview(label)
        label.centerYToSuperview()
        label.leadingToTrailing(of: icon, offset: 5)
        return view
    }()
    
    lazy var handleStreamState = { () in
        DispatchQueue.main.async {
            let state = Preference.shared.stream.status
            let label = self.stateView.subviews.first(where: { $0 is UILabel }) as! UILabel
            let icon = self.stateView.subviews.first(where: { !($0 is UILabel) })
            var attributes: [NSAttributedString.Key: Any] = [
                .font: UIFont.systemFont(ofSize: 16),
                .foregroundColor: state == .offline ? UIColor.gray : UIColor.white,
                .paragraphStyle: NSMutableParagraphStyle()
            ]
            switch state {
            case .online:
                label.attributedText = NSMutableAttributedString(string: "ONLINE", attributes: attributes)
                icon?.backgroundColor = .red
            case .connecting:
                label.attributedText = NSMutableAttributedString(string: "CONNECTING", attributes: attributes)
                icon?.backgroundColor = .orange
            case .offline:
                label.attributedText = NSMutableAttributedString(string: "OFFLINE", attributes: attributes)
                icon?.backgroundColor = .gray
            }
            self.publishButton.setBackgroundImage(UIImage(named: state == .offline ? "publish_button" : "stop_button" ), for: .normal)
        }
    }
    
    private func setupView() {
        self.backgroundColor = UIColor.navBarBlue
        self.height(44)
        let controlStack = UIStackView(arrangedSubviews: [settingsButton, stateView, publishButton])
        controlStack.axis = .horizontal
        controlStack.distribution = .equalSpacing
        controlStack.alignment = .center
        self.addSubview(controlStack)
        controlStack.edgesToSuperview(insets: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16))
        self.handleStreamState()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
