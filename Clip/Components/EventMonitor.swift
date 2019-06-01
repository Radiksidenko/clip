//
//  EventMonitor.swift
//  Clip
//
//  Created by Radomyr Sidenko on 31/05/2019.
//  Copyright © 2019 Radomyr Sidenko. All rights reserved.
//

import Cocoa

public class EventMonitor {
    
    // MARK: - Properties
    
    private var monitor: Any?
    private let mask: NSEvent.EventTypeMask
    private let handler: (NSEvent?) -> Void
    
    // MARK: - Initialization
    
    init(mask: NSEvent.EventTypeMask, handler: @escaping (NSEvent?) -> Void) {
        self.mask = mask
        self.handler = handler
    }
    
    deinit {
        stop()
    }
    
    // MARK: - Actions
    
    public func start() {
        monitor = NSEvent.addGlobalMonitorForEvents(matching: mask, handler: handler)
    }
    
    public func stop() {
        guard let monitor = monitor else {
            return
        }
        
        NSEvent.removeMonitor(monitor)
        self.monitor = nil
    }
}
