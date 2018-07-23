//
//  PreparingInteractor.swift
//  Boxer Timer
//
//  Created by Admin on 18.07.2018.
//  Copyright © 2018 Марат Нургалиев. All rights reserved.
//

import UIKit
import Foundation

class PreparingInteractor: PreparingInteractorProtocol {
    
    
    weak var presenter: PreparingPresenterProtocol!
    
    let storageService: StorageServiceProtocol = StorageService()
    
    let device = UIDevice.current
    
    
    required init(presenter: PreparingPresenterProtocol) {
        self.presenter = presenter
    }
    
    
    
    
    
    func getSavedTimer() {
        storageService.getStorageTimer()
        showAllValues()
    }
    
    func saveTimer() {
        storageService.setStorageTimer()
        presenter.showInfoView()
    }
    
    private func showAllValues() {
        presenter.showRound(time: returnRoundTime())
        presenter.showPause(time: returnPauseTime())
        presenter.showPrepare(time: returnPrepareTime())
        presenter.showRound(count: returnRoundCount())
        presenter.showAlert(time: returnAlertTime())
    }
    
    
    func showBoxTimer() {
        GlobalConstants.roundTime = 180
        GlobalConstants.pauseTime = 60
        GlobalConstants.prepareTime = 30
        GlobalConstants.roundCount = 12
        GlobalConstants.alertTime = 60
        showAllValues()
    }
    
    func showMmaTimer() {
        GlobalConstants.roundTime = 300
        GlobalConstants.pauseTime = 60
        GlobalConstants.prepareTime = 30
        GlobalConstants.roundCount = 5
        GlobalConstants.alertTime = 10
        showAllValues()
    }
    
    
    func updateRoundTime(with value: Int) {
        GlobalConstants.roundTime += value
        if (GlobalConstants.roundTime < 10) {
            GlobalConstants.roundTime -= value
        }
        presenter.showRound(time: returnRoundTime())
    }
    
    func updatePauseTime(with value: Int) {
        GlobalConstants.pauseTime += value
        if (GlobalConstants.pauseTime < 10) {
            GlobalConstants.pauseTime -= value
        }
        presenter.showPause(time: returnPauseTime())
    }
    
    func updatePrepareTime(with value: Int) {
        GlobalConstants.prepareTime += value
        if (GlobalConstants.prepareTime < 10) {
            GlobalConstants.prepareTime -= value
        }
        presenter.showPrepare(time: returnPrepareTime())
    }
    
    func updateRoundCount(with value: Int) {
        GlobalConstants.roundCount += value
        if (GlobalConstants.roundCount < 2) {
            GlobalConstants.roundCount -= value
        }
        presenter.showRound(count: returnRoundCount())
    }
    
    func updateAlertTime(with value: Int) {
        GlobalConstants.alertTime += value
        if (GlobalConstants.alertTime < 10) {
            GlobalConstants.alertTime -= value
        }
        presenter.showAlert(time: returnAlertTime())
    }
    
    
    func returnRoundTime() -> String {
        return getTimeValue(from: GlobalConstants.roundTime)
    }
    
    func returnPauseTime() -> String {
        return getTimeValue(from: GlobalConstants.pauseTime)
    }
    
    func returnPrepareTime() -> String {
        return getTimeValue(from: GlobalConstants.prepareTime)
    }
    
    func returnRoundCount() -> String {
        return String(GlobalConstants.roundCount)
    }
    
    func returnAlertTime() -> String {
        return getTimeValue(from: GlobalConstants.alertTime)
    }
    
    
    private func getTimeValue(from: Int) -> String {
        var minutes = String(Int(from / 60))
        var seconds = String(from % 60)
        if minutes.count == 1 {
            minutes = "0" + minutes
        }
        if seconds.count == 1 {
            seconds = "0" + seconds
        }
        return minutes + ":" + seconds
    }
    
    
    func deactivateProximitySensor() {
        device.isProximityMonitoringEnabled = false
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "UIDeviceProximityStateDidChangeNotification"), object: device)
    }
    
}
