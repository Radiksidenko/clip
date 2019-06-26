//
//  LoginCellView.swift
//  Clip
//
//  Created by Radomyr Sidenko on 01/06/2019.
//  Copyright © 2019 Radomyr Sidenko. All rights reserved.
//

import Foundation
import Cocoa

class LoginCellView: NSTableCellView {
    
    @IBOutlet weak var text: NSTextField!
    var password: Bool {
        get {
            return false
        }
        set {
            text.drawsBackground = true
            text.backgroundColor = .black
        }
    }
    @IBAction func copy(_ sender: Any) {
        let pasteboard = NSPasteboard.general
        pasteboard.declareTypes([NSPasteboard.PasteboardType.string], owner: nil)
        pasteboard.setString(text.stringValue, forType: NSPasteboard.PasteboardType.string)
        print(text.stringValue)
    }
}
