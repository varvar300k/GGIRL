//
//  Coordinator.swift
//  gg4
//
//  Created by VARVAR on 27.12.2018.
//  Copyright © 2018 Goodgame. All rights reserved.
//

import UIKit

protocol Coordinator: class {
    func start()
    func start(option: DeepLinkOption)
}
