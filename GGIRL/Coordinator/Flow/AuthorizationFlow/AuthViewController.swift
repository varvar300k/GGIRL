//
//  AuthViewController.swift
//  GGIRL
//
//  Created by VARVAR on 18.02.2019.
//  Copyright © 2019 GoodGame. All rights reserved.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift
import GoodConstraints

class AuthViewController: NormalTraitsViewController {
    
    let disposeBag = DisposeBag()
    private var viewModel: AuthViewModel!
    
    var customKeyField: UITextField!
    var customLoginButton: UIButton!
    var activityIndicator: UIActivityIndicatorView!
    
    func injectViewModel(viewModel: AuthViewModel) {
        self.viewModel = viewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBindings()
        
    }
    
    func setupUI() {
        view.backgroundColor = UIColor.darkGrey
        
        let centerStyle = NSMutableParagraphStyle()
        centerStyle.alignment = NSTextAlignment.center
        
        let ggirl = UILabel()
        let strokeTextAttributes = [
            NSAttributedString.Key.strokeColor : UIColor.ggirl,
            NSAttributedString.Key.foregroundColor : UIColor.clear,
            NSAttributedString.Key.strokeWidth : -4.0,
            NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 64),
            NSAttributedString.Key.paragraphStyle : centerStyle]
            as [NSAttributedString.Key : Any]
        ggirl.attributedText = NSMutableAttributedString(string: "GGIRL", attributes: strokeTextAttributes)
        ggirl.numberOfLines = 0
        view.addSubview(ggirl)
        ggirl.leadingToSuperview()
        ggirl.trailingToSuperview()
        ggirl.centerXToSuperview()
        ggirl.topToSuperview(offset: 150)
        
        
        customKeyField = UITextField()
        customKeyField.autocorrectionType = .no
        customKeyField.attributedPlaceholder = NSAttributedString(string: "Введите StreamKey от GoodGame",
                                                               attributes: [NSAttributedString.Key.foregroundColor: UIColor.ggirl,
                                                                            NSAttributedString.Key.paragraphStyle : centerStyle])
        customKeyField.backgroundColor = .clear
        customKeyField.textColor = UIColor.ggirl
        customKeyField.tintColor = UIColor.white
        customKeyField.layer.borderColor = UIColor.ggirl.cgColor
        customKeyField.layer.borderWidth = 1
        customKeyField.layer.cornerRadius = 4
        view.addSubview(customKeyField)
        customKeyField.height(40)
        customKeyField.leadingToSuperview(offset: 20)
        customKeyField.trailingToSuperview(offset: 20)
        customKeyField.centerInSuperview()
        customKeyField.delegate = self
        
        customLoginButton = UIButton()
        customLoginButton.setTitle("Подтвердить", for: .normal)
        customLoginButton.setTitleColor(UIColor.gray, for: .normal)
        customLoginButton.backgroundColor = UIColor.clear
        customLoginButton.layer.borderColor = UIColor.gray.cgColor
        customLoginButton.layer.borderWidth = 1
        customLoginButton.layer.cornerRadius = 4
        view.addSubview(customLoginButton)
        customLoginButton.width(130)
        customLoginButton.height(35)
        customLoginButton.centerXToSuperview()
        customLoginButton.topToBottom(of: customKeyField, offset: 40)
        
    }
    
    func setupBindings() {
        customKeyField
            .rx.text
            .asDriver()
            .map { [weak self] text in
                if let _text = text, _text.count > 5 {
                    self?.customLoginButton.setTitleColor(UIColor.ggirl, for: .normal)
                    self?.customLoginButton.layer.borderColor = UIColor.ggirl.cgColor
                    self?.customLoginButton.isEnabled = true
                } else {
                    self?.customLoginButton.setTitleColor(UIColor.gray, for: .normal)
                    self?.customLoginButton.layer.borderColor = UIColor.gray.cgColor
                    self?.customLoginButton.isEnabled = false
                }
            }
            .drive()
            .disposed(by: disposeBag)
        
        customLoginButton
            .rx.tap
            .asDriver()
//            .map({ [weak self] in
//                return self?.customKeyField.text ?? ""
//            })
//            .filter { $0.count > 5 }
            .drive(onNext: { [weak self] in
                if let strongSelf = self {
                    strongSelf.viewModel.inputs.tapCustomLogin.accept(strongSelf.customKeyField.text!)
                }
            })
            .disposed(by: disposeBag)
    }
}

extension AuthViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
