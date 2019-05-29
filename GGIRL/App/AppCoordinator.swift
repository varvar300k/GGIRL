//
//  AppCoordinator.swift
//  GGIRL
//
//  Created by VARVAR on 18.02.2019.
//  Copyright © 2019 GoodGame. All rights reserved.
//

import UIKit
import RxSwift

final class AppCoordinator: BaseCoordinator {
    private let disposeBag = DisposeBag()
    private let coordinatorFactory: CoordinatorFactory
    private let router: Router
    
    init(router: Router, coordinatorFactory: CoordinatorFactory) {
        self.router = router
        self.coordinatorFactory = coordinatorFactory
    }
    
    override func start() {
        if UserController.shared.userWasAuthorized() {
            print("Info: AppCoordinator.start() > userWasAuthorized = true")
            UserController.shared.isUserAuthorized
                .asObservable()
                .debug()
                .observeOn(MainScheduler.instance)
                .subscribe(onNext: {isAuth in
                    if isAuth {
                        self.runMainFlow()
                    } else {
                        self.runAuthFlow()
                    }
                }).disposed(by: disposeBag)
        } else {
            print("Info: AppCoordinator.start() > userWasAuthorized = false")
            runAuthFlow()
        }
    }
    
    override func start(option: DeepLinkOption) {}
    
    private func runAuthFlow() {
        let coordinator = coordinatorFactory.generateAuthCoordinator(router: router)
        coordinator.finishFlow
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self, weak coordinator] _ in
                self?.removeDependency(coordinator)
                self?.start()
            }).disposed(by: disposeBag)
        addDependency(coordinator)
        coordinator.start()
    }
    
    private func runMainFlow() {
        let coordinator = coordinatorFactory.generateStreamCoordinator(router: router)
        coordinator.finishFlow
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self, weak coordinator] _ in
                self?.removeDependency(coordinator)
                self?.start()
            }).disposed(by: disposeBag)
        addDependency(coordinator)
        coordinator.start()
    }
}
