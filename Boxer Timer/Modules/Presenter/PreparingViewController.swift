//
//  PreparingVC.swift
//  Boxer Timer
//
//  Created by Марат Нургалиев on 04.06.2018.
//  Copyright © 2018 Марат Нургалиев. All rights reserved.
//

import UIKit

class PreparingViewController: UIViewController {
    
    @IBOutlet weak var labelRoundTime: UILabel!
    @IBOutlet weak var labelPauseTime: UILabel!
    @IBOutlet weak var labelPrepareTime: UILabel!
    @IBOutlet weak var labelRoundCount: UILabel!
    @IBOutlet weak var labelAlertTime: UILabel!
    
    @IBOutlet weak var btnBox: UIButton!
    @IBOutlet weak var btnMma: UIButton!
    @IBOutlet weak var btnMy: UIButton!
    
    
    var presenter: PreparingPresenterProtocol!
    let configurator: PreparingConfiguratorProtocol = PreparingConfigurator()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(with: self)
        presenter.getSavedTimer()
        resizeButtonImages()
    }
    
    
    private func resizeButtonImages() {
        btnBox.imageView?.contentMode = .scaleAspectFit
        btnMma.imageView?.contentMode = .scaleAspectFit
        btnMy.imageView?.contentMode = .scaleAspectFit
    }
    
    
    @IBAction func btnRoundAddClicked(_ sender: Any) {
        presenter.btnRoundClicked(with: 5)
    }
    
    @IBAction func btnRoundRemoveClicked(_ sender: Any) {
        presenter.btnRoundClicked(with: -5)
    }
    
    
    @IBAction func btnPauseAddClicked(_ sender: Any) {
        presenter.btnPauseClicked(with: 5)
    }
    
    @IBAction func btnPauseRemoveClicked(_ sender: Any) {
        presenter.btnPauseClicked(with: -5)
    }
    
    
    @IBAction func btnPrepareAddClicked(_ sender: Any) {
        presenter.btnPrepareClicked(with: 5)
    }
    
    @IBAction func btnPrepareRemoveClicked(_ sender: Any) {
        presenter.btnPrepareClicked(with: -5)
    }
    
    
    @IBAction func btnCountAddClicked(_ sender: Any) {
        presenter.btnCountClicked(with: 1)
    }
    
    @IBAction func btnCountRemoveClicked(_ sender: Any) {
        presenter.btnCountClicked(with: -1)
    }
    
    
    @IBAction func btnAlertAddClicked(_ sender: Any) {
        presenter.btnAlertClicked(with: 5)
    }
    
    @IBAction func btnAlertRemoveClicked(_ sender: Any) {
        presenter.btnAlertClicked(with: -5)
    }
    
    
    @IBAction func btnStartClicked(_ sender: Any) {
        presenter.btnStartClicked()
    }
    
    
    @IBAction func btnSaveClicked(_ sender: Any) {
        presenter.saveTimer()
    }
    
    
    @IBAction func btnBoxClicked(_ sender: Any) {
        presenter.showBoxTimer()
    }
    
    @IBAction func btnMMAClicked(_ sender: Any) {
        presenter.showMmaTimer()
    }
    
    @IBAction func btnMyClicked(_ sender: Any) {
        presenter.getSavedTimer()
    }
    
    
    
    func setRound(time: String) {
        DispatchQueue.main.async {
            self.labelRoundTime.text = time
        }
    }
    
    func setPause(time:String) {
        DispatchQueue.main.async {
            self.labelPauseTime.text = time
        }
    }
    
    func setPrepare(time:String) {
        DispatchQueue.main.async {
             self.labelPrepareTime.text = time
        }
    }
    
    func setRound(count:String) {
        DispatchQueue.main.async {
             self.labelRoundCount.text = count
        }
    }
    
    func setAlert(time:String) {
        DispatchQueue.main.async {
             self.labelAlertTime.text = time
        }
    }
    
    
    
}

extension PreparingViewController: PreparingViewProtocol {}
