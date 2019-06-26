//
//  DataUserDefaults.swift
//  Clip
//
//  Created by Radomyr Sidenko on 13/06/2019.
//  Copyright © 2019 Radomyr Sidenko. All rights reserved.
//

import Foundation

class DataUserDefaults {
    
    static var instance = DataUserDefaults()
    var defaults = UserDefaults.standard
    
    let keyPassword = "Password"
    let keyUserPasswords = "UserPasswords"
   
    var password: String? {
        get {
            return defaults.string(forKey: keyPassword)
        }
        set {
            cleanAll()
            defaults.set(newValue, forKey: keyPassword)
        }
    }

    func getUserPasswords() -> [Password] {
        if let data = defaults.value(forKey: keyUserPasswords) as? Data {
            if let passwords = try?
                PropertyListDecoder()
                    .decode(Array<Password>.self,
                            from: data) {
                return passwords
            }
        }
        return []
    }
    
    func addNewPass(_ password: Password) {
        
        var userPasswords = getUserPasswords()
        userPasswords.append(password)
        setPasswords(userPasswords)
    }
    
    
    private func setPasswords(_ passwords: [Password]) {
        defaults.set(try? PropertyListEncoder().encode(passwords), forKey: keyUserPasswords)
    }
    
    private func cleanAll() {
        setPasswords([])
    }
}
