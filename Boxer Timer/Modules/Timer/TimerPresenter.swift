//
//  TimerPresenter.swift
//  Boxer Timer
//
//  Created by Admin on 20.07.2018.
//  Copyright © 2018 Марат Нургалиев. All rights reserved.
//

import Foundation

class TimerPresenter: TimerPresenterProtocol {
    
    weak var view: TimerViewProtocol!
    
    var interactor: TimerInteractorProtocol!
    var router: TimerRouterProtocol!
    
    
    required init(view: TimerViewProtocol) {
        self.view = view
    }
    
    
    func setAudioPlayer() {
        interactor.setAudioPlayer()
    }
    
    func setTimerBegining() {
        interactor.setTimerBegining()
    }
    
    
    func btnStartClicked() {
        interactor.startTimer()
    }
    
    func btnPauseClicked() {
        interactor.pauseTimer()
    }
    
    func btnStopClicked() {
        interactor.stopTimer()
    }
    
    func btnExitClicked() {
        interactor.needExit()
    }
    
    func changeHiddenButtons(timerStarted: Bool) {
        view.changeHiddenButtons(timerStarted: timerStarted)
    }
    
    func activateProximitySensor() {
        interactor.activateProximitySensor()
    }
    
    func deactivateProximitySensor() {
        interactor.deactivateProximitySensor()
    }
    
    
    func setStatus(text: String) {
        view.setStatus(text: text)
    }
    
    func showTime() {
        view.setTime(text: interactor.getTime())
    }
    
    func showTime(text: String) {
        view.setTime(text: text)
    }
    
    
    func startExit() {
        router.goBack()
    }
    
    func showExitAlert() {
        view.showExitAlert()
    }
    
}
