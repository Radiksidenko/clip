//
//  PasswordViewController.swift
//  Clip
//
//  Created by Radomyr Sidenko on 01/06/2019.
//  Copyright © 2019 Radomyr Sidenko. All rights reserved.
//

import Foundation
import Cocoa

class PasswordViewController: NSViewController {
    @IBOutlet weak var notes: NSButton!
    @IBOutlet weak var tableView: NSTableView!
    @IBOutlet weak var addLogin: NSTextField!
    @IBOutlet weak var addPassword: NSSecureTextField!
    @IBOutlet weak var addSite: NSTextField!
    
    let heightOfRow: CGFloat = 30
    let defaults = DataUserDefaults.instance
    
    private var viewStoryboard: NSStoryboard {
        return NSStoryboard(name: "Main", bundle: nil)
    }
    
    var allPassword: [Password] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        defaults.lastVC = ["PasswordViewController": "Password"]
        
        notes.title = "Notes"
        reloadData()
        tableView.register(NSNib(nibNamed: "LoginCell", bundle: nil),
                           forIdentifier: NSUserInterfaceItemIdentifier(rawValue: "LoginCellView"))
        tableView.doubleAction = #selector(tableViewDoubleClick(_:))
    }
    
    private func reloadData() {
        allPassword = defaults.getUserPasswords()
        tableView.reloadData()
    }
    
    @IBAction func notesClick(_ sender: Any) {
        let sceneIdentifier =  NSStoryboard.SceneIdentifier("ViewController")
        let vcStores = self.viewStoryboard.instantiateController(withIdentifier: sceneIdentifier) as! NSViewController
        self.view.window?.contentViewController = vcStores
    }

    @IBAction func addRow(_ sender: Any) {
        if addLogin.isHidden == false {
            let newRow =  Password(login: addLogin.stringValue,
                                   password: addPassword.stringValue,
                                   site: addSite.stringValue)
            defaults.addNewPass(newRow)
            reloadData()
        }
        
        addLogin.isHidden = !addLogin.isHidden
        addPassword.isHidden = !addPassword.isHidden
        addSite.isHidden = !addSite.isHidden
    }
    
    @objc func tableViewDoubleClick(_ sender:AnyObject) {
        print(tableView.selectedRow, "🧿")
        defaults.delPass(tableView.selectedRow)
        reloadData()
    }
    
}

extension PasswordViewController: NSTableViewDataSource {
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return allPassword.count
    }
}

extension PasswordViewController: NSTableViewDelegate {
    
    func tableView(_ tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        return heightOfRow
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        
        guard let column = tableColumn else { return nil }
        let interfaceItemIdentifier = NSUserInterfaceItemIdentifier(rawValue: "LoginCellView")
        
        if let cell = tableView.makeView(withIdentifier: interfaceItemIdentifier, owner: nil) as? LoginCellView {
            
            if column.identifier.rawValue == "Login" {
                cell.text.stringValue = allPassword[row].login
                return cell
            }
            
            if column.identifier.rawValue == "Password" {
                cell.text.stringValue = allPassword[row].password
                cell.password = true
                return cell
            }
            
            if column.identifier.rawValue == "Site" {
                cell.textField?.stringValue = allPassword[row].site
                return cell
            }
            
        }
        
        return nil
    }
}


