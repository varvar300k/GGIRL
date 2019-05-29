//
//  ErrorSplashScreen.swift
//  gg4
//
//  Created by VARVAR on 14.02.2019.
//  Copyright © 2019 GoodGame. All rights reserved.
//

import Foundation
import UIKit
import GoodConstraints

enum ErrorScreenSettings {
    case cantLoadStreams
    case favsNotAuth
    case favsEmpty
    
    var view: UIView {
        switch self {
        case .cantLoadStreams:
            return cantLoadStreamsView
        case .favsNotAuth:
            return favsNotAuthView
        case .favsEmpty:
            return favsEmptyView
        }
    }
    
    private var cantLoadStreamsView: UIView {
        let view = UIView()
        view.backgroundColor = UIColor.bgBlack
        
        let image = UIImageView(image: UIImage(named: "imgLoadError")!)
        
        let font = UIFont.systemFont(ofSize: 16)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        let attributes: [NSAttributedString.Key: Any] = [
            .font: font,
            .foregroundColor: UIColor.white,
            .paragraphStyle: paragraphStyle
        ]
        let text = "Ошибка при загрузке списка стримов.\n\nПроверьте соединение с интернетом и обновите еще раз."
        let attributedText = NSAttributedString(string: text, attributes: attributes)
        let textLabel = UILabel()
        textLabel.attributedText = attributedText
        textLabel.numberOfLines = 0
        
        view.addSubview(image)
        image.size(CGSize(width: 162, height: 168))
        image.centerXToSuperview()
        image.centerYToSuperview(offset: -55)
        
        view.addSubview(textLabel)
        textLabel.width(304)
        textLabel.centerXToSuperview()
        textLabel.topToBottom(of: image, offset: 16)
        
        return view
    }
    
    private var favsNotAuthView: UIView {
        let view = UIView()
        view.backgroundColor = UIColor.bgBlack
        
        let image = UIImageView(image: UIImage(named: "imgFavsNotAuth")!)
        let imageArrow = UIImageView(image: UIImage(named: "icAuthArrow")!)
        
        let font = UIFont.systemFont(ofSize: 16)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        let attributes: [NSAttributedString.Key: Any] = [
            .font: font,
            .foregroundColor: UIColor.white,
            .paragraphStyle: paragraphStyle
        ]
        let text = "Авторизуйтесь для просмотра избранных стримов."
        let attributedText = NSAttributedString(string: text, attributes: attributes)
        let textLabel = UILabel()
        textLabel.attributedText = attributedText
        textLabel.numberOfLines = 0
        
        view.addSubview(image)
        image.size(CGSize(width: 162, height: 168))
        image.topToSuperview(offset: 104)
        image.centerXToSuperview()
        
        view.addSubview(imageArrow)
        imageArrow.bottomToTop(of: image)
        imageArrow.leadingToTrailing(of: image)
        imageArrow.trailingToSuperview(offset: 25)
        imageArrow.topToSuperview(offset: 8)
        
        view.addSubview(textLabel)
        textLabel.centerXToSuperview()
        textLabel.topToBottom(of: image, offset: 16)
        textLabel.leadingToSuperview(offset: 10)
        textLabel.trailingToSuperview(offset: 10)
        
        return view
    }
    
    private var favsEmptyView: UIView {
        let view = UIView()
        view.backgroundColor = UIColor.bgBlack
        
        let image = UIImageView(image: UIImage(named: "imgFavsEmpty")!)
        let imageDemo = UIImageView(image: UIImage(named: "icDemoAddFav")!)
        
        let font = UIFont.systemFont(ofSize: 16)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        let attributes: [NSAttributedString.Key: Any] = [
            .font: font,
            .foregroundColor: UIColor.white,
            .paragraphStyle: paragraphStyle
        ]
        let text = "У вас нет избранных стримов.\n\nДобавьте понравившийся стрим в избранное, нажав на сердечко."
        let attributedText = NSAttributedString(string: text, attributes: attributes)
        let textLabel = UILabel()
        textLabel.attributedText = attributedText
        textLabel.numberOfLines = 0
        
        view.addSubview(image)
        view.addSubview(imageDemo)
        view.addSubview(textLabel)
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            image.size(CGSize(width: 162, height: 168))
            image.centerXToSuperview()
            image.centerYToSuperview()
            imageDemo.isHidden = true
            textLabel.leadingToSuperview(offset: 10)
            textLabel.trailingToSuperview(offset: 10)
            textLabel.centerXToSuperview()
            textLabel.topToBottom(of: image, offset: 16)
        } else {
            image.size(CGSize(width: 162, height: 168))
            image.centerXToSuperview()
            image.topToSuperview(offset: 32)
            textLabel.leadingToSuperview(offset: 10)
            textLabel.trailingToSuperview(offset: 10)
            textLabel.centerXToSuperview()
            textLabel.topToBottom(of: image, offset: 16)
            imageDemo.isHidden = false
            imageDemo.height(160)
            imageDemo.width(320)
            imageDemo.centerXToSuperview()
            imageDemo.bottomToSuperview(offset: -49)
        }
        
        return view
    }
}
