//
//  MainLayoutModuleFactory.swift
//  GGIRL
//
//  Created by VARVAR on 18.02.2019.
//  Copyright © 2019 GoodGame. All rights reserved.
//

protocol AuthModuleFactory {
    func generateAuthModule() -> (AuthViewController, AuthViewModel)
    func generateGGAuthModule() -> GGLoginViewController
}
