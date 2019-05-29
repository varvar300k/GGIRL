//
//  SettingsCoordinator.swift
//  GGIRL
//
//  Created by VARVAR on 07.03.2019.
//  Copyright © 2019 GoodGame. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class SettingsCoordinator: BaseCoordinator, CoordinatorVoidFinishFlowType {

    fileprivate let finishFlowObserver = PublishSubject<Void>()
    lazy var finishFlow: Observable<Void> = self.finishFlowObserver.asObservable()

    private let disposeBag = DisposeBag()
    private let moduleFactory: SettingsModuleFactory
    private let coordinatorFactory: CoordinatorFactory
    private let router: Router

    init(moduleFactory: SettingsModuleFactory, coordinatorFactory: CoordinatorFactory, router: Router) {
        self.moduleFactory = moduleFactory
        self.coordinatorFactory = coordinatorFactory
        self.router = router
    }

    override func start() {
        let (vc, vm) = moduleFactory.generateSettingsModule()

        vm.outputs.closeTapped
            .bind(to: self.finishFlowObserver)
            .disposed(by: disposeBag)
        
        vm.outputs.logOutTapped
            .do(onNext: {UserController.shared.logout()})
            .bind(to: self.finishFlowObserver)
            .disposed(by: disposeBag)

        router.setRoot(vc, hideBar: true)
        
//        DispatchQueue.main.async {
//            self.router.setRoot(vc, hideBar: true)
//        }
    }
}
