//
//  TimerConfigurator.swift
//  Boxer Timer
//
//  Created by Admin on 20.07.2018.
//  Copyright © 2018 Марат Нургалиев. All rights reserved.
//

import Foundation

class TimerConfigurator: TimerConfiguratorProtocol {
    
    func configure(with viewController: TimerViewController) {
        
        let presenter = TimerPresenter(view: viewController)
        let interactor = TimerInteractor(presenter: presenter)
        let router = TimerRouter(viewController: viewController)
        
        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
    
}
