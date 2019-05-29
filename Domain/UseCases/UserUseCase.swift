//
//  UserUseCase.swift
//  Domain
//
//  Created by VARVAR on 11.04.2019.
//  Copyright © 2019 GoodGame. All rights reserved.
//

import Foundation
import RxSwift

public protocol UserUseCase {
    func load(params: [String: String]) -> Observable<User>
}
