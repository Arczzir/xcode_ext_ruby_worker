//
//  FileChooser.swift
//  XcodeExt
//
//  Created by Z on 2/28/17.
//  Copyright © 2017 Z. All rights reserved.
//

import Cocoa

class FileChooser: NSObject {
    var window: NSWindow!
    func showWindow(runModal: Bool = false) {
        window = NSWindow(contentRect: CGRect(x: 0, y: 0, width: 200, height: 200), styleMask: [.titled, .closable], backing: NSWindow.BackingStoreType.buffered, defer: false)
        
        let closeB = window.standardWindowButton(NSWindow.ButtonType.closeButton)!
        closeB.target = self
        closeB.action = #selector(close)
        
        
        window.center()
        window.setFrameAutosaveName("W")
        window.makeKeyAndOrderFront(nil)
        
        var r = CGRect.zero
        r.origin.y = window.contentView!.bounds.height

        for x in [
//            ("Add .rb File", #selector(chooseRb)),
            ("Open rb Directory", #selector(openDirectory)),
            ] {
                let b = NSButton(title: x.0, target: self, action: x.1)
                b.sizeToFit()
                r.size = b.frame.size
                r.origin.y -= r.height + 10
                b.frame = r
                window.contentView?.addSubview(b)
        }
        
        if runModal {
            DispatchQueue.main.async {
                NSApplication.shared.runModal(for: self.window)
            }
        }
    }
    
    func chooseRb() {
        chooseFile(in: window) { (url) in
            if url.pathExtension == "rb" {
                save(url)
            }
        }
    }
    
    @objc func close() {
        NSApp.terminate(nil)
    }
    
    @objc func openDirectory() {
        NSWorkspace.shared.open(rbDirectory())
    }
    
}
