//
//  LoginUseCase.swift
//  Domain
//
//  Created by VARVAR on 17.04.2019.
//  Copyright © 2019 GoodGame. All rights reserved.
//

import Foundation
import RxSwift

public protocol AuthUseCase {
    func login(data: [String:Any]) -> Observable<Auth>
}
