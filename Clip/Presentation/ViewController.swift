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
    
    @IBOutlet weak var tableView: NSTableView!
    @IBOutlet weak var table: NSScrollView!
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
        scrollableContentTextView.isHidden = !scrollableContentTextView.isHidden
        table.isHidden = !table.isHidden
    }
    
    let makes = ["Ford", "Subaru", "Ford", "Toyota", "Chevy", "Subaru", "Ford"]
    let models = ["Mustang", "Forester", "Bronco", "Tacoma", "Blazer", "Outback", "Ranger"]
    let years = [2018, 2011, 1977, 1994, 1991, 2001, 1998]
}

extension ViewController: NSTableViewDataSource {
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return makes.count
    }
}
extension ViewController: NSTableViewDelegate {
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        
        guard let column = tableColumn else { return nil }
        
        if let cell = tableView.makeView(withIdentifier: column.identifier, owner: nil) as? NSTableCellView {
            
            if column.identifier.rawValue == "MakeColumn" {
                cell.textField?.stringValue = makes[row]
                return cell
            }
            
            if column.identifier.rawValue == "ModelColumn" {
                cell.textField?.stringValue = models[row]
                return cell
            }
            
            if column.identifier.rawValue == "YearColumn" {
                cell.textField?.stringValue = "\(years[row])"
                return cell
            }
            
        }
        
        return nil
    }
}


