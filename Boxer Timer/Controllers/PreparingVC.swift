//
//  PreparingVC.swift
//  Boxer Timer
//
//  Created by Марат Нургалиев on 04.06.2018.
//  Copyright © 2018 Марат Нургалиев. All rights reserved.
//

import UIKit

class PreparingVC: UIViewController {
    
    @IBOutlet weak var labelRoundTime: UILabel!
    @IBOutlet weak var labelPauseTime: UILabel!
    @IBOutlet weak var labelPrepareTime: UILabel!
    @IBOutlet weak var labelRoundCount: UILabel!
    @IBOutlet weak var labelAlertTime: UILabel!
    
    var roundTime = 180
    var pauseTime = 60
    var prepareTime = 15
    var roundCount = 12
    var alertTime = 10
    
    let valueRoundTime = 1
    let valuePauseTime = 2
    let valuePrepareTime = 3
    let valueRoundCount = 4
    let valueAlertTime = 5

    override func viewDidLoad() {
        super.viewDidLoad()
        preparingTimers()
    }
    
    
    private func preparingTimers() {
        var i = 1
        while (i < 6) {
            showValues(type: i)
            i+=1
        }
    }
    
    @IBAction func btnRoundAddClicked(_ sender: Any) {
        changeValue(type: valueRoundTime, isAdd: true)
    }
    
    @IBAction func btnRoundRemoveClicked(_ sender: Any) {
        changeValue(type: valueRoundTime, isAdd: false)
    }
    
    
    @IBAction func btnPauseAddClicked(_ sender: Any) {
        changeValue(type: valuePauseTime, isAdd: true)
    }
    
    @IBAction func btnPauseRemoveClicked(_ sender: Any) {
        changeValue(type: valuePauseTime, isAdd: false)
    }
    
    
    @IBAction func btnPrepareAddClicked(_ sender: Any) {
        changeValue(type: valuePrepareTime, isAdd: true)
    }
    
    @IBAction func btnPrepareRemoveClicked(_ sender: Any) {
        changeValue(type: valuePrepareTime, isAdd: false)
    }
    
    
    @IBAction func btnCountAddClicked(_ sender: Any) {
        changeValue(type: valueRoundCount, isAdd: true)
    }
    
    @IBAction func btnCountRemoveClicked(_ sender: Any) {
        changeValue(type: valueRoundCount, isAdd: false)
    }
    
    
    @IBAction func btnAlertAddClicked(_ sender: Any) {
        changeValue(type: valueAlertTime, isAdd: true)
    }
    
    @IBAction func btnAlertRemoveClicked(_ sender: Any) {
        changeValue(type: valueAlertTime, isAdd: false)
    }
    
    
    @IBAction func btnStartClicked(_ sender: Any) {
        performSegue(withIdentifier: "showTimer", sender: nil)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "showTimer") {
            
                let vc = segue.destination as! TimerVC
            vc.setTimeValues(roundTime: roundTime,
                             pauseTime: pauseTime,
                             prepareTime: prepareTime,
                             roundCount: roundCount,
                             alertTime: alertTime)
            
        }
        
        let backItem = UIBarButtonItem()
        backItem.title = ""//Назад
        backItem.tintColor = UIColor.white
        navigationItem.backBarButtonItem = backItem
    }
    
    
    func changeValue(type: Int, isAdd: Bool) {
        switch type {
        case valueRoundTime:
            if (isAdd) {
                roundTime += 5
            } else {
                if (roundTime > 10) {
                    roundTime -= 5
                } else {
                    //alert
                }
            }
            break
            
            case valuePauseTime:
                if (isAdd) {
                    pauseTime += 5
                } else {
                    if (pauseTime > 10) {
                        pauseTime -= 5
                    } else {
                        //alert
                    }
                }
            break
            case valuePrepareTime:
                if (isAdd) {
                    prepareTime += 5
                } else {
                    if (prepareTime > 10) {
                        prepareTime -= 5
                    } else {
                        //alert
                    }
                }
            break
            case valueRoundCount:
                if (isAdd) {
                    roundCount += 1
                } else {
                    if (roundCount > 2) {
                        roundCount -= 1
                    } else {
                        //alert
                    }
                }
            break
            case valueAlertTime:
                if (isAdd) {
                    alertTime += 5
                } else {
                    if (alertTime > 10) {
                        alertTime -= 5
                    } else {
                        //alert
                    }
                }
            break
            
        default:
            break
        }
        showValues(type: type)
    }
    
    
    func showValues(type: Int) {
        switch type {
        case valueRoundTime:
            var minutes = String(Int(roundTime / 60))
            var seconds = String(roundTime % 60)
            if minutes.count == 1 {
                minutes = "0" + minutes
            }
            if seconds.count == 1 {
                seconds = "0" + seconds
            }
            labelRoundTime.text = minutes + ":" + seconds
            break
            
        case valuePauseTime:
            var minutes = String(Int(pauseTime / 60))
            var seconds = String(pauseTime % 60)
            if minutes.count == 1 {
                minutes = "0" + minutes
            }
            if seconds.count == 1 {
                seconds = "0" + seconds
            }
            labelPauseTime.text = minutes + ":" + seconds
            break
        case valuePrepareTime:
            var minutes = String(Int(prepareTime / 60))
            var seconds = String(prepareTime % 60)
            if minutes.count == 1 {
                minutes = "0" + minutes
            }
            if seconds.count == 1 {
                seconds = "0" + seconds
            }
            labelPrepareTime.text = minutes + ":" + seconds
            break
        case valueRoundCount:
            labelRoundCount.text = String(roundCount)
            break
        case valueAlertTime:
            var minutes = String(Int(alertTime / 60))
            var seconds = String(alertTime % 60)
            if minutes.count == 1 {
                minutes = "0" + minutes
            }
            if seconds.count == 1 {
                seconds = "0" + seconds
            }
            labelAlertTime.text = minutes + ":" + seconds
            break
            
        default:
            break
        }
    }
    
    
    @IBAction func btnBoxClicked(_ sender: Any) {
        roundTime = 180
        pauseTime = 60
        prepareTime = 30
        roundCount = 12
        alertTime = 60
        preparingTimers()
    }
    
    
    @IBAction func btnMMAClicked(_ sender: Any) {
        roundTime = 300
        pauseTime = 60
        prepareTime = 30
        roundCount = 5
        alertTime = 10
        preparingTimers()
    }
    
    
    @IBAction func btnCrossfitClicked(_ sender: Any) {
        roundTime = 90
        pauseTime = 30
        prepareTime = 10
        roundCount = 10
        alertTime = 10
        preparingTimers()
    }
    
}
