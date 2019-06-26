//
//  PinCodeViewController.swift
//  Clip
//
//  Created by Radomyr Sidenko on 13/06/2019.
//  Copyright © 2019 Radomyr Sidenko. All rights reserved.
//

import Cocoa

class PinCodeViewController: NSViewController {
  
    @IBOutlet private weak var infoText: NSTextField!
    @IBOutlet private weak var pinCodeEnter: NSSecureTextField!
    @IBOutlet weak var rightButton: NSButton!
    
    var pin: String?
    var isNewCode: Bool = false
    
    private var viewStoryboard: NSStoryboard {
        return NSStoryboard(name: "Main", bundle: nil)
    }
    private var passwordStoryboard: NSStoryboard {
        return NSStoryboard(name: "Password", bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pin = DataUserDefaults.instance.password
    }
    
    @IBAction private func sendInput(_ sender: NSTextField) {
        if isNewCode {
            setPassword(pinCodeEnter.stringValue)
        } else if sender.stringValue != pin {
            infoText.stringValue = "wrong password"
        } else {
            nextToPassWords()
        }
    }
    
   
    
    @IBAction private func passWord(_ sender: Any) {
        if isNewCode {
            setPassword(pinCodeEnter.stringValue)
        }
        nextToPassWords()
    }
    
    @IBAction func setPinCode(_ sender: Any) {
        infoText.stringValue = "Enter your password but all saves are removed"
        rightButton.stringValue = "OK"
        isNewCode = true
    }
    
    @IBAction func notesClick(_ sender: Any) {
        let vcStores = self.viewStoryboard.instantiateController(withIdentifier: NSStoryboard.SceneIdentifier("ViewController"))
            as! NSViewController
        self.view.window?.contentViewController = vcStores
    }
    

   
    private func nextToPassWords() {
        if pinCodeEnter.stringValue == pin {
            let vcStores = self.passwordStoryboard.instantiateController(withIdentifier: NSStoryboard.SceneIdentifier("PasswordViewController"))
                as! NSViewController
            self.view.window?.contentViewController = vcStores
        } else {
            infoText.stringValue = "wrong password"
        }
        
    }
    
    private func setPassword(_ password: String) {
        DataUserDefaults.instance.password = password
        infoText.stringValue = "Password successfully changed"
        pin = DataUserDefaults.instance.password
        isNewCode = false
    }
    
}

