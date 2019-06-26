//
//  Passwords.swift
//  Clip
//
//  Created by Radomyr Sidenko on 13/06/2019.
//  Copyright © 2019 Radomyr Sidenko. All rights reserved.
//

struct Password: Codable {
    let login: String
    let password: String
    let site: String
}

enum Screens {
    case ViewController(ViewController)
    case PasswordViewController(PasswordViewController)
}
