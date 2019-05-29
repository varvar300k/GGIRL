//
//  Observable+Ext.swift
//  gg4
//
//  Created by VARVAR on 13.12.2018.
//  Copyright © 2018 GoodGame. All rights reserved.
//


import Foundation
import RxSwift
import RxCocoa

extension ObservableType where Element == Bool {
    public func not() -> Observable<Bool> {
        return self.map(!)
    }
    
}

extension SharedSequenceConvertibleType {
    func mapToVoid() -> SharedSequence<SharingStrategy, Void> {
        return map { _ in }
    }
}

extension ObservableType {
    
    func catchErrorJustComplete() -> Observable<Element> {
        return catchError { _ in
            return Observable.empty()
        }
    }
    
    func asDriverOnErrorJustComplete() -> Driver<Element> {
        return asDriver { error in
            return Driver.empty()
        }
    }
    
    func mapToVoid() -> Observable<Void> {
        return map { _ in }
    }
}
