//
//  RouterImpl.swift
//  gg4
//
//  Created by VARVAR on 27.12.2018.
//  Copyright © 2018 GoodGame. All rights reserved.
//

import UIKit

final class RouterImpl: NSObject, Router, UINavigationControllerDelegate {
    
    private weak var rootController: UINavigationController?
    private var completions: [UIViewController: () -> Void]
    
    public init(rootController: UINavigationController) {
        self.rootController = rootController
        self.completions = [:]
//        self.rootController.delegate = self
    }
    
    func toPresent() -> UIViewController? {
        return rootController
    }
    
    func present(_ module: Presentable?) {
        present(module, animated: true)
    }
    
    func present(_ module: Presentable?, animated: Bool) {
        guard let controller = module?.toPresent() else {
            return
        }
        rootController?.present(controller, animated: animated, completion: nil)
    }
    
    func dismiss() {
        dismiss(animated: true, completion: nil)
    }
    
    func dismiss(animated: Bool, completion: (() -> Void)?) {
        rootController?.dismiss(animated: animated, completion: completion)
    }
    
    func push(_ module: Presentable?) {
        push(module, animated: true, completion: nil)
    }
    
    func push(_ module: Presentable?, animated: Bool, completion: (() -> Void)?) {
        guard let controller = module?.toPresent(), controller is UINavigationController == false else {
            return
        }
        
        if let completion = completion {
            completions[controller] = completion
        }
        rootController?.pushViewController(controller, animated: animated)
    }
    
    func pop() {
        pop(animated: true)
    }
    
    func pop(animated: Bool) {
        guard let controller = rootController?.popViewController(animated: animated) else {
            return
        }
        runCompletion(for: controller)
    }
    
    func setRoot(_ module: Presentable?) {
        setRoot(module, hideBar: false)
    }
    
    func setRoot(_ module: Presentable?, hideBar: Bool) {
        guard let controller = module?.toPresent() else {
            return
        }
        rootController?.setViewControllers([controller], animated: false)
        rootController?.isNavigationBarHidden = hideBar
    }
    
    func popToRoot() {
        popToRoot(animated: true)
    }
    
    func popToRoot(animated: Bool) {
        guard let controllers = rootController?.popToRootViewController(animated: animated) else {
            return
        }
        controllers.forEach { runCompletion(for: $0) }
    }
    
    private func runCompletion(for controller: UIViewController) {
        guard let completion = completions[controller] else { return }
        completion()
        completions.removeValue(forKey: controller)
    }
    
//    public func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
//        guard let poppedViewController = navigationController.transitionCoordinator?.viewController(forKey: .from), !navigationController.viewControllers.contains(poppedViewController) else {
//            return
//        }
//        runCompletion(for: poppedViewController)
        
//        if let poppedViewController = navigationController.transitionCoordinator?.viewController(forKey: .from), !navigationController.viewControllers.contains(poppedViewController) {
//            print("~> navControllerDidShow ~> pop \(poppedViewController)")
//        }
//    }
}
