//
//  BaseNavigationController.swift
//  gg4ios
//
//  Created by VARVAR on 29.11.2018.
//  Copyright © 2018 GoodGame. All rights reserved.
//

import UIKit
import RxSwift

fileprivate enum NavControllerType {
    case tabStreams
    case tabGames
    case tabFavorites
    case innerGames
}

protocol NavBarSettable {
}

extension NavBarSettable where Self: UIViewController {
    var sideMenuNavBarBtn: UIBarButtonItem { return UIBarButtonItem(image: UIImage(named: "icMenu")?.withRenderingMode(.alwaysOriginal), style: .plain, target: nil, action: nil) }
    var searchNavBarBtn: UIBarButtonItem { return UIBarButtonItem(image: UIImage(named: "icSearch")?.withRenderingMode(.alwaysOriginal), style: .plain, target: nil, action: nil) }
    var profileNavBarBtn: UIBarButtonItem { return UIBarButtonItem(image: UIImage(named: "icMan")?.withRenderingMode(.alwaysOriginal), style: .plain, target: nil, action: nil) }
    var backNavBarBtn: UIBarButtonItem { return UIBarButtonItem(image: UIImage(named: "icBackArrow")?.withRenderingMode(.alwaysOriginal), style: .plain, target: nil, action: nil) }
    func setupNavBar(title: String = "", leftButtons: [UIBarButtonItem], rightButtons: [UIBarButtonItem]) {
        navigationController?.navigationBar.tintColor = .white
        navigationItem.title = title
        navigationItem.leftBarButtonItems = leftButtons
        navigationItem.rightBarButtonItems = rightButtons
    }
}

//    func setupNavBar(type: NavControllerType, _ game: String = "") -> [Direction:[UIBarButtonItem]] {
//        navigationController?.navigationBar.tintColor = .white
//        switch type {
//        case .tabStreams:
//            self.navigationItem.title = "Стримы"
//            self.navigationItem.leftBarButtonItem = sideMenuBtn
//            self.navigationItem.rightBarButtonItems = [profileBtn, searchBtn]
//        case .tabGames:
//            self.navigationItem.title = "Игры"
//            self.navigationItem.leftBarButtonItem = sideMenuBtn
//            self.navigationItem.rightBarButtonItems = [profileBtn, searchBtn]
//        case .tabFavorites:
//            self.navigationItem.title = "Избранное"
//            self.navigationItem.leftBarButtonItem = sideMenuBtn
//            self.navigationItem.rightBarButtonItems = [profileBtn, searchBtn]
//        case .innerGames:
//            self.navigationItem.title = game
//            self.navigationItem.leftBarButtonItem = backBtn
//            self.navigationItem.rightBarButtonItems = [profileBtn, searchBtn]
//        }
//    }
