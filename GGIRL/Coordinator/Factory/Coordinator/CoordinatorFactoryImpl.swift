//
//  CoordinatorFactoryImpl.swift
//  gg4
//
//  Created by VARVAR on 07.01.2019.
//  Copyright © 2019 GoodGame. All rights reserved.
//

import UIKit

final class CoordinatorFactoryImpl: CoordinatorFactory {
    
    func generateAuthCoordinator(router: Router) -> Coordinator & CoordinatorVoidFinishFlowType {
        return AuthCoordinator(moduleFactory: ModuleFactory(), coordinatorFactory: CoordinatorFactoryImpl(), router: router)
    }
    
    func generateStreamCoordinator(router: Router) -> Coordinator & CoordinatorVoidFinishFlowType {
        return StreamCoordinator(moduleFactory: ModuleFactory(), coordinatorFactory: CoordinatorFactoryImpl(), router: router)
    }
    
    func generateSettingsCoordinator() -> (presentable: Presentable?, coordinator: (Coordinator & CoordinatorVoidFinishFlowType)) {
        let router = self.router(navigationController(nil))
        let coordinator =  SettingsCoordinator(moduleFactory: ModuleFactory(), coordinatorFactory: CoordinatorFactoryImpl(), router: router)
        return (router, coordinator)
    }
    
    func router(_ navController: UINavigationController?) -> Router {
        return RouterImpl(rootController: navigationController(navController))
    }
    
    func navigationController(_ navController: UINavigationController?) -> UINavigationController {
        if let navController = navController { return navController }
        else { return UIStoryboard.initViewController(withType: UINavigationController.self) }
    }
}
