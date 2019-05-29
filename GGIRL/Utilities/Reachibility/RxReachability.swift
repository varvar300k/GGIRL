//
//  RxReachability.swift
//  gg4
//
//  Created by VARVAR on 14.02.2019.
//  Copyright © 2019 GoodGame. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class RxReachability {
    static let shared = RxReachability()
    var reachability: Reachability?
    
    fileprivate init() {}
    
    func startMonitor() {
        guard reachability == nil else { return }
        reachability = Reachability()
        try? reachability?.startNotifier()
    }
    
    public var isReachableVar: Bool {
        return reachability?.connection != .none
    }
    
    public var reachabilityChanged: Observable<Reachability> {
        return NotificationCenter.default.rx.notification(Notification.Name.reachabilityChanged)
            .flatMap { notification -> Observable<Reachability> in
                guard let reachability = notification.object as? Reachability else {
                    return .empty()
                }
                return .just(reachability)
        }
    }
    
    public var isReachable: Observable<Bool> {
        return reachabilityChanged
            .map { $0.connection != .none }
    }
    
    public var isConnected: Observable<Void> {
        return isReachable
            .filter { $0 }
            .map { _ in Void() }
    }
    
    public var isDisconnected: Observable<Void> {
        return isReachable
            .filter { !$0 }
            .map { _ in Void() }
    }
    
}
