//
//  CoordinatorProtocol.swift
//  gg4ios
//
//  Created by VARVAR on 29.10.2018.
//  Copyright © 2018 GoodGame. All rights reserved.
//

import Foundation
import RxSwift

class BaseCoordinator: Coordinator, DependencyCoordinatorProtocol {
    
    var childCoordinators: [Coordinator] = []
    
    func addDependency(_ coordinator: Coordinator) {
        if childCoordinators.contains(where: { $0 === coordinator }) {
            return
        }
        childCoordinators.append(coordinator)
    }
    
    func removeDependency(_ coordinator: Coordinator?) {
        guard let coordinator = coordinator else {
            return
        }
        guard let index = childCoordinators.firstIndex(where: { $0 === coordinator}) else {
            return
        }
        childCoordinators.remove(at: index)
    }
    
    func start() {
        fatalError("Required Override")
    }
    
    func start(option: DeepLinkOption) {}
}
