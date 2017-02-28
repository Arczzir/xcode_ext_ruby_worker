//
//  SourceEditorExtension.swift
//  ruby_code_gen
//
//  Created by Z on 2/28/17.
//  Copyright © 2017 z. All rights reserved.
//

import Foundation
import XcodeKit

class SourceEditorExtension: NSObject, XCSourceEditorExtension {
    
    /*
    func extensionDidFinishLaunching() {
        // If your extension needs to do any work at launch, implement this optional method.
    }
    */
    
    /*
    var commandDefinitions: [[XCSourceEditorCommandDefinitionKey: Any]] {
        // If your extension needs to return a collection of command definitions that differs from those in its Info.plist, implement this optional property getter.
        return []
    }
    */
    
    var commandDefinitions: [[XCSourceEditorCommandDefinitionKey: Any]] {
        var a = [[XCSourceEditorCommandDefinitionKey: Any]]()
        
        a.append([
            .classNameKey: "ruby_code_gen.SourceEditorCommand2",
            .identifierKey: "ruby_code_gen.SourceEditorCommand2",
            .nameKey: "Open rb Directory"
            ]
        )
        if let enumerator = FileManager.default.enumerator(at: rbDirectory(), includingPropertiesForKeys: nil) {
            for item in enumerator {
                if let url = item as? URL {
                    if url.pathExtension == "rb" {
                        a.append([
                            .classNameKey: "ruby_code_gen.SourceEditorCommand",
                            .identifierKey: url.lastPathComponent,
                            .nameKey: url.lastPathComponent
                            ])
                    }
                }
            }
        }
        return a
    }
    
}
