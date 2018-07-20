//
//  TimerRouter.swift
//  Boxer Timer
//
//  Created by Admin on 20.07.2018.
//  Copyright © 2018 Марат Нургалиев. All rights reserved.
//

import Foundation

class TimerRouter: TimerRouterProtocol {
    
    weak var viewController: TimerViewController!
    
    init(viewController: TimerViewController) {
        self.viewController = viewController
    }
    
    func goBack() {
        _ = viewController.navigationController?.popViewController(animated: true)
    }
}
