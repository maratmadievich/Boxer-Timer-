//
//  TimerInteractor.swift
//  Boxer Timer
//
//  Created by Admin on 20.07.2018.
//  Copyright © 2018 Марат Нургалиев. All rights reserved.
//

import UIKit
import Foundation
import AudioToolbox
import AVFoundation

class TimerInteractor: TimerInteractorProtocol {

    weak var presenter: TimerPresenterProtocol!
    
    let device = UIDevice.current
    
    private var roundTime   = GlobalConstants.roundTime
    private var pauseTime   = GlobalConstants.pauseTime
    private var prepareTime = GlobalConstants.prepareTime
    private var roundCount  = GlobalConstants.roundCount
    private var alertTime   = GlobalConstants.alertTime
    
    private var time = -1.0
    private var timer = Timer()
    
    private var isPrepare = true
    private var isRound = false
    private var isPause = false
    private var difference = 0
    private var localRoundCount = 0
    
    var isTimerStarted = false
    var isPlayerWork = true
    
    private var audioPlayerEnd = AVAudioPlayer()
    private var audioPlayerStart = AVAudioPlayer()
    private var audioPlayerPrepare = AVAudioPlayer()
    
    private let serialQueue = DispatchQueue(label: "serialAudio")
    
    private var soundID:SystemSoundID = 0
    

    required init(presenter: TimerPresenterProtocol) {
        self.presenter = presenter
    }
    
    
    func setAudioPlayer() {
        do {
            audioPlayerStart = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "gong", ofType: "wav")!))
            audioPlayerEnd = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "gong_end", ofType: "mp3")!))
            audioPlayerPrepare = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "prepare", ofType: "wav")!))
        } catch {
            isPlayerWork = false
        }
    }
    
    
    func setTimerBegining() {
        isPrepare = true
        isRound = false
        isPause = false
        timer.invalidate()
        localRoundCount = roundCount
        
        var text = "Подготовка"
        if (prepareTime > 0) {
            difference = prepareTime
        } else {
            difference = roundTime
            isPrepare = false
            isRound = true
            text = "Раунд \(roundCount - localRoundCount + 1)"
        }
        presenter.setStatus(text: text)
    }
    
    
    func getTime() -> String {
        var minutes = String(Int(difference / 60))
        var seconds = String(difference % 60)
        if minutes.count == 1 {
            minutes = "0" + minutes
        }
        if seconds.count == 1 {
            seconds = "0" + seconds
        }
        return minutes + ":" + seconds
    }
    
    
    func startTimer() {
        presenter.changeHiddenButtons(timerStarted: false)
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(TimerInteractor.checkDelays)), userInfo: nil, repeats: true)
        isTimerStarted = true
    }
    
    func pauseTimer() {
        presenter.changeHiddenButtons(timerStarted: true)
        timer.invalidate()
        isTimerStarted = false
    }
    
    func stopTimer() {
        presenter.changeHiddenButtons(timerStarted: true)
        setTimerBegining()
        presenter.showTime()
        isTimerStarted = false
    }
    
    func needExit() {
        if (isTimerStarted) {
            presenter.showExitAlert()
        } else {
            presenter.startExit()
        }
    }
    
    func proximitySensorActivated() {
        if (isTimerStarted) {
            presenter.changeHiddenButtons(timerStarted: true)
            timer.invalidate()
            isTimerStarted = false
        } else {
            presenter.changeHiddenButtons(timerStarted: false)
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(TimerInteractor.checkDelays)), userInfo: nil, repeats: true)
            isTimerStarted = true
        }
    }
    

    @objc func checkDelays() {
        difference -= 1
        if (difference >= 0) {
            if (isRound && difference == alertTime) {
                playPrepare()
            }
            if (difference == 0) {
                playSound(isRound: isRound)
            }
        } else {
            if (isPrepare) {
                isPrepare = false
                isRound = true
                difference = roundTime
                presenter.setStatus(text: "Раунд \(roundCount - localRoundCount + 1)/\(roundCount)")
            } else if (isRound) {
                localRoundCount -= 1
                if (localRoundCount == 0) {
                    presenter.showTime(text: "00:00")
                    timer.invalidate()
                    isTimerStarted = false
                    isRound = false
                    print ("Конец таймера")
                } else {
                    isRound = false
                    isPause = true
                    difference = pauseTime
                    presenter.setStatus(text: "Отдых \(roundCount - localRoundCount)/\(roundCount-1)")
                }
            } else if (isPause) {
                isPause = false
                isRound = true
                difference = roundTime
                presenter.setStatus(text: "Раунд \(roundCount - localRoundCount + 1)/\(roundCount)")
            }
        }
        if (isTimerStarted) {
            presenter.showTime()
        }
    }
    
    
    private func playSound(isRound: Bool) {
        serialQueue.async {
            if (isRound) {
                self.audioPlayerEnd.play()
            } else {
                sleep(1)
                self.audioPlayerStart.play()
            }
        }
        
        // Для воспроизведения системных звуков
        //        AudioServicesPlaySystemSound(soundID)
    }
    
    
    private func playPrepare() {
        serialQueue.async {
            self.audioPlayerPrepare.play()
        }
    }
    
    func activateProximitySensor() {
        device.isProximityMonitoringEnabled = true
        if device.isProximityMonitoringEnabled {
            NotificationCenter.default.addObserver(self, selector: #selector (TimerInteractor.proximityChanged (_:)), name: NSNotification.Name(rawValue: "UIDeviceProximityStateDidChangeNotification"), object: device)
        }
    }
    
    
    func deactivateProximitySensor() {
        device.isProximityMonitoringEnabled = false
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "UIDeviceProximityStateDidChangeNotification"), object: device)
    }
    
    
    @objc func proximityChanged(_ notification: NSNotification) {
        if let device = notification.object as? UIDevice {
            if (device.proximityState) {
                proximitySensorActivated()
            }
        }
    }
    
}
