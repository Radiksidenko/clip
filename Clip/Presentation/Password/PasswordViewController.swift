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
    
    private var viewStoryboard: NSStoryboard {
        return NSStoryboard(name: "Main", bundle: nil)
    }
    
    var allPassword: [Password] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        notes.title = "Notes"
        allPassword = DataUserDefaults.instance.getUserPasswords()
        
        tableView.register(NSNib(nibNamed: "LoginCell", bundle: nil),
                           forIdentifier: NSUserInterfaceItemIdentifier(rawValue: "LoginCellView"))
    }
    
    @IBAction func notesClick(_ sender: Any) {
        let vcStores = self.viewStoryboard.instantiateController(withIdentifier: NSStoryboard.SceneIdentifier("ViewController"))
            as! NSViewController
        self.view.window?.contentViewController = vcStores
    }

    @IBAction func addRow(_ sender: Any) {
        if addLogin.isHidden == false {
            let newRow =  Password(login: addLogin.stringValue,
                                   password: addPassword.stringValue,
                                   site: addSite.stringValue)
            DataUserDefaults.instance.addNewPass(newRow)
        }
        
        addLogin.isHidden = !addLogin.isHidden
        addPassword.isHidden = !addPassword.isHidden
        addSite.isHidden = !addSite.isHidden
    }
}

extension PasswordViewController: NSTableViewDataSource {
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return allPassword.count
    }
}

extension PasswordViewController: NSTableViewDelegate {
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        
        guard let column = tableColumn else { return nil }
        
        if let cell = tableView.makeView(withIdentifier: column.identifier, owner: nil) as? NSTableCellView {
            
            if column.identifier.rawValue == "Login" {
                
                let interfaceItemIdentifier = NSUserInterfaceItemIdentifier(rawValue: "LoginCellView")
                
                guard let cel = tableView.makeView(withIdentifier: interfaceItemIdentifier,
                                                   owner: nil) as? LoginCellView else {
                    return nil
                }
                cel.text.stringValue = allPassword[row].login
                return cel
            }
            
            if column.identifier.rawValue == "Password" {
                cell.textField?.stringValue = allPassword[row].password
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


