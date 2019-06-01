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
    @IBOutlet weak var tableView: NSTableView!
    
    let makes = ["Ford", "Subaru", "Ford", "Toyota", "Chevy", "Subaru", "Ford"]
    let models = ["Mustang", "Forester", "Bronco", "Tacoma", "Blazer", "Outback", "Ranger"]
    let years = [2018, 2011, 1977, 1994, 1991, 2001, 1998]
    
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
                cell.textField?.stringValue = makes[row]
                return cell
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


