//
//  AppDelegate.swift
//  Clip
//
//  Created by Radomyr Sidenko on 31/05/2019.
//  Copyright © 2019 Radomyr Sidenko. All rights reserved.
//

import Cocoa

@NSApplicationMain
final class AppDelegate: NSObject {
    
    private var eventMonitor: EventMonitor?
    private var pasteboardMonitor: PasteboardMonitor?
    
    private let statusItem = NSStatusBar.system.statusItem(withLength:NSStatusItem.squareLength)
    private let popover = NSPopover()
    
    @objc
    private func toggleMenuPopover(_ sender: Any?) {
        
        if popover.contentViewController?.className != getLastVC().className {
            createPopover()
        }
        
        if popover.isShown {
            closePopover(sender)
        } else {
            openPopover()
        }
    }
}

extension AppDelegate: NSApplicationDelegate {
    
    func createPopover() {
        let viewController = getLastVC()
        popover.contentViewController = viewController
    }
    
    func getLastVC() -> NSViewController {
        
        let main = ViewController.instantiateFromStoryboard()
        
        guard let lastVC = DataUserDefaults.instance.lastVC?.first,
            let storyboardName = lastVC.value as? String else { return main }

        let storyboard = NSStoryboard(name: storyboardName, bundle: nil)
        let storyboardIdentifier = NSStoryboard.SceneIdentifier(lastVC.key)
        
        guard let viewController = storyboard
            .instantiateController(withIdentifier: storyboardIdentifier) as? NSViewController else {
            return main
        }
        
        return viewController
    }
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        
        DataUserDefaults.instance.lastVC = nil
        createPopover()
        setupMenuBarButton()
        setupEventMonitor()
        setupPasteboardMonitor()
    }
    
    private func setupMenuBarButton() {
        guard let button = statusItem.button else {
            return
        }
        button.image = NSImage(named: "StatusBarIconImage")
        button.action = #selector(toggleMenuPopover(_:))
    }
    
    private func setupEventMonitor() {
        eventMonitor = EventMonitor(mask: [.leftMouseDown, .rightMouseDown]) { [weak self] event in
            guard let `self` = self else {
                return
            }
            if self.popover.isShown {
                self.closePopover(event)
            }
        }
    }
    
    private func setupPasteboardMonitor() {
        guard (popover.contentViewController as? ViewController) != nil else {
            return
        }
        pasteboardMonitor = PasteboardMonitor()
        pasteboardMonitor?.startPolling()
    }
    
    // MARK: - Utilities
    
    private func openPopover() {
        guard let button = statusItem.button else {
            return
        }
        popover.show(relativeTo: button.bounds, of: button, preferredEdge: .minY)
        eventMonitor?.start()
    }
    
    private func closePopover(_ sender: Any?) {
        popover.performClose(sender)
        eventMonitor?.stop()
    }
}
