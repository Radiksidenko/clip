//
//  NSViewController+Storyboard.swift
//  Clip
//
//  Created by Radomyr Sidenko on 31/05/2019.
//  Copyright © 2019 Radomyr Sidenko. All rights reserved.
//

import Cocoa

extension NSViewController {
    
    static func instantiateFromStoryboard() -> NSViewController {
        guard let viewController = storyboard.instantiateController(withIdentifier: storyboardIdentifier) as? NSViewController else {
            return NSViewController()
        }
        return viewController
    }
    
    private static var storyboard: NSStoryboard {
        return NSStoryboard(name: "Main", bundle: nil)
    }
    
    private static var storyboardIdentifier: String {
        return NSStoryboard.SceneIdentifier(describing: self)
    }
}
