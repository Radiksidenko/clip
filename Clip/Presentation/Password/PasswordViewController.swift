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
    
    let makes = ["Ford", "Subaru", "Ford", "Toyota", "Chevy", "Subaru", "Ford"]
    let models = ["Mustang", "Forester", "Bronco", "Tacoma", "Blazer", "Outback", "Ranger"]
    let years = [2018, 2011, 1977, 1994, 1991, 2001, 1998]
    override func viewDidLoad() {
        super.viewDidLoad()
        notes.title = "Notes"
        tableView.register(NSNib(nibNamed: "LoginCell", bundle: nil),
                           forIdentifier: NSUserInterfaceItemIdentifier(rawValue: "LoginCellView"))
    }
    
    @IBAction func notesClick(_ sender: Any) {
        let vcStores = self.viewStoryboard.instantiateController(withIdentifier: NSStoryboard.SceneIdentifier("ViewController"))
            as! NSViewController
        self.view.window?.contentViewController = vcStores
    }
    private var viewStoryboard: NSStoryboard {
        return NSStoryboard(name: "Main", bundle: nil)
    }
    
}

extension PasswordViewController: NSTableViewDataSource {
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return makes.count
    }
}

extension PasswordViewController: NSTableViewDelegate {
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        
        guard let column = tableColumn else { return nil }
        
        if let cell = tableView.makeView(withIdentifier: column.identifier, owner: nil) as? NSTableCellView {
            
            if column.identifier.rawValue == "Login" {
                guard let cel = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "LoginCellView"), owner: nil) as? LoginCellView else {
                    return nil
                }
                cel.text.stringValue = makes[row]
                return cel
            }
            
            if column.identifier.rawValue == "Password" {
                cell.textField?.stringValue = models[row]
                return cell
            }
            
            if column.identifier.rawValue == "Site" {
                cell.textField?.stringValue = "\(years[row])"
                return cell
            }
            
        }
        
        return nil
    }
}


