//
//  AppDelegate.swift
//  xcode_ext_ruby_worker
//
//  Created by Z on 2/28/17.
//  Copyright © 2017 z. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

//    @IBOutlet weak var window: NSWindow!

    var chooseFile: FileChooser!

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        
        _ = try? FileManager.default.createDirectory(at: rbDirectory(), withIntermediateDirectories: true, attributes: nil)
        chooseFile = FileChooser()
        chooseFile.showWindow()
        
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


}

