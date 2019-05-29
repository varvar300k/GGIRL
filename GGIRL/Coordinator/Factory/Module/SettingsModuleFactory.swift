//
//  SettingsModuleFactory.swift
//  GGIRL
//
//  Created by VARVAR on 05.05.2019.
//  Copyright © 2019 GoodGame. All rights reserved.
//

protocol SettingsModuleFactory {
    func generateSettingsModule() -> (SettingsViewController, SettingsViewModel)
}
