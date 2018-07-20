//
//  PreparingConfigurator.swift
//  Boxer Timer
//
//  Created by Admin on 18.07.2018.
//  Copyright © 2018 Марат Нургалиев. All rights reserved.
//

import Foundation

class PreparingConfigurator: PreparingConfiguratorProtocol {
    
    func configure(with viewController: PreparingViewController) {
        
        let presenter = PreparingPresenter(view: viewController)
        let interactor = PreparingInteractor(presenter: presenter)
        let router = PreparingRouter(viewController: viewController)
        
        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
    
}
