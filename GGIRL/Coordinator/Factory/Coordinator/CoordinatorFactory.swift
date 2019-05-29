//
//  CoordinatorFactory.swift
//  gg4
//
//  Created by VARVAR on 27.12.2018.
//  Copyright © 2018 GoodGame. All rights reserved.
//

import UIKit

protocol CoordinatorFactory {
    func generateAuthCoordinator(router: Router) -> Coordinator & CoordinatorVoidFinishFlowType
    func generateStreamCoordinator(router: Router) -> Coordinator & CoordinatorVoidFinishFlowType
    func generateSettingsCoordinator() -> (presentable: Presentable?, coordinator: (Coordinator & CoordinatorVoidFinishFlowType))
    
    func router(_ navController: UINavigationController?) -> Router
    func navigationController(_ navController: UINavigationController?) -> UINavigationController
}
