//
//  UserDefaults.swift
//  Clip
//
//  Created by Radomyr Sidenko on 13/06/2019.
//  Copyright © 2019 Radomyr Sidenko. All rights reserved.
//

import Foundation

class DataUserDefaults {
    
    static var password: String? {
        get {
            return UserDefaults.standard.string(forKey: "Password")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "Password")
        }
    }
    
}
