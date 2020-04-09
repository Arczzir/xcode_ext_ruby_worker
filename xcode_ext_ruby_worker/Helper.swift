//
//  Helper.swift
//  XcodeExt
//
//  Created by Z on 2/28/17.
//  Copyright © 2017 Z. All rights reserved.
//

import Cocoa

func documentDirectory() -> URL {
    return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
}

func userDefault() -> UserDefaults {
    let sharedDefaults = UserDefaults(suiteName: "com.z.codegen")
    return sharedDefaults!
}

func sharedDirectory() -> URL {
    let containerURL = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "com.z.codegen")
    return containerURL!
}

func rbDirectory() -> URL {
    return sharedDirectory().appendingPathComponent("rb")
}

func save(_ url: URL) {
    let dest = sharedDirectory().appendingPathComponent(url.lastPathComponent)
    _ = try? FileManager.default.copyItem(at: url, to: dest)
}

func chooseFile(in window: NSWindow, block: @escaping (URL) -> Void) {
    let panel = NSOpenPanel()
    panel.canChooseFiles = true
    panel.allowsMultipleSelection = false
    
    panel.beginSheetModal(for: window) { op in
        switch op {
        case .OK:
            if let url = panel.urls.first {
                block(url)
            }
        default:
            break
        }
    }
}

