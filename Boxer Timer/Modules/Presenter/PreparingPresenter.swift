//
//  PreparingPresenter.swift
//  Boxer Timer
//
//  Created by Admin on 18.07.2018.
//  Copyright © 2018 Марат Нургалиев. All rights reserved.
//

import Foundation

class PreparingPresenter: PreparingPresenterProtocol {
    
    weak var view: PreparingViewProtocol!
    
    var interactor: PreparingInteractorProtocol!
    var router: PreparingRouterProtocol!
    
    
    required init(view: PreparingViewProtocol) {
        self.view = view
    }
    
    
    
    
    
    func getSavedTimer() {
        interactor.getSavedTimer()
    }
    
    func saveTimer() {
        interactor.saveTimer()
    }
    
    
    func showBoxTimer() {
        interactor.showBoxTimer()
    }
    
    func showMmaTimer() {
        interactor.showMmaTimer()
    }
    
    
    func btnRoundClicked(with time: Int) {
        interactor.updateRoundTime(with: time)
    }
    
    func btnPauseClicked(with time: Int) {
        interactor.updatePauseTime(with: time)
    }
    
    func btnPrepareClicked(with time: Int) {
        interactor.updatePrepareTime(with: time)
    }
    
    func btnCountClicked(with count: Int) {
        interactor.updateRoundCount(with: count)
    }
    
    func btnAlertClicked(with time: Int) {
        interactor.updateAlertTime(with: time)
    }
    
    
    func showRound(time: String) {
        view.setRound(time: time)
    }
    
    func showPause(time: String) {
        view.setPause(time: time)
    }
    
    func showPrepare(time: String) {
        view.setPrepare(time: time)
    }
    
    func showRound(count: String) {
        view.setRound(count: count)
    }
    
    func showAlert(time: String) {
        view.setAlert(time: time)
    }
    
    
    func btnStartClicked() {
        router.showTimerController()
    }

}
