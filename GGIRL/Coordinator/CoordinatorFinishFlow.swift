//
//  CoordinatorFinishFlow.swift
//  gg4
//
//  Created by VARVAR on 25.01.2019.
//  Copyright © 2019 GoodGame. All rights reserved.
//

import Foundation
import RxSwift

protocol CoordinatorVoidFinishFlowType {
    var finishFlow: Observable<Void> { get }
}

protocol CoordinatorDeepLinkFinishFlowType {
    var finishFlowDeepLink: Observable<DeepLinkOption> { get }
}
