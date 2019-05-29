//
//  ModuleFactory.swift
//  gg4
//
//  Created by VARVAR on 09.01.2019.
//  Copyright © 2019 GoodGame. All rights reserved.
//

import UIKit

final class ModuleFactory {}

extension ModuleFactory: AuthModuleFactory {
    func generateAuthModule() -> (AuthViewController, AuthViewModel) {
        let viewController = AuthViewController()
        let viewModel = AuthVM()
        viewController.injectViewModel(viewModel: viewModel)
        return (viewController, viewModel)
    }
    func generateGGAuthModule() -> GGLoginViewController {
        return GGLoginViewController()
    }
}

extension ModuleFactory: StreamModuleFactory {
    func generateStreamModule() -> (StreamViewController, StreamViewModel) {
        let viewController = StreamViewController()
        let viewModel = StreamVM()
        viewController.injectViewModel(viewModel: viewModel)
        return (viewController, viewModel)
    }
}

extension ModuleFactory: SettingsModuleFactory {
    func generateSettingsModule() -> (SettingsViewController, SettingsViewModel) {
        let viewController = SettingsViewController()
        let viewModel = SettingsVM()
        viewController.injectViewModel(viewModel: viewModel)
        return (viewController, viewModel)
    }
}

