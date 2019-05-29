//
//  DependencyCoordinatorProtocol.swift
//  gg4
//
//  Created by VARVAR on 07.01.2019.
//  Copyright © 2019 GoodGame. All rights reserved.
//

import UIKit

protocol DependencyCoordinatorProtocol: class {
    var childCoordinators: [Coordinator] { get set }
    
    func addDependency(_ coordinator: Coordinator)
    func removeDependency(_ coordinator: Coordinator?)
}
