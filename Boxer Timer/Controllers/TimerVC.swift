//
//  TimerVC.swift
//  Boxer Timer
//
//  Created by Марат Нургалиев on 04.06.2018.
//  Copyright © 2018 Марат Нургалиев. All rights reserved.
//

import UIKit
import AudioToolbox
import AVFoundation

class TimerVC: UIViewController {

    @IBOutlet weak var labelStatus: UILabel!
    @IBOutlet weak var labelTimer: UILabel!
    @IBOutlet weak var btnStart: UIButton!
    @IBOutlet weak var btnPause: UIButton!
    @IBOutlet weak var btnStop: UIButton!
    
    
    private var roundTime = 0
    private var pauseTime = 0
    private var prepareTime = 0
    private var roundCount = 0
    private var alertTime = 0
    
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activateProximitySensor()
        setAudioPlayer()
        setTimerBegining()
        countTime()
        //Не используется, тк audioPlayer тупо громче
//        prepareAudio()
    }
    
    
//    private func prepareAudio () {
//        let filePath = Bundle.main.path(forResource: "gong", ofType: "mp3")
//        let soundUrl = NSURL(fileURLWithPath: filePath!)
//        AudioServicesCreateSystemSoundID(soundUrl, &soundID)
//    }
    
    private func setAudioPlayer() {
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
        if (prepareTime > 0) {
            difference = prepareTime
            labelStatus.text = "Подготовка"
        } else {
            difference = roundTime
            isPrepare = false
            isRound = true
            labelStatus.text = "Раунд \(roundCount - localRoundCount + 1)"
        }
    }


    @IBAction func btnStartClicked(_ sender: Any) {
        changeHiddenButtons(timerStarted: false)
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(TimerVC.checkDelays)), userInfo: nil, repeats: true)
        isTimerStarted = true
        
    }
    
    
    @IBAction func btnPauseClicked(_ sender: Any) {
        changeHiddenButtons(timerStarted: true)
        timer.invalidate()
        isTimerStarted = false
    }
    
    
    @IBAction func btnStopClicked(_ sender: Any) {
        changeHiddenButtons(timerStarted: true)
        setTimerBegining()
        countTime()
        isTimerStarted = false
    }
    
    
    private func changeHiddenButtons(timerStarted: Bool) {
        btnStart.isHidden = !timerStarted
        btnStop.isHidden = timerStarted
        btnPause.isHidden = timerStarted
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
                labelStatus.text = "Раунд \(roundCount - localRoundCount + 1)/\(roundCount)"
                print ("Раунд \(roundCount - localRoundCount + 1)")
            } else if (isRound) {
                localRoundCount -= 1
                if (localRoundCount == 0) {
                    labelTimer.text = "00:00"
                    timer.invalidate()
                    isTimerStarted = false
                    isRound = false
                    print ("Конец таймера")
                } else {
                    isRound = false
                    isPause = true
                    difference = pauseTime
                    labelStatus.text = "Отдых \(roundCount - localRoundCount)/\(roundCount-1)"
                    print ("Отдых \(roundCount - localRoundCount)")
                }
            } else if (isPause) {
                isPause = false
                isRound = true
                difference = roundTime
                labelStatus.text = "Раунд \(roundCount - localRoundCount + 1)/\(roundCount)"
                 print ("Раунд \(roundCount - localRoundCount + 1)")
            }
        }
         countTime()
    }
    
    
    private func playSound(isRound: Bool) {
        // Для воспроизведения системных звуков
//        AudioServicesPlaySystemSound(soundID)
        serialQueue.async {
            if (isRound) {
                self.audioPlayerEnd.play()
            } else {
                sleep(1)
                self.audioPlayerStart.play()
            }
        }
    }
    
    
    private func playPrepare() {
        serialQueue.async {
            self.audioPlayerPrepare.play()
        }
    }
    
    
    func countTime() {
        var minutes = String(Int(difference / 60))
        var seconds = String(difference % 60)
        if minutes.count == 1 {
            minutes = "0" + minutes
        }
        if seconds.count == 1 {
            seconds = "0" + seconds
        }
        labelTimer.text = minutes + ":" + seconds
    }
    
    
    @IBAction func btnExitClicked(_ sender: Any) {
        if (isTimerStarted) {
            let alert = UIAlertController(title: "Вы действительно хотите закончить тренировку?", message: "", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Выйти", style: .default, handler: { action in
                self.stopTimer()
                _ = self.navigationController?.popViewController(animated: true)
               }))
            alert.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        } else {
            _ = navigationController?.popViewController(animated: true)
        }
    }
    
    
    func setTimeValues (roundTime: Int, pauseTime: Int,
                        prepareTime: Int, roundCount: Int,
                        alertTime: Int) {
        self.roundTime = roundTime
        self.pauseTime = pauseTime
        self.prepareTime = prepareTime
        self.roundCount = roundCount
        self.alertTime = alertTime
    }
    
    
    func stopTimer() {
        self.timer.invalidate()
        self.isTimerStarted = false
    }
    
    
    private func activateProximitySensor() {
        let device = UIDevice.current
        device.isProximityMonitoringEnabled = true
        if device.isProximityMonitoringEnabled {
            NotificationCenter.default.addObserver(self, selector: #selector (self.proximityChanged (_:)), name: NSNotification.Name(rawValue: "UIDeviceProximityStateDidChangeNotification"), object: device)
        }
    }
    
    @objc func proximityChanged(_ notification: NSNotification) {
        if let device = notification.object as? UIDevice {
            if (device.proximityState) {
                changeTimerStatus()
            }
        }
    }
    
    
    private func changeTimerStatus() {
        if (isTimerStarted) {
            changeHiddenButtons(timerStarted: true)
            timer.invalidate()
            isTimerStarted = false
        } else {
            changeHiddenButtons(timerStarted: false)
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(TimerVC.checkDelays)), userInfo: nil, repeats: true)
            isTimerStarted = true
        }
    }
    
    

}
