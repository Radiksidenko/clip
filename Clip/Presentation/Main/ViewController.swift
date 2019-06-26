//
//  ViewController.swift
//  Clip
//
//  Created by Radomyr Sidenko on 31/05/2019.
//  Copyright © 2019 Radomyr Sidenko. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    
    // MARK: - Outlets
    
    @IBOutlet private weak var clipboardButton: NSButton!
    @IBOutlet private weak var copyClipboardButton: NSButton!
    @IBOutlet private weak var scrollableContentTextView: NSScrollView!
    
    
    @IBOutlet weak var passwordButton: NSButton!
    
    // MARK: - Properties
    
    private lazy var contentTextView: NSTextView = {
        return scrollableContentTextView.documentView as! NSTextView
    }()
    
    private var clipboard: String {
        return NSPasteboard.general.string(forType: .string) ?? ""
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupClipboardButton()
        setupTextViews()
    }
    
    // MARK: - Setup
    
    private func setupClipboardButton() {
        clipboardButton.title = clipboard.isEmpty ? "Clipboard is Empty" : "Show Clipboard"
        clipboardButton.isEnabled = !clipboard.isEmpty
        copyClipboardButton.title = "copy?"
        passwordButton.title = "Passwords"
    }
    
    private func setupTextViews() {
        contentTextView.font = NSFont.systemFont(ofSize: 14)
        contentTextView.isContinuousSpellCheckingEnabled = true
    }
    
    // MARK: - Actions
    
    @IBAction private func clipboardButtonTapped(_ sender: NSButton) {
        if !clipboard.isEmpty {
            contentTextView.string += "\n" + clipboard
        }
    }
    
    @IBAction func copyToClipboard(_ sender: Any) {
        if !contentTextView.string.isEmpty {
            copyClipboardButton.title = "copied"
            let pasteboard = NSPasteboard.general
            pasteboard.declareTypes([NSPasteboard.PasteboardType.string], owner: nil)
            pasteboard.setString(contentTextView.string, forType: NSPasteboard.PasteboardType.string)
        }
    }
    
    @IBAction func passWord(_ sender: Any) {
        let vcStores = self.pinCodeStoryboard.instantiateController(withIdentifier: NSStoryboard.SceneIdentifier("PinCodeViewController"))
            as! NSViewController
        self.view.window?.contentViewController = vcStores
    }
    
    private var pinCodeStoryboard: NSStoryboard {
        return NSStoryboard(name: "PinCode", bundle: nil)
    }
}
