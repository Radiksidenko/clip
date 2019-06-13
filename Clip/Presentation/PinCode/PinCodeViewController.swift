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
    private var pin = "42"
    
    @IBAction private func sendInput(_ sender: NSTextField) {
        print(sender.stringValue)
        if sender.stringValue != pin {
            infoText.stringValue = "wrong password"
        } else {
            nextToPassWords()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction private func passWord(_ sender: Any) {
        nextToPassWords()
    }
    
    @IBAction func notesClick(_ sender: Any) {
        let vcStores = self.viewStoryboard.instantiateController(withIdentifier: NSStoryboard.SceneIdentifier("ViewController"))
            as! NSViewController
        self.view.window?.contentViewController = vcStores
    }
    private var viewStoryboard: NSStoryboard {
        return NSStoryboard(name: "Main", bundle: nil)
    }
    
    private var passwordStoryboard: NSStoryboard {
        return NSStoryboard(name: "Password", bundle: nil)
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
    
}

