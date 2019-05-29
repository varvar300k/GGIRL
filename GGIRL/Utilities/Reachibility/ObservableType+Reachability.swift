//
//  ObservableType+Reachability.swift
//  gg4
//
//  Created by VARVAR on 13.02.2019.
//  Copyright © 2019 GoodGame. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

public extension ObservableType {
    func retryOnConnect(timeout: DispatchTimeInterval) -> Observable<Element> {
        return retryWhen { _ in
            return RxReachability
                .shared
                .isConnected
                .timeout(timeout, scheduler: MainScheduler.asyncInstance)
        }
    }
    
    func retryOnConnect(
        timeout: DispatchTimeInterval,
        predicate: @escaping (Swift.Error) -> Bool
        ) -> Observable<Element> {
        return retryWhen {
            return $0
                .filter(predicate)
                .flatMap { _ in
                    RxReachability
                        .shared
                        .isConnected
                        .timeout(
                            timeout,
                            scheduler: MainScheduler.asyncInstance
                    )
            }
        }
    }
    
    func retryLatestOnConnect(
        timeout: DispatchTimeInterval,
        predicate: @escaping (Swift.Error) -> Bool
        ) -> Observable<Element> {
        return retryWhen {
            return $0
                .filter(predicate)
                .flatMapLatest { _ in
                    RxReachability
                        .shared
                        .isConnected
                        .timeout(
                            timeout,
                            scheduler: MainScheduler.asyncInstance
                    )
            }
        }
    }
    
}
