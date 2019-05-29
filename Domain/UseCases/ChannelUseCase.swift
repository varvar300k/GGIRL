//
//  ChannelUseCase.swift
//  Domain
//
//  Created by VARVAR on 17.04.2019.
//  Copyright © 2019 GoodGame. All rights reserved.
//

import Foundation
import RxSwift

public protocol ChannelUseCase {
    func load(params: [String: String]) -> Observable<Channel>
    func setup(data: [String:Any]) -> Observable<Channel>
}
