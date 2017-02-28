//
//  SourceEditorCommand.swift
//  ruby_code_gen
//
//  Created by Z on 2/28/17.
//  Copyright © 2017 z. All rights reserved.
//

import Foundation
import XcodeKit
import Cocoa

class SourceEditorCommand2: NSObject, XCSourceEditorCommand {
    
    func perform(with invocation: XCSourceEditorCommandInvocation, completionHandler: @escaping (Error?) -> Void ) -> Void {
        // Implement your command here, invoking the completion handler when done. Pass it nil on success, and an NSError on failure.
        NSWorkspace.shared().open(rbDirectory())

        completionHandler(nil)
    }
    
}
