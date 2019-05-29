//
//  BottomControlBarView.swift
//  GGIRL
//
//  Created by VARVAR on 04.03.2019.
//  Copyright © 2019 GoodGame. All rights reserved.
//


import Foundation
import UIKit

class BottomControlBarView: UIView {
    
    lazy var toggleMicroButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "mic_on_button")!, for: .normal)
        button.size(CGSize(width: 32, height: 32))
        return button
    }()
    
    lazy var switchCameraButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "switch_camera_button")!, for: .normal)
        button.size(CGSize(width: 32, height: 32))
        return button
    }()
    
    lazy var lockOrientationButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "unlock_orientation_button")!, for: .normal)
        button.size(CGSize(width: 32, height: 32))
        return button
    }()
    
    lazy var pauseButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(#imageLiteral(resourceName: "pause_button"), for: .normal)
        button.size(CGSize(width: 32, height: 32))
        return button
    }()
    
    lazy var toggleTorchButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "torch_off_button")!, for: .normal)
        button.size(CGSize(width: 32, height: 32))
        return button
    }()
    
    lazy var handleMicroState = { (_ state: Bool) in
        self.toggleMicroButton.setBackgroundImage(UIImage(named: state ? "mic_on_button" : "mic_off_button")!, for: .normal)
    }
    
    lazy var handleLockOrientationState = { (_ state: Bool) in
        self.lockOrientationButton.setBackgroundImage(UIImage(named: state ? "lock_orientation_button" : "unlock_orientation_button")!, for: .normal)
    }
    
    lazy var handlePauseState = { () in
        self.pauseButton.isSelected = !self.pauseButton.isSelected
        self.pauseButton.setBackgroundImage(self.pauseButton.isSelected ? #imageLiteral(resourceName: "play_button") : #imageLiteral(resourceName: "pause_button"), for: .normal)
        self.handleMicroState(true)
        self.handleTorchState(false)
    }
    
    lazy var handleTorchState = { (_ state: Bool) in
        self.toggleTorchButton.setBackgroundImage(UIImage(named: state ? "torch_on_button" : "torch_off_button")!, for: .normal)
    }
    
    private func setupView() {
        self.backgroundColor = UIColor.navBarBlue
        self.height(44)
        let controlStack = UIStackView(arrangedSubviews: [toggleMicroButton, switchCameraButton, lockOrientationButton, toggleTorchButton, pauseButton])
        controlStack.axis = .horizontal
        controlStack.distribution = .equalSpacing
        controlStack.alignment = .center
        self.addSubview(controlStack)
        controlStack.edgesToSuperview(insets: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16))
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
