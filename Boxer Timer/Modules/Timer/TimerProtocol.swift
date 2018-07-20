//
//  TimerProtocol.swift
//  Boxer Timer
//
//  Created by Admin on 20.07.2018.
//  Copyright © 2018 Марат Нургалиев. All rights reserved.
//

import Foundation

protocol TimerViewProtocol: class {
    
    func showExitAlert()
    
    func setStatus(text: String)
    func setTime(text: String)
    
    func changeHiddenButtons(timerStarted: Bool)
}

protocol TimerPresenterProtocol: class {
    var router: TimerRouterProtocol! { set get }
    
    // Мои функции
    func setAudioPlayer()
    func setTimerBegining()
    
    func showTime()
    func showTime(text: String)
    func setStatus(text: String)
    
    func btnStartClicked()
    func btnPauseClicked()
    func btnStopClicked()
    func btnExitClicked()
    
    func changeHiddenButtons(timerStarted: Bool)
    func activateProximitySensor()
    func deactivateProximitySensor()
    
    func startExit()
    func showExitAlert()
    
}

protocol TimerInteractorProtocol: class {
    
    func setAudioPlayer()
    func setTimerBegining()
    func getTime() -> String

    func startTimer()
    func pauseTimer()
    func stopTimer()
    
    func activateProximitySensor()
    func deactivateProximitySensor()
    
    func needExit()
}

protocol TimerRouterProtocol: class {
    func goBack()
}

protocol TimerConfiguratorProtocol: class {
    func configure(with viewController: TimerViewController)
}
