//
//  StreamView.swift
//  GGIRL
//
//  Created by VARVAR on 01.03.2019.
//  Copyright © 2019 GoodGame. All rights reserved.
//

import Foundation
import UIKit

class StreamView: UIView {
    
    lazy var topControlBar: TopControlBarView = TopControlBarView()
    private lazy var topConstraint = self.topControlBar.topToSuperview()
    
    lazy var bottomControlBar: BottomControlBarView = BottomControlBarView()
    private lazy var bottomConstraint = self.bottomControlBar.bottomToSuperview()
    
    lazy var cameraPreview: UIView = UIView(frame: .zero)
    
    lazy var chatContainer = UIView()
    
    
    lazy var handleTap = {
        if self.bottomConstraint.constant == 0 {
            self.bottomConstraint.constant = -40
        } else {
            self.bottomConstraint.constant = 0
        }
        UIViewPropertyAnimator(duration: 0.3, curve: .linear) {
            self.layoutIfNeeded()
            }.startAnimation()
    }
    
    lazy var handleSwipe = { (dir: Direction) in
        switch dir {
        case .up:
            self.topConstraint.constant = -40
        case .down:
            self.topConstraint.constant = 0
        default:
            return
        }
        UIViewPropertyAnimator(duration: 0.3, curve: .linear) {
            self.layoutIfNeeded()
            }.startAnimation()
    }

    private func setupView() {
        self.backgroundColor = .clear
        self.addSubview(cameraPreview)
        cameraPreview.edgesToSuperview()
        self.addSubview(topControlBar)
        topControlBar.edgesToSuperview(excluding: .bottom, usingSafeArea: true)
        topConstraint.constant = 0
        self.addSubview(bottomControlBar)
        bottomControlBar.edgesToSuperview(excluding: .top, usingSafeArea: true)
        bottomConstraint.constant = 0
        self.addSubview(chatContainer)
        chatContainer.backgroundColor = .clear
        chatContainer.leadingToSuperview()
        chatContainer.bottomToTop(of: bottomControlBar)
        chatContainer.widthToSuperview()
        chatContainer.heightToSuperview(multiplier: 0.6)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
