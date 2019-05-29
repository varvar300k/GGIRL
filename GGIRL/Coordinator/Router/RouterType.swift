//
//  Router.swift
//  gg4
//
//  Created by VARVAR on 27.12.2018.
//  Copyright © 2018 GoodGame. All rights reserved.
//

import UIKit

protocol Router: Presentable {
    func present(_ module: Presentable?)
    func present(_ module: Presentable?, animated: Bool)
    func push(_ module: Presentable?)
    func push(_ module: Presentable?, animated: Bool, completion: (() -> Void)?)
    func pop()
    func pop(animated: Bool)
    func dismiss()
    func dismiss(animated: Bool, completion: (() -> Void)?)
    func setRoot(_ module: Presentable?)
    func setRoot(_ module: Presentable?, hideBar: Bool)
    func popToRoot()
    func popToRoot(animated: Bool)
}
