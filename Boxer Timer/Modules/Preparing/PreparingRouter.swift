//
//  PreparingRouter.swift
//  Boxer Timer
//
//  Created by Admin on 18.07.2018.
//  Copyright © 2018 Марат Нургалиев. All rights reserved.
//

import Foundation

class PreparingRouter: PreparingRouterProtocol {
    
    weak var viewController: PreparingViewController!
    
    init(viewController: PreparingViewController) {
        self.viewController = viewController
    }
    
    func showTimerController() {
        viewController.performSegue(withIdentifier: "showTimer", sender: nil)
    }
}
