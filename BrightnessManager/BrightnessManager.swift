//
//  BarcodeShowUpManager.swift
//  BrightnessManager
//
//  Created by LoganMacMini on 2024/3/3.
//

import UIKit

class BrightnessManager {
    
    /// execute handler from background to foreground
    var willEnterForegroundHandler: (() -> Void)?
    
    /// execute handler from foreground to background
    var willResignActiveHandler: (() -> Void)?
        
    init() {
        // set the screen brightness level from current setting
        UserDefaults.standard.setValue(UIScreen.main.brightness, forKey: UserDefaultsKeys.userSettingBrightness)
        
        addObserver()
    }
    
    /// set observer to listen willEnterForeground and willResignActive
    private func addObserver() {
        // listen to willEnterForeground
        NotificationCenter.default.addObserver(self, selector: #selector(willEnterForeground), name: UIApplication.willEnterForegroundNotification, object: nil)
        
        // listen to willResignActive
        NotificationCenter.default.addObserver(self, selector: #selector(willResignActive), name: UIApplication.willResignActiveNotification, object: nil)
    }
    
    func setWillEnterForeground(completion: @escaping () -> Void) {
        willEnterForegroundHandler = completion
    }
    
    @objc private func willEnterForeground() {
        willEnterForegroundHandler?()
        print("BarcodeShowUpManager willEnterForeground")
    }
    
    func setWillResignActive(completion: @escaping () -> Void) {
        willResignActiveHandler = completion
    }
    
    @objc private func willResignActive() {
        willResignActiveHandler?()
        print("BarcodeShowUpManager willResignActive")
    }
    
    func setBrightnessToMax() {
        UIScreen.main.brightness = 1.0
        print("Brightness set to maximum")
    }
    
    func setBrightnessToOriginal() {
        guard let userSettingBrightness = UserDefaults.standard.value(forKey: UserDefaultsKeys.userSettingBrightness) as? CGFloat else
        {
            print("Failed to get user setting brightness, setting to default value")
            UIScreen.main.brightness = 0.5 // default
            return
        }
        
        UIScreen.main.brightness = userSettingBrightness
        print("Brightness set to user setting brightness")
    }
    
    deinit {
        print("BarcodeShowUpManager deinit")
        willEnterForegroundHandler = nil
        willResignActiveHandler = nil
        NotificationCenter.default.removeObserver(self)
    }
}

struct UserDefaultsKeys {
    static let userSettingBrightness = "UserSettingBrightness"
}
