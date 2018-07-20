//
//  PreparingProtocol.swift
//  Boxer Timer
//
//  Created by Admin on 18.07.2018.
//  Copyright © 2018 Марат Нургалиев. All rights reserved.
//

import Foundation

protocol PreparingViewProtocol: class {
    
    func setRound(time: String)
    func setPause(time:String)
    func setPrepare(time:String)
    func setRound(count:String)
    func setAlert(time:String)
    func showInfoView()
}

protocol PreparingPresenterProtocol: class {
    var router: PreparingRouterProtocol! { set get }
    
    // Мои функции
    func getSavedTimer()
    func saveTimer()
    
    func showBoxTimer()
    func showMmaTimer()
    func showInfoView()
    
    func btnRoundClicked(with time: Int)
    func btnPauseClicked(with time: Int)
    func btnPrepareClicked(with time: Int)
    func btnCountClicked(with count: Int)
    func btnAlertClicked(with time: Int)
    
    func showRound(time:String)
    func showPause(time:String)
    func showPrepare(time:String)
    func showRound(count:String)
    func showAlert(time:String)
    
    func btnStartClicked()
}

protocol PreparingInteractorProtocol: class {
    
    func getSavedTimer()
    func saveTimer()
    
    func showBoxTimer()
    func showMmaTimer()
    
    func updateRoundTime(with value: Int)
    func updatePauseTime(with value: Int)
    func updatePrepareTime(with value: Int)
    func updateRoundCount(with value: Int)
    func updateAlertTime(with value: Int)
    
    func returnRoundTime() -> String
    func returnPauseTime() -> String
    func returnPrepareTime() -> String
    func returnRoundCount() -> String
    func returnAlertTime() -> String
}

protocol PreparingRouterProtocol: class {
    func showTimerController()
}

protocol PreparingConfiguratorProtocol: class {
    func configure(with viewController: PreparingViewController)
}
