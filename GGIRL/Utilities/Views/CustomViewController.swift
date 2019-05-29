//
//  CustomViewController.swift
//  GGIRL
//
//  Created by VARVAR on 01.03.2019.
//  Copyright © 2019 GoodGame. All rights reserved.
//

import UIKit

class CustomViewController<CustomView: UIView>: UIViewController {
    var rootView: CustomView {
        return view as! CustomView
    }
    
    func view() -> CustomView {
        return view as! CustomView
    }
    
    override func loadView() {
        view = CustomView()
    }
}
