//
//  TimerVC.swift
//  Boxer Timer
//
//  Created by Марат Нургалиев on 04.06.2018.
//  Copyright © 2018 Марат Нургалиев. All rights reserved.
//

import UIKit

class TimerViewController: UIViewController {

    @IBOutlet weak var labelStatus: UILabel!
    @IBOutlet weak var labelTimer: UILabel!
    @IBOutlet weak var btnStart: UIButton!
    @IBOutlet weak var btnPause: UIButton!
    @IBOutlet weak var btnStop: UIButton!
    
    
    var presenter: TimerPresenterProtocol!
    let configurator: TimerConfiguratorProtocol = TimerConfigurator()
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        presenter.activateProximitySensor()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        presenter.deactivateProximitySensor()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configurator.configure(with: self)
        presenter.setAudioPlayer()
        presenter.setTimerBegining()
        presenter.showTime()
    }


    @IBAction func btnStartClicked(_ sender: Any) {
        presenter.btnStartClicked()
    }
    
    @IBAction func btnPauseClicked(_ sender: Any) {
        presenter.btnPauseClicked()
    }
    
    @IBAction func btnStopClicked(_ sender: Any) {
        presenter.btnStopClicked()
    }
    
    @IBAction func btnExitClicked(_ sender: Any) {
        presenter.btnExitClicked()
    }
    
    
    func setStatus(text: String) {
        DispatchQueue.main.async {
            self.labelStatus.text = text
        }
    }
    
    func setTime(text: String) {
        DispatchQueue.main.async {
            self.labelTimer.text = text
        }
    }
    
    func changeHiddenButtons(timerStarted: Bool) {
        btnStart.isHidden = !timerStarted
        btnStop.isHidden = timerStarted
        btnPause.isHidden = timerStarted
    }
    
    
    func showExitAlert() {
        let alert = UIAlertController(title: "Вы действительно хотите закончить тренировку?", message: "", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Выйти", style: .default, handler: { action in
            self.presenter.btnStopClicked()
            _ = self.navigationController?.popViewController(animated: true)
        }))
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    //Не используется, тк audioPlayer тупо громче
    //        prepareAudio()
    
    //    private func prepareAudio () {
    //        let filePath = Bundle.main.path(forResource: "gong", ofType: "mp3")
    //        let soundUrl = NSURL(fileURLWithPath: filePath!)
    //        AudioServicesCreateSystemSoundID(soundUrl, &soundID)
    //    }
    

}

extension TimerViewController: TimerViewProtocol {}
