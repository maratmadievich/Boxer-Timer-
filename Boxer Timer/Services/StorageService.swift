//
//  StorageService.swift
//  Boxer Timer
//
//  Created by Admin on 18.07.2018.
//  Copyright © 2018 Марат Нургалиев. All rights reserved.
//

import Foundation
import Foundation
import UIKit // for UIApplication

protocol StorageServiceProtocol: class {
    
    func getStorageTimer()
    func setStorageTimer()
}

class StorageService: StorageServiceProtocol {
    
    let defaults = UserDefaults.standard
    
    
    func getStorageTimer() {
        
        if let _roundTime = defaults.string(forKey: TimerKeys.roundTime) {
            GlobalConstants.roundTime = Int(_roundTime)!
        } else {
            defaults.setValue("\(GlobalConstants.roundTime)", forKey: TimerKeys.roundTime)
        }
        
        if let _pauseTime = defaults.string(forKey: TimerKeys.pauseTime) {
            GlobalConstants.pauseTime = Int(_pauseTime)!
        } else {
            defaults.setValue("\(GlobalConstants.pauseTime)", forKey: TimerKeys.pauseTime)
        }
        
        if let _prepareTime = defaults.string(forKey: TimerKeys.prepareTime) {
            GlobalConstants.prepareTime = Int(_prepareTime)!
        } else {
            defaults.setValue("\(GlobalConstants.prepareTime)", forKey: TimerKeys.prepareTime)
        }
        
        if let _roundCount = defaults.string(forKey: TimerKeys.roundCount) {
            GlobalConstants.roundCount = Int(_roundCount)!
        } else {
            defaults.setValue("\(GlobalConstants.roundCount)", forKey: TimerKeys.roundCount)
        }
        
        if let _alertTime = defaults.string(forKey: TimerKeys.alertTime) {
            GlobalConstants.alertTime = Int(_alertTime)!
        } else {
            defaults.setValue("\(GlobalConstants.alertTime)", forKey: TimerKeys.alertTime)
        }
    }
    
    
    func setStorageTimer() {
        defaults.setValue("\(GlobalConstants.roundTime)", forKey: TimerKeys.roundTime)
        defaults.setValue("\(GlobalConstants.pauseTime)", forKey: TimerKeys.pauseTime)
        defaults.setValue("\(GlobalConstants.prepareTime)", forKey: TimerKeys.prepareTime)
        defaults.setValue("\(GlobalConstants.roundCount)", forKey: TimerKeys.roundCount)
        defaults.setValue("\(GlobalConstants.alertTime)", forKey: TimerKeys.alertTime)
    }
    
    
    
    
}
