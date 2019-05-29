//
//  StreamCoordinator.swift
//  GGIRL
//
//  Created by VARVAR on 07.03.2019.
//  Copyright © 2019 GoodGame. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class StreamCoordinator: BaseCoordinator, CoordinatorVoidFinishFlowType {
    
    fileprivate let finishFlowObserver = PublishSubject<Void>()
    lazy var finishFlow: Observable<Void> = self.finishFlowObserver.asObservable()
    
    private let disposeBag = DisposeBag()
    private let moduleFactory: StreamModuleFactory
    private let coordinatorFactory: CoordinatorFactory
    private let router: Router
    
    init(moduleFactory: StreamModuleFactory, coordinatorFactory: CoordinatorFactory, router: Router) {
        self.moduleFactory = moduleFactory
        self.coordinatorFactory = coordinatorFactory
        self.router = router
    }
    
    override func start() {
        let (vc, vm) = moduleFactory.generateStreamModule()
        
        vm.outputs.settingsTapped
            .subscribe(onNext: {self.runSettingsFlow()})
            .disposed(by: disposeBag)

        self.router.setRoot(vc, hideBar: true)
        
//        DispatchQueue.main.async {
//            self.router.setRoot(vc, hideBar: true)
//        }
    }
    
    func runSettingsFlow() {
        let (presentable, coordinator) = coordinatorFactory.generateSettingsCoordinator()
        coordinator.finishFlow.subscribe(onNext: { [weak self, weak coordinator] _ in
            self?.router.dismiss()
            self?.removeDependency(coordinator)
            if !UserController.shared.isUserAuthorized.value {
                self?.finishFlowObserver.onNext(())
            }
        }).disposed(by: disposeBag)
        addDependency(coordinator)
        coordinator.start()
        router.present(presentable)
    }
}
