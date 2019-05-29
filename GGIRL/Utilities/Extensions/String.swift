//
//  String.swift
//  GGIRL
//
//  Created by VARVAR on 13.03.2019.
//  Copyright © 2019 GoodGame. All rights reserved.
//

extension String {
    func isEmptyOrWhitespace() -> Bool {
        return self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}
