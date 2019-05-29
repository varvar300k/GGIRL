//
//  MainLayoutCoordinator.swift
//  GGIRL
//
//  Created by VARVAR on 18.02.2019.
//  Copyright © 2019 GoodGame. All rights reserved.
//

import UIKit
import RxSwift

class AuthCoordinator: BaseCoordinator, CoordinatorVoidFinishFlowType {
    
    fileprivate let finishFlowObserver = PublishSubject<Void>()
    lazy var finishFlow: Observable<Void> = self.finishFlowObserver.asObservable()
    
    private let disposeBag = DisposeBag()
    private let moduleFactory: AuthModuleFactory
    private let coordinatorFactory: CoordinatorFactory
    private let router: Router
    
    init(moduleFactory: AuthModuleFactory, coordinatorFactory: CoordinatorFactory, router: Router) {
        self.moduleFactory = moduleFactory
        self.coordinatorFactory = coordinatorFactory
        self.router = router
    }
    
    override func start() {
//        let (vc, vm) = moduleFactory.generateAuthModule()
//
//        vm.outputs.customLoginTapped
//            .bind(to: self.finishFlowObserver)
//            .disposed(by: disposeBag)

        
        let vc = moduleFactory.generateGGAuthModule()
        
        vc.userLoggedIn
            .asObservable()
            .debug()
            .bind(to: self.finishFlowObserver)
            .disposed(by: disposeBag)
        self.router.setRoot(vc, hideBar: true)
//        DispatchQueue.main.async {
//            self.router.setRoot(vc, hideBar: true)
//        }
    }
}
