//
//  StreamModuleFactory.swift
//  GGIRL
//
//  Created by VARVAR on 19.02.2019.
//  Copyright © 2019 GoodGame. All rights reserved.
//

protocol StreamModuleFactory {
    func generateStreamModule() -> (StreamViewController, StreamViewModel)
}
